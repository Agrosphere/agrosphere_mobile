import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/bloc/language_bloc.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/screen/features/chat/bloc/active_user_bloc.dart';
import 'package:late_blight/screen/home/main_home_page.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:late_blight/services/isolate.dart';
import 'package:late_blight/services/read_model_files.dart';

class MainApp extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const MainApp({Key? key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final ActiveUserBackgroundService activeUserBackgroundService;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    activeUserBackgroundService = ActiveUserBackgroundService(
        onMessageReceived: _handleActiveUserMessage);
    final user = context.read<LoginBloc>().state.loggedInUser;
    if (user != null) {
      activeUserBackgroundService.start(user.accessToken!);
    }
  }

  void _handleActiveUserMessage(dynamic message) {
    try {
      final json = jsonDecode(message);
      List<User> users = List.from(json['active_users'].map(
        (json) => User.fromJson(json),
      ));
      // ignore: use_build_context_synchronously
      context.read<ActiveUserBloc>().users(users);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    activeUserBackgroundService.stop();
  }

  @override
  Widget build(BuildContext context) {
    readLccFilesAndUpdate(context);

    return BlocBuilder<LanguageBloc, AppLanguage>(
      builder: (context, language) {
        return SafeArea(
          child: Scaffold(
            body: MainHomePage(
              language: language,
              pageController: _pageController,
            ),
          ),
        );
      },
    );
  }
}
