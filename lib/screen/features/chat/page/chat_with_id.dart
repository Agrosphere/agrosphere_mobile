import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/chat.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/screen/account/widgets/user_profile.dart';
import 'package:late_blight/screen/features/chat/bloc/chatwithother_bloc.dart';
import 'package:late_blight/screen/features/chat/bloc/typing_bloc.dart';
import 'package:late_blight/screen/features/chat/widget/chat_content.dart';
import 'package:late_blight/screen/features/chat/widget/chat_input.dart';
import 'package:late_blight/screen/features/chat/widget/render_message.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatWithId extends StatefulWidget {
  final User currentUser;
  final User otherUser;
  const ChatWithId({
    super.key,
    required this.currentUser,
    required this.otherUser,
  });

  @override
  State<ChatWithId> createState() => _ChatWithIdState();
}

class _ChatWithIdState extends State<ChatWithId> {
  WebSocketChannel? _channel;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<ChatModel?> replayTo = ValueNotifier(null);
  final Map<String, GlobalKey> keys = {};
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<ChatModel> _chatList = [];
  final PageStorageBucket bucket = PageStorageBucket();
  @override
  void initState() {
    super.initState();
    initChat();
    latestChat();
    _scrollController.addListener(handleScroll);
  }

  void handleScroll() {
    if (_scrollController.position.pixels.toInt() >=
        _scrollController.position.maxScrollExtent.toInt() - 300) {
      Future.delayed(const Duration(seconds: 2), () {});
      oldChat();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      }
    });
  }

  void initChat() {
    //fetch previous chat or create new chat
    final token = "Bearer ${Config.accessToken}";
    try {
      _channel = IOWebSocketChannel.connect(
          Uri.parse(
              "${Config.webSocketChatApiUrl}ws/chat/${widget.otherUser.id}"),
          headers: {
            "Authorization": token,
          });
      _channel!.stream.listen((event) {
        final json = jsonDecode(event);
        final hasInteract = json.containsKey("interact");
        if (hasInteract && json["interact"] != "") {
          //handle typing interaction
          if (mounted) {
            context.read<TypingBloc>().setTyping(
                  json["interact"],
                  json["senderId"],
                );
          }
        } else {
          final chat = ChatModel.fromJson(json);
          if (mounted) {
            context
                .read<ChatwithotherBloc>()
                .addChat(widget.otherUser.id!, chat);
            context.read<TypingBloc>().setTyping("", widget.otherUser.id!);
          }
          _scrollToBottom();
        }
      });
    } on WebSocketChannelException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error connecting to chat");
      // print(e);
    }
  }

  void oldChat() {
    context.read<ChatwithotherBloc>().getOldChats(widget.otherUser.id!);
  }

  void latestChat({String? dateTime}) {
    context.read<ChatwithotherBloc>().getLatestChat(widget.otherUser.id!);
  }

  void findAndScroll(ChatModel chat) {
    final key = keys[chat.parentId];
    if (key != null) {
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        final appBarSize = kToolbarHeight;
        _scrollController.animateTo(
          (position.dy - appBarSize).abs(),
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      }
    }
  }

  void updateChatList(List<ChatModel> newChat) {
    for (int i = 0; i < newChat.length; i++) {
      if (_chatList.length <= i || _chatList[i].chatId != newChat[i].chatId) {
        _chatList.insert(i, newChat[i]);
        _listKey.currentState?.insertItem(i);
      }
    }

    // Remove extra items if necessary
    for (int i = _chatList.length - 1; i >= newChat.length; i--) {
      _chatList.removeAt(i);
      _listKey.currentState?.removeItem(i, (context, animation) => SizedBox());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.black,
        backgroundColor: Colors.indigoAccent,
        leadingWidth: 21,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Icon(
              Icons.arrow_back,
              size: 18,
            ),
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserProfile(
              user: widget.otherUser,
              isVisitor: true,
              size: Size(36, 36),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${widget.otherUser.firstname} ${widget.otherUser.lastname}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                BlocBuilder<TypingBloc, Map<String, String>>(
                  builder: (context, state) {
                    if (state.isNotEmpty) {
                      return Text(
                        state.containsKey(widget.otherUser.id!)
                            ? state[widget.otherUser.id!] ?? ""
                            : "",
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            )
          ],
        ),
      ),
      body: PageStorage(
        bucket: bucket,
        child: Container(
          color: Colors.indigoAccent,
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  shrinkWrap: true,
                  reverse: true,
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        BlocBuilder<ChatwithotherBloc, ChatWithOther>(
                          builder: (context, state) {
                            if (state.requestState == RequestState.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final chatList =
                                state.chatMap[widget.otherUser.id]!;
                            return ListView.builder(
                              key: _listKey,
                              reverse: false,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: chatList.length,
                              primary: true,
                              itemBuilder: (context, index) {
                                final key = GlobalKey();
                                keys[chatList[index].chatId] = key;
                                return messageRender(chatList[index], key,
                                    replayTo, findAndScroll, widget.otherUser);
                              },
                            );
                          },
                        ),
                        BlocBuilder<ChatwithotherBloc, ChatWithOther>(
                          builder: (context, state) {
                            if (state.requestStateForOlderChats ==
                                RequestState.loading) {
                              return const Center(
                                child: Text(
                                  "Getting old messages...",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        profileForChat(widget.otherUser),
                      ]),
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: replayTo,
                builder: (context, value, child) {
                  if (value != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.blue[100],
                          child: ListTile(
                            title: Text(
                              "Replying",
                              style: TextStyle(fontSize: 11),
                            ),
                            subtitle: ChatContentRenderHandler(
                              chat: value,
                              isReplay: true,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                replayTo.value = null;
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        ),
                        ChatInputField(
                          channel: _channel,
                          replayTo: replayTo.value,
                          onSend: () {
                            replayTo.value = null;
                            _scrollToBottom();
                          },
                        )
                      ],
                    );
                  }
                  return ChatInputField(
                    channel: _channel,
                    replayTo: replayTo.value,
                    onSend: () {
                      _scrollToBottom();
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
