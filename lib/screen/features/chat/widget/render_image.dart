import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/chat.dart';

class HandleImageChatRender extends StatelessWidget {
  final ChatModel chat;
  final bool isReplay;

  const HandleImageChatRender({
    super.key,
    required this.chat,
    this.isReplay = false,
  });

  @override
  Widget build(BuildContext context) {
    // final user = context.read<LoginBloc>().state.loggedInUser;

    Widget handleImage(ChatModel chat) {
      bool containsMediaOrUrl(String message) {
        final RegExp regExp = RegExp(r'images|media|https?://');
        return regExp.hasMatch(message);
      }

      String prefix = Config.chatApiUrl;

      //we have two types of image one is from the base64 and another is from the network file
      //so we need to check if the image is from the base64 or from the network
      if (containsMediaOrUrl(chat.message)) {
        final url = "$prefix${chat.message}?chatId=${chat.chatId}";
        return handleImageFromNetwork(
          context,
          url,
          Config.accessToken ?? "",
          isReplay: isReplay,
        );
      }
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: isReplay
              ? BoxConstraints(
                  maxWidth: 100,
                  maxHeight: 100,
                )
              : BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.5,
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
          child: AspectRatio(
            // aspectRatio: image == null ? 1 : image.width / image.height,
            aspectRatio: 1,
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
    }

    return handleImage(chat);
  }
}

Widget handleImageFromNetwork(
    BuildContext context, String url, String accessToken,
    {bool hasConstrainsts = true, bool isReplay = false}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      constraints: isReplay
          ? BoxConstraints(
              maxWidth: 100,
              maxHeight: 100,
            )
          : hasConstrainsts
              ? BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.5,
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                )
              : null,
      child: Image(
        errorBuilder: (context, error, stackTrace) {
          if (error is HttpException) {
            final message = error.message;
            if (message.contains("401")) {
              return const Icon(Icons.error);
            } else if (message.contains("404")) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Image not found",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
          }
          return const Icon(Icons.error);
        },
        image: CachedNetworkImageProvider(
          url,
          headers: {
            'Authorization': accessToken,
          },
        ),
      ),
    ),
  );
}
