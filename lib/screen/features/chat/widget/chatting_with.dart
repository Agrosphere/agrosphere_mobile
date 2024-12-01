import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/screen/account/widgets/user_profile.dart';
import 'package:late_blight/screen/features/chat/bloc/chat_with_bloc.dart';
import 'package:late_blight/screen/features/chat/page/chat_with_id.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:late_blight/utils/enums.dart';

class ChattingWith extends StatefulWidget {
  const ChattingWith({super.key});

  @override
  State<ChattingWith> createState() => _ChattingWithState();
}

class _ChattingWithState extends State<ChattingWith> {
  final listKey = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    super.initState();
    context.read<ChatWithBloc>().getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateList(List<User> newUsers) {
    // Add new users to the list
    // for (int i = 0; i < newUsers.length; i++) {
    //   if (users.length <= i || users[i].id != newUsers[i].id) {
    //     users.insert(i, newUsers[i]);
    //     if (listKey.currentState != null) listKey.currentState!.insertItem(i);
    //   }
    // }

    // // Remove users that are not in the new list
    // for (int i = 0; i < users.length; i++) {
    //   if (newUsers.isEmpty || users[i].id != newUsers[i].id) {
    //     listKey.currentState!.removeItem(i, (context, animation) {
    //       return ListTile(
    //         title: Text(users[i].firstname),
    //         subtitle: Text(users[i].email),
    //       );
    //     });
    //     users.removeAt(i);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<LoginBloc>().state.loggedInUser;
    return PageStorage(
      bucket: PageStorageBucket(),
      child: SliverList(
        delegate: SliverChildListDelegate([
          BlocConsumer<ChatWithBloc, ChatWithState>(
            listener: (context, state) {
              // if (state.users.isNotEmpty) {
              //   updateList(state.users);
              // }
            },
            builder: (context, state) {
              if (state.requestState == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.requestState == RequestState.fail) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              final users = state.users;
              if (users.isEmpty) {
                return const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("No users found", style: TextStyle(fontSize: 20)),
                      Text(
                        "Start a chat with someone",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }
              return AnimatedList(
                physics: BouncingScrollPhysics(),
                reverse: false,
                primary: true,
                shrinkWrap: true,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: Tween(
                      begin: Offset(1, 0),
                      end: Offset(0, 0),
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.linearToEaseOut,
                    )),
                    child: ListTile(
                      onTap: () {
                        //navigate to chat page
                        if (currentUser != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatWithId(
                                currentUser: currentUser,
                                otherUser: users[index],
                              ),
                            ),
                          );
                        }
                      },
                      leading: UserProfile(
                        user: users[index],
                        size: const Size(40, 40),
                        isVisitor: true,
                        border: Border.all(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                      title: Text(
                        "${users[index].firstname} ${users[index].lastname}",
                      ),
                      subtitle: Text(users[index].email),
                    ),
                  );
                },
                key: listKey,
                initialItemCount: users.length,
              );
            },
          ),
        ]),
      ),
    );
  }
}
