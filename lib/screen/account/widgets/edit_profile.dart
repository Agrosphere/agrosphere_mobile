import 'package:flutter/material.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/screen/account/widgets/user_profile.dart';

class EditProfile extends StatefulWidget {
  final User user;
  final bool expandable;

  const EditProfile({super.key, required this.user, this.expandable = false});

  @override
  State<EditProfile> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget changeProfile() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: UserProfile(
          user: widget.user,
        ),
      );
    }

    return !widget.expandable
        ? changeProfile()
        : ExpansionTile(
            enableFeedback: true,
            dense: true,
            shape: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
            subtitle: Text("Tap to change profile picture"),
            collapsedBackgroundColor: Colors.grey[200],
            leading: UserProfile(
              user: widget.user,
              isVisitor: true,
              size: Size(36, 36),
            ),
            title: const Text("Change Profile Picture"),
            children: [
              changeProfile(),
            ],
          );
  }
}
