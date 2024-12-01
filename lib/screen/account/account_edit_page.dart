import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/account/widgets/change_name.dart';
import 'package:late_blight/screen/account/widgets/change_password.dart';
import 'package:late_blight/screen/account/widgets/edit_cover.dart';
import 'package:late_blight/screen/account/widgets/edit_profile.dart';
import 'package:late_blight/screen/login/login_bloc.dart';

class EditAccountPage extends StatelessWidget {
  const EditAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Account"),
        backgroundColor: appBarColor,
        shadowColor: Colors.black,
      ),
      body: BlocConsumer<LoginBloc, LoginBlocModelState>(
        listener: (context, state) {
          if (state.loggedInUser == null) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state.loggedInUser == null) {
            return const SizedBox();
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: EditProfile(
                  user: state.loggedInUser!,
                  expandable: true,
                ),
              ),
              SliverToBoxAdapter(
                child: ChangeName(
                  user: state.loggedInUser!,
                  expandable: true,
                ),
              ),
              SliverToBoxAdapter(
                child: EditCover(
                  user: state.loggedInUser!,
                  expandable: true,
                ),
              ),
              SliverToBoxAdapter(
                child: ChangePassword(
                  expandable: true,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
