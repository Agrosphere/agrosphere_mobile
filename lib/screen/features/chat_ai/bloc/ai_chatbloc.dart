import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class Message {
  String data;

  String id;
  Message({required this.data, required this.id});

  // CopyWith method
  Message copyWith({String? data, String? id}) {
    return Message(
      data: data ?? this.data,
      id: id ?? this.id,
    );
  }
}

class AiChatModel {
  ChatAI krishiSathiState;
  List<Message> messages;

  AiChatModel({
    required this.krishiSathiState,
    required this.messages,
  });
  AiChatModel copyWith({
    ChatAI? krishiSathiState,
    List<Message>? messages,
  }) {
    return AiChatModel(
      messages: messages ?? this.messages,
      krishiSathiState: krishiSathiState ?? this.krishiSathiState,
    );
  }
}

class AiChatbloc extends Cubit<AiChatModel> {
  AiChatbloc()
      : super(AiChatModel(
          krishiSathiState: ChatAI.idel,
          messages: [],
        ));

  void changeState(ChatAI trekmateState) {
    emit(state.copyWith(krishiSathiState: trekmateState));
  }

  void send(String message, WebSocketChannel channel) {
    final jsonData = {"message": message, "userId": 1};

    // Convert JSON data to a string
    final jsonString = jsonEncode(jsonData);
    final data = state.messages;
    data.insert(0, Message(data: message, id: "current_user"));
    channel.sink.add(jsonString); //send to the server
    emit(state.copyWith(messages: data, krishiSathiState: ChatAI.thinking));
  }

  void fromServer(dynamic message) {
    final json = jsonDecode(message);
    String messageResponse = json["message"];
    final data = state.messages;
    data.insert(
        0,
        Message(
          data: messageResponse,
          id: "bot",
        ));
    emit(state.copyWith(messages: data, krishiSathiState: ChatAI.connected));
  }
}
