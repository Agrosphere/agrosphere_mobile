import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/chat.dart';
import 'package:late_blight/utils/enums.dart';

class ChatWithOther {
  Map<String, List<ChatModel>> chatMap;
  RequestState requestState;
  Map<String, String> chatOlderdate = {};
  Map<String, bool> refetch = {};
  RequestState requestStateForOlderChats = RequestState.idel;
  ChatWithOther({
    required this.chatMap,
    this.requestState = RequestState.idel,
    this.chatOlderdate = const {},
    this.refetch = const {},
    this.requestStateForOlderChats = RequestState.idel,
  });
  ChatWithOther copyWith(
      {Map<String, List<ChatModel>>? chatMap,
      RequestState? requestState,
      Map<String, String>? chatOlderdate,
      Map<String, bool>? refetch,
      RequestState? requestStateForOlderChats}) {
    return ChatWithOther(
      chatMap: chatMap ?? this.chatMap,
      requestState: requestState ?? this.requestState,
      chatOlderdate: chatOlderdate ?? this.chatOlderdate,
      refetch: refetch ?? this.refetch,
      requestStateForOlderChats:
          requestStateForOlderChats ?? this.requestStateForOlderChats,
    );
  }
}

class ChatwithotherBloc extends Cubit<ChatWithOther> {
  ChatwithotherBloc() : super(ChatWithOther(chatMap: {}));
  void addChat(String chatId, ChatModel chat) {
    final chatList = state.chatMap[chatId] ?? [];
    chatList.add(chat);
    emit(state.copyWith(
      chatMap: {
        ...state.chatMap,
        chatId: chatList,
      },
    ));
  }

  void startChat(String chatId) {
    emit(state.copyWith(
      chatMap: {
        ...state.chatMap,
        chatId: [],
      },
    ));
  }

  void _handleForEmptyChat(String receiverId) {
    //we don't need to update the chatMap
    // and make the refetch condition false for the user
    final chats = state.chatMap[receiverId];
    if (chats != null || chats!.isNotEmpty) {
      final oldDate = chats.first.time;
      emit(state.copyWith(
        requestStateForOlderChats: RequestState.success,
        chatOlderdate: {
          ...state.chatOlderdate,
          receiverId: oldDate,
        },
        refetch: {
          ...state.refetch,
          receiverId: false,
        },
      ));
    } else {
      emit(state.copyWith(
        requestStateForOlderChats: RequestState.success,
        refetch: {
          ...state.refetch,
          receiverId: false,
        },
      ));
    }
    return;
  }

  void getOldChats(String receiverId) async {
    //fetch previous chat or create new chat
    //check for the already fetched chat

    //check for the refetch condition
    if (!state.refetch[receiverId]!) {
      return;
    }

    if (state.requestStateForOlderChats != RequestState.idel) {
      return;
    }
    emit(state.copyWith(requestStateForOlderChats: RequestState.loading));
    try {
      final response = await API.getWithFullUrl(
          "${Config.chatApiUrl}chat/history/$receiverId",
          queryParameters: {
            "date": state.chatOlderdate[receiverId],
          });

      final List<ChatModel> chatList = List.from(
          response.data['chats'].map((json) => ChatModel.fromJson(json)));
      //check if the chatList is empty
      //then there is no chat history available for the user then we don't need to update the chatMap
      // and make the refetch condition false for the user
      if (chatList.isEmpty) {
        _handleForEmptyChat(receiverId);
        return;
      }
      // print(chatList.first.time);
      // print(chatList.last.time);
      final chats = [...chatList, ...state.chatMap[receiverId]!];
      //remove the duplicate chat using the set
      final chatSet = Set<ChatModel>.from(chats);
      // print(chatSet.first.time);
      // print(chatSet.last.time);
      emit(state.copyWith(
        chatMap: {
          ...state.chatMap,
          receiverId: List.from(chatSet),
        },
        chatOlderdate: {
          ...state.chatOlderdate,
          receiverId: chatSet.first.time,
        },
        refetch: {
          ...state.refetch,
          receiverId: true,
        },
        requestStateForOlderChats: RequestState.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        requestStateForOlderChats: RequestState.fail,
      ));
    } finally {
      emit(state.copyWith(
        requestStateForOlderChats: RequestState.idel,
      ));
    }
  }

  void getLatestChat(String receiverId) async {
    //fetch previous chat or create new chat
    //check for the already fetched chat
    emit(state.copyWith(requestState: RequestState.loading));
    try {
      final response = await API.getWithFullUrl(
        "${Config.chatApiUrl}chat/history/$receiverId",
      );
      final List<ChatModel> chatList = List.from(response.data['chats'].map(
        (json) => ChatModel.fromJson(json),
      ));

      //check if the chatList is empty
      //then there is no chat history available for the user then we don't need to update the chatMap
      // and make the refetch condition false for the user
      if (chatList.isEmpty) {
        _handleForEmptyChat(receiverId);
        return;
      }

      emit(state.copyWith(
        chatMap: {
          ...state.chatMap,
          receiverId: chatList,
        },
        chatOlderdate: {
          ...state.chatOlderdate,
          receiverId: chatList.first.time,
        },
        refetch: {
          ...state.refetch,
          receiverId: true,
        },
        requestState: RequestState.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        chatMap: {
          ...state.chatMap,
          receiverId: [],
        },
        requestState: RequestState.fail,
      ));
    }
  }

  void clearChat(String userId) {
    emit(state.copyWith(
      chatMap: {
        ...state.chatMap,
        userId: [],
      },
    ));
  }
}
