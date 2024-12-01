import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/account/widgets/user_profile.dart';
import 'package:late_blight/screen/features/chat/bloc/people_bloc.dart';
import 'package:late_blight/screen/features/chat/page/chat_with_id.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/widgets/handle_401.dart';
import 'package:late_blight/widgets/text_field.dart';

class PeoplePage extends StatelessWidget {
  PeoplePage({
    super.key,
  });
  final ValueNotifier<String> query = ValueNotifier("");
  @override
  Widget build(BuildContext context) {
    Future<void> refresh() async {
      context.read<PeopleChatBloc>().getPeopleList(isRefetch: true);
      await Future.delayed(Duration(seconds: 1));
    }

    //call for one time
    context.read<PeopleChatBloc>().getPeopleList();
    final currentUser = context.read<LoginBloc>().state.loggedInUser;
    return RefreshIndicator(
      onRefresh: refresh,
      child: CustomScrollView(
        key: PageStorageKey<String>('people_page'),
        slivers: [
          SliverToBoxAdapter(
            child: KrishiTextField(
              hintText: "Search People",
              maxLength: 30,
              controller: TextEditingController(text: query.value),
              onChanged: (p0) {
                query.value = p0;
              },
            ),
          ),
          BlocBuilder<PeopleChatBloc, PeopleStateModel>(
            builder: (context, state) {
              switch (state.requestState) {
                case RequestState.loading:
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case RequestState.fail:
                  if (state.statusCode == 401) {
                    //logout user and show login alert
                    return SliverToBoxAdapter(
                      child: handle401(context, state.errorMessage),
                    );
                  }
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        state.errorMessage,
                      ),
                    ),
                  );
                case RequestState.success:
                  return ValueListenableBuilder(
                    valueListenable: query,
                    builder: (context, value, child) {
                      var users = state.peopleList;
                      if (value.trim().isNotEmpty) {
                        //filter the user
                        users = users
                            .where((user) => (user.firstname + user.lastname)
                                .contains(value))
                            .toList();
                      }
                      if (users.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Text("People not found"),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: users.length,
                          (context, index) {
                            final user = users[index];
                            // final activeUsers =
                            //     context.read<ActiveUserBloc>().state;
                            return ListTile(
                              onTap: () {
                                if (currentUser != null) {
                                  //navigate to chat page
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ChatWithId(
                                        currentUser: currentUser,
                                        otherUser: user,
                                      ),
                                    ),
                                  );
                                }
                              },
                              leading: Stack(
                                children: [
                                  UserProfile(
                                    user: user,
                                    size: Size(50, 50),
                                    isVisitor: true,
                                  ),
                                ],
                              ),
                              title: Text("${user.firstname} ${user.lastname}"),
                            );
                          },
                        ),
                      );
                    },
                  );

                default:
                  return SliverToBoxAdapter();
              }
            },
          ),
        ],
      ),
    );
  }
}
