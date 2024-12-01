import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:late_blight/services/isolate.dart';
import 'package:late_blight/widgets/network.image.dart';

class UserProfile extends StatelessWidget {
  final User user;
  final bool isVisitor;
  final Size size;
  final Border? border;
  const UserProfile({
    super.key,
    required this.user,
    this.isVisitor = false,
    this.size = const Size(100, 100),
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    void pickProfiflePicture() async {
      if (isVisitor) return;
      ImagePicker imagePicker = ImagePicker();
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        try {
          final url = "${Config.userApiUrl}user/update/profile";
          final result =
              await UserService.uploadPicture(File(file.path), 'profile', url);
          if (result != null) {
            final profile = result['profile'];
            if (context.mounted) {
              context.read<LoginBloc>().updateProfile(profile);
            }
          }
        } catch (e) {
          //show error message
          SnackBar snackBar = SnackBar(
            content: Text("Error uploading profile picture"),
          );
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      }
    }

    return Stack(
      children: [
        if (user.profile != null)
          LateBlightNetworkImage(
            boxFit: BoxFit.cover,
            size: size,
            border: border,
            radius: Radius.circular(50),
            url: "${Config.userApiUrl}${user.profile}",
          ),
        if (user.profile == null)
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: border,
            ),
            child: CircleAvatar(
              radius: size.height / 2,
              child: Text(
                user.firstname[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        if (!isVisitor)
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue,
              child: IconButton(
                onPressed: pickProfiflePicture,
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
