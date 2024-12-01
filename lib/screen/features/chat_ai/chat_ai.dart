import 'package:flutter/material.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/features/chat_ai/ai_sathi.dart';

class ChatAi extends StatelessWidget {
  const ChatAi({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.black,
        backgroundColor: appBarColor,
        title: const Text(
          'Krishi Guru',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AISathi(),
    ));
  }
}
