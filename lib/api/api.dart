import 'package:dio/dio.dart' as dio;
import 'package:late_blight/config/config.dart';
import 'package:late_blight/utils/enums.dart';

class API {
  static final client = dio.Dio();

  static String getUrl(String endPoint) {
    return Config.getApi(endPoint);
  }

  static Future<dio.Response> get(String endPoint,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    // print(Config.accessToken);
    return await getWithFullUrl(
      getUrl(endPoint),
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  static Future<dio.Response> getWithFullUrl(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters,
      dio.ResponseType? responseType}) async {
    // print(Config.accessToken);
    return await API.client.get(url,
        queryParameters: queryParameters,
        options: dio.Options(
          responseType: responseType,
          headers: {
            'Authorization': 'Bearer ${Config.accessToken}',
            // 'api-key': Config.apikey,
            ...?headers
          },
        ));
  }

  static Future<dio.Response> request(
    String endPoint,
    RequestMethod method, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return requestWithFullUrl(
      API.getUrl(endPoint),
      method,
      headers: headers,
      body: body,
    );
  }

  static Future<dio.Response> requestWithFullUrl(
    String url,
    RequestMethod method, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    switch (method) {
      case RequestMethod.post:
        client.options.connectTimeout = const Duration(seconds: 5);
        client.options.receiveTimeout = const Duration(seconds: 5);
        return await API.client.post(
          url,
          data: body,
          options: dio.Options(headers: {
            'Authorization': 'Bearer ${Config.accessToken}',
            'appid': Config.apikey,
            ...?headers
          }),
        );
      case RequestMethod.delete:
        return await API.client.delete(
          url,
          data: body,
          options: dio.Options(headers: {
            'Authorization': 'Bearer ${Config.accessToken}',
            'appid': Config.apikey,
            ...?headers
          }),
        );
      case RequestMethod.patch:
        return await API.client.patch(
          url,
          data: body,
          options: dio.Options(headers: {
            'Authorization': 'Bearer ${Config.accessToken}',
            'appid': Config.apikey,
            ...?headers
          }),
        );
      default:
        return await API.client.post(
          url,
          data: body,
          options: dio.Options(headers: {
            'Authorization': 'Bearer ${Config.accessToken}',
            'appid': Config.apikey,
            ...?headers
          }),
        );
    }
  }
}
