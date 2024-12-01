import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:web_socket_channel/io.dart';

Future<int> checkUserTokenIsExpired(String acccessToken) async {
  return await Isolate.run(() async {
    //check user token
    try {
      final response = await API
          .getWithFullUrl("${Config.userApiUrl}user/verify/token", headers: {
        "Authorization": "Bearer $acccessToken",
      });
      return response.statusCode!;
    } on DioException catch (e) {
      return e.response!.statusCode!;
    } catch (e) {
      return 500;
    }
  });
}

class UserService {
  static void _updateInfo(Map<String, dynamic> map) async {
    final sendPort = map['port'] as SendPort;
    final body = map['body'] as Map<String, dynamic>;
    final accessToken = map['accessToken'] as String;
    final url = map['url'] as String;

    try {
      final response = await API.requestWithFullUrl(
        url,
        RequestMethod.patch,
        body: jsonEncode(body),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );
      sendPort.send(response);
    } on DioException catch (e) {
      sendPort.send(e);
    } catch (e) {
      sendPort.send(e.toString());
    }
  }

  static Future<dynamic> updateInfo(Map<String, dynamic> body, String url) {
    //upload file to server and update user profile picture
    ReceivePort receivePort = ReceivePort();
    Completer completer = Completer();
    Isolate.spawn(
        _updateInfo,
        Map.fromEntries([
          MapEntry("port", receivePort.sendPort),
          MapEntry("accessToken", Config.accessToken),
          MapEntry("body", body),
          MapEntry("url", url),
        ]));

    receivePort.listen((message) {
      completer.complete(message);
    })
      ..onDone(() {
        receivePort.close();
        completer.complete(null);
      })
      ..onError((error) {
        debugPrint(error);
        completer.completeError(error);
        receivePort.close();
      });
    return completer.future;
  }

  static void _changeProfile(Map<String, dynamic> map) async {
    final sendPort = map['port'] as SendPort;
    final file = map['file'] as File;
    final accessToken = map['accessToken'] as String;
    final url = map['url'] as String;
    final field = map['field'] as String;

    final formData = FormData.fromMap({
      field: await MultipartFile.fromFile(file.path),
    });

    try {
      final response = await API.requestWithFullUrl(
        url,
        RequestMethod.patch,
        body: formData,
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );
      sendPort.send(response.data);
    } on DioException catch (e) {
      debugPrint(e.response!.data.toString());
      sendPort.send(e.response!.data);
    } catch (e) {
      sendPort.send(e.toString());
    }
  }

  static Future<dynamic> uploadPicture(File file, String field, String url) {
    //upload file to server and update user profile picture
    ReceivePort receivePort = ReceivePort();
    Completer completer = Completer();
    Isolate.spawn(
        _changeProfile,
        Map.fromEntries([
          MapEntry("port", receivePort.sendPort),
          MapEntry("file", file),
          MapEntry("accessToken", Config.accessToken),
          MapEntry("url", url),
          MapEntry("field", field),
        ]));

    receivePort.listen((message) {
      completer.complete(message);
    })
      ..onDone(() {
        receivePort.close();
        completer.complete(null);
      })
      ..onError((error) {
        debugPrint(error);
        completer.completeError(error);
        receivePort.close();
      });
    return completer.future;
  }
}

class ActiveUserBackgroundService {
  final ReceivePort receivePort = ReceivePort();
  final Function(String message) onMessageReceived;

  ActiveUserBackgroundService({required this.onMessageReceived});
  static void _backgroundService(Map<String, dynamic> map) {
    final channel = IOWebSocketChannel.connect(
      Uri.parse("${Config.webSocketChatApiUrl}ws/active_users"),
      headers: {
        "Authorization": "Bearer ${map['accessToken']}",
      },
    );
    final sendPort = map['port'] as SendPort;

    channel.stream.listen(
      (message) {
        sendPort.send(message.toString());
      },
      onDone: () {
        channel.sink.close();
      },
      onError: (error) {
        sendPort.send('Error: $error');
      },
    );
  }

  void start(String accessToken) async {
    await Isolate.spawn(
      _backgroundService,
      Map.fromEntries([
        MapEntry("port", receivePort.sendPort),
        MapEntry("accessToken", accessToken)
      ]),
    );
    receivePort.listen((message) {
      onMessageReceived(message);
    });
  }

  void stop() {
    receivePort.close();
  }
}
