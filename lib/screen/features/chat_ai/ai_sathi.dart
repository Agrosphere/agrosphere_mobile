import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/screen/features/chat_ai/bloc/ai_chatbloc.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/widgets/login_alert.dart';
import 'package:late_blight/widgets/render_text_item.dart';
import 'package:late_blight/widgets/text_field.dart';
import 'package:late_blight/widgets/text_speech.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AISathi extends StatefulWidget {
  const AISathi({super.key});

  @override
  State<AISathi> createState() => _TrekSathiTrekMateState();
}

class _TrekSathiTrekMateState extends State<AISathi> {
  WebSocketChannel? channel;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    final bloc = BlocProvider.of<AiChatbloc>(context);
    final token = "Bearer ${Config.accessToken}";
    try {
      if (bloc.state.krishiSathiState != ChatAI.connected ||
          bloc.state.krishiSathiState != ChatAI.connecting) {
        bloc.changeState(ChatAI.connecting);
        channel = IOWebSocketChannel.connect(
          Uri.parse(
            'wss://chat.safalstha.com.np/ws/ask/ai',
          ),
          headers: {"Authorization": token},
        );
      }
      bloc.changeState(ChatAI.connected);
      channel!.stream.listen(
        (data) {
          bloc.fromServer(data);
          _scrollToBottom();
        },
        onError: (error) {
          bloc.changeState(ChatAI.failure);
        },
        onDone: () {
          bloc.changeState(ChatAI.closed);
        },
        cancelOnError: true,
      );
    } catch (e) {
      bloc.changeState(ChatAI.failure);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    channel!.sink.close();
    super.dispose();
  }

  void ask() {
    BlocProvider.of<AiChatbloc>(context).send(_controller.text, channel!);
    _scrollToBottom();
    _controller.clear(); //clear the state
  }

  Widget handleSuggest(String item) {
    return RenderTextItem(
      item: item,
      style: const TextStyle(color: Colors.white, fontSize: 12),
      onClicked: (item) {
        _controller.text = item;
        ask();
      },
    );
  }

  Widget suggests() {
    return SizedBox(
      child: Center(
        child: Wrap(
          spacing: 1,
          alignment: WrapAlignment.center,
          children: [
            handleSuggest("How to grow Tomato?"),
            handleSuggest("How to grow Potato?"),
            handleSuggest("How to grow Cabbage?"),
            handleSuggest("How to grow Cauliflower?"),
            handleSuggest("How to grow Broccoli?"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget inputField() {
      return BlocBuilder<AiChatbloc, AiChatModel>(
        builder: (context, state) {
          if (state.krishiSathiState == ChatAI.connected ||
              state.krishiSathiState == ChatAI.thinking) {
            return Row(
              children: [
                Expanded(
                  child: KrishiTextField(
                    textStyle: TextStyle(color: Colors.white),
                    maxLength: 100,
                    maxLines: 1,
                    hintStyle: TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.send,
                    controller: _controller,
                    hintText: "Ask Krishi Guru",
                    onFieldSubmitted: (p0) {
                      ask();
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[800],
                  ),
                  child: IconButton(
                    onPressed: ask,
                    icon: Transform.rotate(
                      angle: -0.5,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return const SizedBox();
        },
      );
    }

    Widget messageRender(Message item) {
      print(item.data.replaceAll(RegExp(r'[*]'), ''));
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: item.id != "bot"
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: item.id != "bot"
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  // if (item.id != "trekmate")
                  //   treksathiProfile(
                  //     user.profile,
                  //     user.firstname,
                  //     minRadius: 15,
                  //   ),
                  if (item.id == "bot")
                    const CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        "assets/logo.png",
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      item.id == "bot" ? "Bot" : "You",
                      style: const TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: item.id != "bot"
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (item.data.isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          color: item.id == "bot"
                              ? Colors.blue[800]
                              : Colors.blue[800],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        constraints: BoxConstraints(
                          maxWidth: size.width * 0.75,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MarkdownBody(
                            data: item.data,
                            styleSheet: MarkdownStyleSheet(
                              p: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            fitContent: true,
                            selectable: true,
                            softLineBreak: true,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget thinking() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Bot thinking ...",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    Widget connectToMate(
        {String message = "Connect to the Bot",
        String buttonLabel = "Connect"}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
          CupertinoButton(
            onPressed: connect,
            child: Text(buttonLabel),
          )
        ],
      );
    }

    Widget chatWithMate() {
      return SizedBox(
        width: Size.infinite.width,
        child: BlocBuilder<AiChatbloc, AiChatModel>(
          builder: (context, state) {
            switch (state.krishiSathiState) {
              case ChatAI.idel:
                return connectToMate();
              case ChatAI.connecting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ChatAI.failure:
                return connectToMate(
                  message: "Failed to connect with Bot",
                  buttonLabel: "Try again",
                );
              case ChatAI.closed:
                return connectToMate(
                  buttonLabel: "Reconnect",
                  message: "Reconnect to the Bot",
                );
              case ChatAI.connected:
              case ChatAI.thinking:
                if (state.messages.isEmpty) {
                  return suggests();
                }
                return ListView(
                  reverse: true,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  controller: _scrollController,
                  children: [
                    if (state.krishiSathiState == ChatAI.thinking) thinking(),
                    for (final item in state.messages) messageRender(item),
                  ],
                );
              default:
                return Container();
            }
          },
        ),
      );
    }

    if (Config.accessToken == null) {
      return SizedBox(
        height: 120,
        child: loginAlertInfo(context),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: chatWithMate(),
        ),
        inputField(),
      ],
    );
  }
}
