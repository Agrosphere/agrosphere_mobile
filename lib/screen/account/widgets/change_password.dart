import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/services/isolate.dart';
import 'package:late_blight/utils/utils.dart';
import 'package:late_blight/widgets/text_field.dart';

class ChangePassword extends StatefulWidget {
  final bool expandable;

  const ChangePassword({super.key, this.expandable = false});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formState = GlobalKey<FormState>();
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    newPassword.dispose();
    oldPassword.dispose();
    confirmPassword.dispose();
  }

  void clearTextFields() {
    oldPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    void changePassword() async {
      if (formState.currentState!.validate()) {
        try {
          final body = {
            "old_password": oldPassword.text,
            "new_password": newPassword.text,
            "confirm_password": confirmPassword.text
          };
          final url = "${Config.userApiUrl}user/change/password";
          var result = await UserService.updateInfo(body, url);
          if (result == null) {
            return;
          }
          if (result is DioException) {
            Fluttertoast.showToast(msg: (result).response!.data['message']);
          } else if (result is String) {
            Fluttertoast.showToast(msg: result);
          } else {
            result = result as Response<dynamic>;
            Fluttertoast.showToast(msg: result.data['message']);
            clearTextFields();
          }
        } catch (e) {
          //
          Fluttertoast.showToast(msg: "Error changing password");
        }
      }
    }

    Widget changePasswordForm() {
      return Form(
        key: formState,
        child: Column(
          children: [
            const SizedBox(height: 20),
            KrishiTextField(
              hintText: "Old Password",
              labelText: "Old Password",
              isPassword: true,
              controller: oldPassword,
              validator: passwordValidator,
            ),
            KrishiTextField(
              hintText: "New Password",
              labelText: "New Password",
              controller: newPassword,
              isPassword: true,
              validator: passwordValidator,
            ),
            KrishiTextField(
              hintText: "Confirm Password",
              labelText: "Confirm Password",
              controller: confirmPassword,
              isPassword: true,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "Confirm Password is required";
                }
                if (p0 != newPassword.text) {
                  return "Password does not match";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                onPressed: changePassword,
                color: Colors.green,
                child: Text("Chanage Password"),
              ),
            )
          ],
        ),
      );
    }

    return !widget.expandable
        ? changePasswordForm()
        : ExpansionTile(
            enableFeedback: true,
            dense: true,
            shape: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
            subtitle: Text("Tap to change password"),
            collapsedBackgroundColor: Colors.grey[200],
            leading: Icon(Icons.lock),
            title: const Text("Change Password"),
            children: [
              changePasswordForm(),
            ],
          );
  }
}
