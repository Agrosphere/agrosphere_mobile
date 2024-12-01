import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/utils/enums.dart';

class News {
  List<Map<String, dynamic>> newsList;
  List<Map<String, dynamic>> latest;
  RequestState requestState;
  bool reachedLimit;
  int page;
  String message = '';
  News({
    required this.newsList,
    required this.requestState,
    this.reachedLimit = false,
    this.page = 1,
    this.message = '',
    this.latest = const [],
  });

  News copyWith(
      {List<Map<String, dynamic>>? newsList,
      RequestState? requestState,
      bool? reachedLimit,
      int? page,
      String? message,
      List<Map<String, dynamic>>? latest}) {
    return News(
      newsList: newsList ?? this.newsList,
      requestState: requestState ?? this.requestState,
      reachedLimit: reachedLimit ?? this.reachedLimit,
      page: page ?? this.page,
      message: message ?? this.message,
      latest: latest ?? this.latest,
    );
  }
}

class NewsBloc extends Cubit<News> {
  NewsBloc() : super(News(newsList: [], requestState: RequestState.idel));

  Future<Response<dynamic>> _fetch(
    int page, {
    String source = 'all',
  }) async {
    final url = "${Config.newsApiUrl}news";
    final response = await API.getWithFullUrl(url, queryParameters: {
      'page': page,
      'source': source,
    });
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to fetch news');
      }
    } catch (e) {
      rethrow;
    }
  }

  void setPage(int page) {
    emit(state.copyWith(page: page, newsList: [], reachedLimit: false));
  }

  void notify() {
    emit(state);
  }

  void getNews({bool getMore = false, String source = 'all'}) async {
    if (state.requestState == RequestState.loading) return;
    if (!getMore) {
      emit(state.copyWith(requestState: RequestState.loading));
    } else {
      if (state.reachedLimit) return;
    }

    try {
      final response = await _fetch(state.page, source: source);
      final news = List<Map<String, dynamic>>.from(
        response.data['news'].map((e) => e as Map<String, dynamic>),
      );
      final latest = List<Map<String, dynamic>>.from(
        response.data['latest'].map((e) => e as Map<String, dynamic>),
      );

      if (news.isEmpty) {
        emit(state.copyWith(
          requestState: RequestState.success,
          reachedLimit: true,
        ));
      } else {
        emit(state.copyWith(
          newsList: List.from(<dynamic>{...state.newsList, ...news}),
          latest: List.from({...state.latest, ...latest}),
          requestState: RequestState.success,
          page: state.page + 1,
          reachedLimit: false,
        ));
      }
    } catch (e) {
      // debugPrint(e.toString());
      if (!getMore && state.newsList.isEmpty) {
        emit(state.copyWith(
          requestState: RequestState.fail,
          message: 'Failed to fetch news',
        ));
      }
    }
  }
}
