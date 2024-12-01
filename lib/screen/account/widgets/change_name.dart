// ignore: file_names
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/user.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:late_blight/services/isolate.dart';
import 'package:late_blight/widgets/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeName extends StatefulWidget {
  final User user;
  final bool expandable;

  const ChangeName({super.key, required this.user, this.expandable = false});

  @override
  State<ChangeName> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangeName> {
  final formState = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final isChanged = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    firstName.text = widget.user.firstname;
    lastName.text = widget.user.lastname;
  }

  @override
  Widget build(BuildContext context) {
    void changeName() async {
      if (formState.currentState!.validate()) {
        try {
          final body = {
            "first_name": firstName.text.trim(),
            "last_name": lastName.text.trim(),
          };
          final url = "${Config.userApiUrl}user/update";
          var result = await UserService.updateInfo(body, url);
          if (result == null) {
            Fluttertoast.showToast(msg: "Update failed");
            return;
          }
          if (result is DioException) {
            Fluttertoast.showToast(msg: (result).response!.data['message']);
          } else if (result is String) {
            Fluttertoast.showToast(msg: result);
          } else {
            result = result as Response<dynamic>;
            isChanged.value = false;
            if (context.mounted) {
              context.read<LoginBloc>().updateName(
                    firstName.text,
                    lastName.text,
                  );
            }
            Fluttertoast.showToast(msg: result.data['message']);
          }
        } catch (e) {
          //
          Fluttertoast.showToast(msg: "Update failed");
        }
      }
    }

    void handleOnChange() {
      if (firstName.text.trim() != widget.user.firstname ||
          lastName.text.trim() != widget.user.lastname) {
        isChanged.value = true;
      } else {
        isChanged.value = false;
      }
    }

    Widget changeNameForm() {
      return Form(
        key: formState,
        child: Column(
          children: [
            const SizedBox(height: 20),
            KrishiTextField(
              hintText: "First Name",
              labelText: "First Name",
              controller: firstName,
              onChanged: (p0) {
                handleOnChange();
              },
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "First Name is required";
                }
                return null;
              },
            ),
            KrishiTextField(
              hintText: "Last Name",
              labelText: "Last Name",
              controller: lastName,
              onChanged: (p0) {
                handleOnChange();
              },
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "Last Name is required";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder(
                valueListenable: isChanged,
                builder: (context, value, child) {
                  return CupertinoButton(
                    onPressed: !value ? null : changeName,
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(18, 6, 18, 6),
                    child: Text("Save Changes"),
                  );
                },
              ),
            )
          ],
        ),
      );
    }

    return !widget.expandable
        ? changeNameForm()
        : ExpansionTile(
            enableFeedback: true,
            dense: true,
            shape: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
            subtitle: Text("Tap to change name"),
            collapsedBackgroundColor: Colors.grey[200],
            leading: Icon(Icons.info),
            title: const Text("Change Name"),
            children: [
              changeNameForm(),
            ],
          );
  }
}
