import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/utils/enums.dart';

class RegisterState {
  User user;
  RequestState requestState;
  String message;
  RegisterState(
      {required this.user, required this.requestState, required this.message});
  RegisterState copyWith(
      {User? user, RequestState? requestState, String? message}) {
    return RegisterState(
      user: user ?? this.user,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
    );
  }
}

class RegisterBloc extends Cubit<RegisterState> {
  RegisterBloc()
      : super(
          RegisterState(
            user: User(firstname: "", lastname: "", email: ""),
            requestState: RequestState.idel,
            message: "",
          ),
        );

  void updateFirstName(String firstname) {
    emit(state.copyWith(
      user: state.user.copyWith(firstname: firstname),
    ));
  }

  void updateLastName(String lastname) {
    emit(state.copyWith(
      user: state.user.copyWith(lastname: lastname),
    ));
  }

  void updatePhone(String phone) {
    emit(state.copyWith(
      user: state.user.copyWith(phone: phone),
    ));
  }

  void updateEmail(String email) {
    emit(state.copyWith(
      user: state.user.copyWith(email: email),
    ));
  }

  void updatePassword(String password) {
    emit(state.copyWith(
      user: state.user.copyWith(password: password),
    ));
  }

  void updateConfirmPassword(String confirmPassword) {
    emit(state.copyWith(
      user: state.user.copyWith(confirmPassword: confirmPassword),
    ));
  }

  void idel() {
    emit(state.copyWith(requestState: RequestState.idel));
  }

  void register() async {
    if (state.requestState == RequestState.loading) return;
    emit(state.copyWith(requestState: RequestState.loading));
    try {
      final data = await API.requestWithFullUrl(
          "${Config.userApiUrl}user/", RequestMethod.post,
          body: {
            "first_name": state.user.firstname,
            "last_name": state.user.lastname,
            "email": state.user.email,
            "password": state.user.password
          });
      if (data.statusCode != 201) {
        emit(state.copyWith(
          requestState: RequestState.fail,
          message: "केही त्रुटि भयो",
        ));
      } else {
        final user = User.fromJson(data.data['user']);
        emit(
          state.copyWith(
            requestState: RequestState.success,
            user: user,
          ),
        );
      }
    } on DioException catch (e) {
      final details = e.response?.data['detail'];
      var message = "";
      for (final detail in details) {
        message += detail['msg'] + "\n";
      }

      emit(state.copyWith(
        requestState: RequestState.fail,
        message: message,
      ));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        requestState: RequestState.fail,
        message: e.toString(),
      ));
    }
  }
}
