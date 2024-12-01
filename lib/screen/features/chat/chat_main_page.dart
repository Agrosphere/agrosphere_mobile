import 'package:flutter/material.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/features/chat/page/chat.dart';
import 'package:late_blight/screen/features/chat/page/people.dart';

class ChatMainPage extends StatelessWidget {
  const ChatMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Column(
        children: [
          Container(
            color: appBarColor, // Background color for the TabBar
            child: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.yellow,
              indicatorWeight: 3.0,
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.chat,
                  size: 18,
                )),
                Tab(
                    icon: Icon(
                  Icons.person,
                  size: 18,
                )),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Replace these placeholders with your actual pages/widgets
                ChatWithPeople(),
                PeoplePage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
