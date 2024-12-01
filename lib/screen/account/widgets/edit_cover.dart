import 'package:flutter/material.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/screen/account/widgets/user_cover.dart';

class EditCover extends StatefulWidget {
  final User user;
  final bool expandable;

  const EditCover({super.key, required this.user, this.expandable = false});

  @override
  State<EditCover> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<EditCover> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget changeProfile() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CoverPicture(
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
            subtitle: Text("Tap to change cover picture"),
            collapsedBackgroundColor: Colors.grey[200],
            leading: const Icon(Icons.image),
            title: const Text("Change Cover Picture"),
            children: [
              changeProfile(),
            ],
          );
  }
}
