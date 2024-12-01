import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/utils/enums.dart';

class ChatWithState {
  List<User> users;
  RequestState requestState;
  String errorMessage;
  int statusCode;
  ChatWithState({
    this.users = const [],
    this.requestState = RequestState.idel,
    this.errorMessage = "",
    this.statusCode = 200,
  });
  ChatWithState copyWith({
    List<User>? users,
    RequestState? requestState,
    String? errorMessage,
    int? statusCode,
  }) {
    return ChatWithState(
      statusCode: statusCode ?? this.statusCode,
      users: users ?? this.users,
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ChatWithBloc extends Cubit<ChatWithState> {
  ChatWithBloc() : super(ChatWithState());

  Future<Response<dynamic>> _fetchUsers() async {
    final url = '${Config.chatApiUrl}chat/get_users';
    return await API.getWithFullUrl(
      url,
      headers: {
        'Authorization': 'Bearer ${Config.accessToken}',
      },
    );
  }

  void getUsers({bool isRefetch = false}) async {
    if (!isRefetch) {
      if (state.users.isNotEmpty) {
        emit(state.copyWith(requestState: RequestState.success));
        return;
      }
      emit(state.copyWith(requestState: RequestState.loading));
    }

    try {
      // Fetch users from the server
      final response = await _fetchUsers();
      final List<User> users = List.from(response.data['users'].map(
        (json) => User.fromJson(json),
      ));
      emit(state.copyWith(
        requestState: RequestState.success,
        users: users,
      ));
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        emit(state.copyWith(
          requestState: RequestState.fail,
          errorMessage: "Server error",
        ));
        return;
      }
      final message = e.response!.data['error'];
      if (!isRefetch) {
        emit(state.copyWith(
          requestState: RequestState.fail,
          errorMessage: message,
          statusCode: e.response!.statusCode,
        ));
      }
    } catch (e) {
      if (!isRefetch) {
        emit(state.copyWith(
          requestState: RequestState.fail,
          errorMessage: "Something went wrong",
        ));
      }
    }
  }
}
