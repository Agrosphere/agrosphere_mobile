import 'dart:io';
import 'package:flutter/material.dart';
import 'package:late_blight/screen/home/lcc/bloc/lcc_model.dart';

void lccReportBottomSheet(BuildContext context, LCCModel state) {
  //generate report
  List<Widget> widgets = [];
  for (var i = 0; i < state.result.length; i++) {
    widgets.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.file(
            File(state.filePaths[i]),
            cacheHeight: 32,
            width: 32,
            height: 32,
            cacheWidth: 32,
          ),
          Text("LCC Level : ${(state.result[i] + 1)}"),
        ],
      ),
    ));
  }

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 350,
        child: Column(
          children: [
            const Text(
              "LCC Report",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 315,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [...widgets],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
