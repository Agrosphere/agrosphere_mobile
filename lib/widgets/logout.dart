import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:late_blight/shared_prefs.dart';
import 'package:late_blight/utils/utils.dart';

void showLogoutDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(TextUtils.askLogout),
        actions: [
          CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              TextUtils.no,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          CupertinoButton(
            onPressed: () {
              YajnaKrishiSharePrefs.logout().then((value) {
                if (value == null || !value) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.popAndPushNamed(context, "/login");
                }
              });
            },
            child: Text(TextUtils.yes),
          ),
        ],
      );
    },
  );
}
