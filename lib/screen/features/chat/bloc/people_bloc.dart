import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/utils/enums.dart';

class PeopleStateModel {
  RequestState requestState;
  String errorMessage;
  List<User> peopleList;
  int statusCode;
  PeopleStateModel({
    this.requestState = RequestState.idel,
    this.errorMessage = "",
    this.peopleList = const [],
    this.statusCode = 200,
  });
  PeopleStateModel copyWith({
    RequestState? requestState,
    String? errorMessage,
    List<User>? peopleList,
    int? statusCode,
  }) {
    return PeopleStateModel(
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
      peopleList: peopleList ?? this.peopleList,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}

class PeopleChatBloc extends Cubit<PeopleStateModel> {
  PeopleChatBloc() : super(PeopleStateModel());

  void getPeopleList({bool isRefetch = false}) async {
    if (!isRefetch) {
      if (state.peopleList.isNotEmpty) {
        emit(state.copyWith(requestState: RequestState.success));
        return;
      }
      emit(state.copyWith(requestState: RequestState.loading));
    }
    try {
      // Fetch people list from the server
      final response = await _fetchPeopleList();
      final List<User> peopleList = List.from(response.data['users'].map(
        (json) => User.fromJson(json),
      ));
      emit(state.copyWith(
        requestState: RequestState.success,
        peopleList: peopleList,
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

  Future<Response<dynamic>> _fetchPeopleList() async {
    return await API.getWithFullUrl("${Config.userApiUrl}user/all");
  }
}
