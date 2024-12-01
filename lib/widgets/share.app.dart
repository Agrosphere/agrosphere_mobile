import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

class ShareAppWidget extends StatelessWidget {
  const ShareAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void share() async {
      String appUrl =
          "https://play.google.com/store/apps/details?id=com.lateblight.late_blight";

      final result = await Share.share(appUrl);
      if (result.status == ShareResultStatus.success) {
        Fluttertoast.showToast(msg: "Thanks for sharing the app.");
      }
    }

    return SizedBox(
      width: Size.infinite.width,
      height: 250,
      child: Card(
        color: Colors.blue[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/share.gif",
              width: 95,
              height: 95,
              colorBlendMode: BlendMode.multiply,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Empower Agriculture with AI: Share the Future of Farming!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CupertinoButton(
              color: Colors.blue[800],
              padding: const EdgeInsets.fromLTRB(32, 4, 32, 4),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Share'),
                  SizedBox(width: 8.0),
                  Icon(
                    CupertinoIcons.share,
                    color: CupertinoColors.white,
                  ),
                ],
              ),
              onPressed: () {
                share();
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
