import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/account/account_edit_page.dart';
import 'package:late_blight/screen/account/widgets/user_cover.dart';
import 'package:late_blight/screen/account/widgets/user_profile.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:late_blight/widgets/login_alert.dart';

class UserDashboard extends StatelessWidget {
  // final PageController pageController;
  const UserDashboard({
    super.key,
    // required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> refresh() {
      context.read<LoginBloc>().refreshUser();
      return Future.delayed(Duration(seconds: 1));
    }

    void alertForLogout() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Logout"),
            content: Text("Are you sure you want to logout?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  context.read<LoginBloc>().logout();
                  Navigator.pop(context);
                },
                child: Text("Logout"),
              ),
            ],
          );
        },
      );
    }

    Widget popupMenu() {
      final user = BlocProvider.of<LoginBloc>(
        context,
        listen: true,
      ).state.loggedInUser;
      if (user == null) {
        return const SizedBox();
      }
      return PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Text("Edit Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditAccountPage(),
                  ),
                );
              },
            ),
            PopupMenuItem(
              child: Text("Logout"),
              onTap: () {
                alertForLogout();
              },
            ),
          ];
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 3,
        shadowColor: Colors.black,
        title: const Text("Profile"),
        actions: [
          popupMenu(),
        ],
      ),
      body: BlocBuilder<LoginBloc, LoginBlocModelState>(
        builder: (context, state) {
          final user = state.loggedInUser;
          if (user == null) {
            return loginAlertInfo(context);
          }
          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView(
              shrinkWrap: true,
              primary: true,
              scrollDirection: Axis.vertical,
              children: [
                Stack(
                  children: [
                    CoverPicture(user: user),
                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UserProfile(
                          user: user,
                          border: Border.all(
                            color: Colors.yellow,
                            width: 2,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${user.firstname} ${user.lastname}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
