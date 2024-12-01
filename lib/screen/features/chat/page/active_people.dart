import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/screen/account/widgets/user_profile.dart';
import 'package:late_blight/screen/features/chat/bloc/active_user_bloc.dart';
import 'package:late_blight/screen/features/chat/page/chat_with_id.dart';
import 'package:late_blight/screen/login/login_bloc.dart';

class ActivePeople extends StatefulWidget {
  const ActivePeople({super.key});

  @override
  State<ActivePeople> createState() => _ActivePeopleState();
}

class _ActivePeopleState extends State<ActivePeople> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget renderUser(User user) {
      final currentUser = context.read<LoginBloc>().state.loggedInUser;
      return GestureDetector(
        onTap: () {
          if (currentUser == null) {
            return;
          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatWithId(
                currentUser: currentUser,
                otherUser: user,
              ),
            ),
          );
        },
        child: SizedBox(
          width: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    UserProfile(
                      user: user,
                      size: Size(50, 50),
                      isVisitor: true,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${user.firstname} ${user.lastname}",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return BlocBuilder<ActiveUserBloc, List<User>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return SliverToBoxAdapter(
            child: SizedBox(),
          );
        }
        return SliverToBoxAdapter(
          child: SizedBox(
            height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Active People",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: state.map((user) {
                      return renderUser(user);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
