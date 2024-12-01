import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/features/chat/widget/render_audio_handler.dart';
import 'package:late_blight/screen/features/chat/widget/render_image.dart';
import 'package:late_blight/screen/login/login_bloc.dart';

class ChatContentRenderHandler extends StatelessWidget {
  final ChatModel chat;
  final Function(ChatModel chat)? replayTo;
  final Function(ChatModel chat)? itemClicked;
  final bool isReplay;
  const ChatContentRenderHandler({
    super.key,
    required this.chat,
    this.replayTo,
    this.itemClicked,
    this.isReplay = false,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.read<LoginBloc>().state.loggedInUser;

    Widget handleText(String message, {bool isReplay = false}) {
      final radius = Radius.circular(16);
      return Container(
        decoration: BoxDecoration(
          color: chat.parentId == null
              ? user!.id == chat.senderId
                  ? Colors.white
                  : Colors.white10
              : Colors.white38,
          borderRadius: BorderRadius.only(
            topRight: user!.id == chat.receiverId ? radius : Radius.zero,
            topLeft: user.id == chat.senderId ? radius : Radius.zero,
            bottomLeft: radius,
            bottomRight: radius,
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: isReplay
              ? MediaQuery.of(context).size.width * 0.6
              : MediaQuery.of(context).size.width * 0.75,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            softWrap: true,
            overflow: isReplay ? TextOverflow.ellipsis : null,
            style: TextStyle(
              color: user.id == chat.senderId ? Colors.black : Colors.white,
            ),
          ),
        ),
      );
    }

    void showFullPageImage(ChatModel chat) {
      bool containsMediaOrUrl() {
        final RegExp regExp = RegExp(r'images|media|https?://');
        return regExp.hasMatch(chat.message);
      }

      String prefix = Config.chatApiUrl;
      final url = "$prefix${chat.message}?chatId=${chat.chatId}";

      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: containsMediaOrUrl()
                ? handleImageFromNetwork(
                    context,
                    url,
                    Config.accessToken ?? "",
                    hasConstrainsts: false,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                        maxHeight: MediaQuery.of(context).size.height * 0.9,
                      ),
                      child: Image.memory(
                        base64Decode(
                          chat.message,
                        ),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        isAntiAlias: true,
                      ),
                    ),
                  ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        if (chat.parentId != null) {
          if (itemClicked != null) {
            itemClicked!(chat);
          }
        }
      },
      onDoubleTap: () {
        if (chat.type == "image") {
          showFullPageImage(chat);
        }
      },
      child: Dismissible(
        key: Key(chat.chatId),
        direction: DismissDirection.horizontal,
        background: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: user!.id != chat.senderId
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Icon(
              Icons.reply,
              color: Colors.white,
            ),
          ],
        ),
        confirmDismiss: (direction) {
          if (replayTo != null) {
            replayTo!(chat);
          }
          return Future.value(false);
        },
        onDismissed: (direction) {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            chat.type == "audio"
                ? RenderAudioHandler(chat: chat)
                : chat.type == "text"
                    ? handleText(
                        chat.message,
                        isReplay: isReplay,
                      )
                    : HandleImageChatRender(
                        chat: chat,
                        isReplay: isReplay,
                      ),
          ],
        ),
      ),
    );
  }
}
