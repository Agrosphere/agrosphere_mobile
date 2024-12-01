import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:late_blight/screen/home/lcc/bloc/lcc_model_update_bloc.dart';
import 'package:late_blight/services/download_model.dart';

void showModelUpdateDialog(BuildContext context, LCCUpdateModel state) {
  Future.delayed(
    const Duration(milliseconds: 100),
    () => {
      showCupertinoDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("New model is available."),
            actions: [
              CupertinoButton(
                child: const Text(
                  "Later",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoButton(
                child: const Text("Update"),
                onPressed: () {
                  if (state.url != null) {
                    Fluttertoast.showToast(
                        msg: "Downloading model...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    DownloadService()
                        .start(state.url!, path: "model")
                        .then((value) {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<LCCUpdateBloc>(context).updateHasUpdate();
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "Updated model successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }).catchError((a) {
                      Fluttertoast.showToast(
                          msg: "Failed to update model",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    });
                  }
                },
              )
            ],
          );
        },
      )
    },
  );
}
