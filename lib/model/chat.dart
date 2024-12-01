import 'package:late_blight/utils/enums.dart';

class ChatModel {
  String chatId;
  String senderId;
  String receiverId;
  String message;
  String? parentId;
  String time;
  String type;
  // ChatStatus status;
  ChatModel({
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.parentId,
    required this.time,
    required this.type,
    // required this.status,
  });
  ChatModel copyWith({
    String? senderId,
    String? receiverId,
    String? message,
    String? parentId,
    String? time,
    String? type,
    ChatStatus? status,
  }) {
    return ChatModel(
      chatId: chatId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      parentId: parentId ?? this.parentId,
      time: time ?? this.time,
      type: type ?? this.type,
      // status: status ?? this.status,
    );
  }

  ChatModel.fromJson(Map<String, dynamic> json)
      : senderId = json['senderId'],
        chatId = json.containsKey("_id") ? json['_id'] : "",
        receiverId = json['receiverId'],
        message = json['message'] ?? "",
        parentId = json['parentId'],
        time = json['created_at'],
        type = json['type'] ?? "text";

  // status = ChatStatus.values[json['status']];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.chatId == chatId; // Compare by unique identifier
  }

  @override
  int get hashCode => chatId.hashCode; // Hash based on the unique identifier
}
