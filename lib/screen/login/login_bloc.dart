import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/auth.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/shared_prefs.dart';
import 'package:late_blight/utils/enums.dart';

class LoginBlocModelState {
  AuthUser user;
  String? message;
  User? loggedInUser;
  RequestState requestState;
  bool isValid;

  LoginBlocModelState({
    required this.user,
    this.message,
    required this.requestState,
    required this.isValid,
    this.loggedInUser,
  });

  LoginBlocModelState logout() {
    return LoginBlocModelState(
      user: AuthUser(
        password: "",
        phone: "",
      ),
      loggedInUser: null,
      requestState: RequestState.idel,
      message: "",
      isValid: false,
    );
  }

  LoginBlocModelState copyWith(
      {AuthUser? user,
      String? message,
      RequestState? requestState,
      User? loggedInUser,
      bool? isValid}) {
    return LoginBlocModelState(
      user: user ?? this.user,
      loggedInUser: loggedInUser ?? this.loggedInUser,
      message: message ?? this.message,
      requestState: requestState ?? this.requestState,
      isValid: isValid ?? this.isValid,
    );
  }
}

class LoginBloc extends Cubit<LoginBlocModelState> {
  LoginBloc()
      : super(
          LoginBlocModelState(
            loggedInUser: null,
            user: AuthUser(
              password: "",
              phone: "",
            ),
            requestState: RequestState.idel,
            message: "",
            isValid: false,
          ),
        );
  updatePhone(String phone) {
    emit(
      state.copyWith(
        user: state.user.copyWith(phone: phone),
      ),
    );
    emit(state.copyWith(
      isValid: _isValid(),
    ));
  }

  updateEmail(String phone) {
    emit(
      state.copyWith(
        user: state.user.copyWith(phone: phone),
      ),
    );
    emit(state.copyWith(
      isValid: _isValid(),
    ));
  }

  updatePassword(String password) {
    emit(
      state.copyWith(
        user: state.user.copyWith(password: password),
        isValid: _isValid(),
      ),
    );
  }

  void setLoggedInUser(User? user) {
    emit(state.copyWith(loggedInUser: user));
  }

  void logout() async {
    await YajnaKrishiSharePrefs.saveUser(null);
    emit(state.logout());
  }

  void idel() {
    emit(state.copyWith(requestState: RequestState.idel));
  }

  bool _isValid() {
    return state.user.phone.length == 10 && state.user.password.length >= 4;
  }

  void login() async {
    emit(state.copyWith(requestState: RequestState.loading));
    try {
      final data = await API.requestWithFullUrl(
          "${Config.userApiUrl}login/", RequestMethod.post,
          body: {
            "email": state.user.phone,
            "password": state.user.password,
          });

      final user = User.fromJson(data.data['user']);
      emit(
        state.copyWith(requestState: RequestState.success, loggedInUser: user),
      );
    } on DioException catch (e) {
      final message = e.response!.data['detail']['error'];
      emit(state.copyWith(
        requestState: RequestState.fail,
        message: message,
      ));
    } catch (e) {
      if (e is SocketException) {
        emit(
          state.copyWith(
            requestState: RequestState.fail,
            message: "Network error",
          ),
        );
        return;
      } else {
        emit(state.copyWith(
          requestState: RequestState.fail,
          message: e.toString(),
        ));
      }
    }
  }

  void updateProfile(String profile) {
    emit(state.copyWith(
      loggedInUser: state.loggedInUser!.copyWith(profile: profile),
    ));
    _saveUpdate();
  }

  void updateCoverPicture(String profile) {
    emit(state.copyWith(
      loggedInUser: state.loggedInUser!.copyWith(coverPicture: profile),
    ));
    _saveUpdate();
  }

  void updateName(String firstName, String lastName) {
    emit(state.copyWith(
      loggedInUser: state.loggedInUser!
          .copyWith(firstname: firstName, lastname: lastName),
    ));
    _saveUpdate();
  }

  void refreshUser() async {
    try {
      final url = "${Config.userApiUrl}user/";
      final response = await API.getWithFullUrl(url);
      final user = User.fromJson(response.data);
      user.accessToken = state.loggedInUser!.accessToken;
      setLoggedInUser(user);
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          logout();
        }
      }
    }
  }

  void _saveUpdate() {
    YajnaKrishiSharePrefs.saveUser(state.loggedInUser);
  }
}
