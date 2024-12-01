import 'package:flutter/material.dart';
import 'package:late_blight/screen/features/chat/bloc/chat_with_bloc.dart';
import 'package:late_blight/screen/features/chat/page/active_people.dart';
import 'package:late_blight/screen/features/chat/widget/chatting_with.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatWithPeople extends StatelessWidget {
  const ChatWithPeople({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> refresh() async {
      context.read<ChatWithBloc>().getUsers(isRefetch: true);
      await Future.delayed(Duration(seconds: 1));
    }

    return RefreshIndicator(
      onRefresh: refresh,
      child: CustomScrollView(
        shrinkWrap: true,
        key: PageStorageKey<String>('chat_with_people'),
        slivers: [
          ActivePeople(),
          ChattingWith(),
        ],
      ),
    );
  }
}
