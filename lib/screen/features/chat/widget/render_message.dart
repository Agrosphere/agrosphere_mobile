import 'package:flutter/material.dart';
import 'package:late_blight/model/chat.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/screen/account/widgets/user_profile.dart';
import 'package:late_blight/screen/features/chat/widget/chat_content.dart';
import 'package:late_blight/utils/utils.dart';

Widget dateTimeWidget(String time) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      formatDate(time),
      softWrap: true,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 6,
      ),
    ),
  );
}

Widget messageRender(
  ChatModel item,
  GlobalKey key,
  ValueNotifier<ChatModel?> replayTo,
  Function(ChatModel chat) findAndScroll,
  User otherUser,
) {
  return Padding(
    key: key,
    padding: const EdgeInsets.all(4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(4.0),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: item.receiverId == otherUser.id
        //         ? MainAxisAlignment.end
        //         : MainAxisAlignment.start,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(2.0),
        //         child: Text(
        //           item.receiverId == otherUser.id
        //               ? "तपाईं"
        //               : "${otherUser.firstname} ${otherUser.lastname}",
        //           overflow: TextOverflow.ellipsis,
        //           softWrap: true,
        //           style: const TextStyle(
        //             fontSize: 7,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: item.receiverId == otherUser.id
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ChatContentRenderHandler(
                  chat: item,
                  itemClicked: (chat) {
                    findAndScroll(chat);
                  },
                  replayTo: (chat) {
                    replayTo.value = null;
                    Future.delayed(const Duration(milliseconds: 100), () {
                      replayTo.value = chat;
                    });
                  },
                ),
                dateTimeWidget(item.time),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget profileForChat(User otherUser) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 25,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UserProfile(
              user: otherUser,
              isVisitor: true,
            ),
          ),
          Text(
            "${otherUser.firstname} ${otherUser.lastname}",
            maxLines: 1,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ],
      )
    ],
  );
}
