import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:late_blight/services/isolate.dart';
import 'package:late_blight/widgets/network.image.dart';

class CoverPicture extends StatelessWidget {
  final User user;
  final bool isVisitor;
  const CoverPicture({super.key, required this.user, this.isVisitor = false});

  @override
  Widget build(BuildContext context) {
    void pickCoverPicture() async {
      ImagePicker imagePicker = ImagePicker();
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        try {
          final url = "${Config.userApiUrl}user/update/cover";
          final result =
              await UserService.uploadPicture(File(file.path), 'cover', url);
          if (result != null) {
            final profile = result['cover'];
            if (context.mounted) {
              context.read<LoginBloc>().updateCoverPicture(profile);
            }
          }
        } catch (e) {
          // print(e);
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            color: Colors.grey,
            height: 200,
            child: user.coverPicture != null
                ? LateBlightNetworkImage(
                    boxFit: BoxFit.cover,
                    size: Size(Size.infinite.width, 200),
                    url: "${Config.userApiUrl}${user.coverPicture}",
                  )
                : null,
          ),
          if (!isVisitor)
            Positioned(
              top: 10,
              right: 10,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.blue[500],
                child: IconButton(
                  onPressed: pickCoverPicture,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
