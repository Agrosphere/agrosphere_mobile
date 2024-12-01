import 'package:flutter/material.dart';
import 'package:late_blight/utils/utils.dart';
import 'package:late_blight/widgets/login_alert.dart';

Widget handle401(BuildContext context, String message) {
  // logout(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      loginAlertInfo(context),
    ],
  );
}
