import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget loginAlertInfo(BuildContext context) {
  final user = context.read<LoginBloc>().state.loggedInUser;
  // Login to get the all features
  if (user != null) {
    return Container();
  }
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Login to get all features",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.info,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  minSize: 36,
                  padding: EdgeInsets.fromLTRB(24, 2, 24, 2),
                  color: Colors.blue[400],
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          )
        ],
      ),
    ),
  );
}
