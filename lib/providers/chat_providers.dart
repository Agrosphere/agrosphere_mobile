import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/features/chat/bloc/active_user_bloc.dart';
import 'package:late_blight/screen/features/chat/bloc/chat_with_bloc.dart';
import 'package:late_blight/screen/features/chat/bloc/chatwithother_bloc.dart';
import 'package:late_blight/screen/features/chat/bloc/people_bloc.dart';
import 'package:late_blight/screen/features/chat/bloc/typing_bloc.dart';
import 'package:late_blight/screen/features/chat_ai/bloc/ai_chatbloc.dart';

getChatProviders() {
  final chatProvider = [
    BlocProvider(create: (context) => ChatwithotherBloc()),
    BlocProvider(create: (context) => ActiveUserBloc()),
    BlocProvider(create: (context) => ChatWithBloc()),
    BlocProvider(create: (context) => PeopleChatBloc()),
    BlocProvider(create: (context) => TypingBloc()),
    BlocProvider(create: (context) => AiChatbloc())
  ];
  return chatProvider;
}
