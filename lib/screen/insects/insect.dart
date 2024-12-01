import 'package:flutter/material.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/model/insect_model.dart';
import 'package:late_blight/widgets/network.image.dart';

class InsectView extends StatelessWidget {
  const InsectView({super.key});

  @override
  Widget build(BuildContext context) {
    final Insect? data = ModalRoute.of(context)?.settings.arguments as Insect?;
    if (data == null) return const Scaffold();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 3,
        shadowColor: Colors.black,
        title: Text(data.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: LateBlightNetworkImage(
                      url: API.getUrl(data.image),
                      radius: const Radius.circular(8),
                      size: Size(Size.infinite.width, 150),
                    ),
                  ),
                ),
                Text(
                  data.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            if (data.type.isNotEmpty)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Type:\n',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                    ),
                    TextSpan(
                      text: data.type,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            if (data.damage.isNotEmpty)
              SelectableText.rich(TextSpan(children: [
                TextSpan(
                  text: 'Damage:\n',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                ),
                ...data.damage.map((symptom) => TextSpan(
                      text: '• $symptom\n',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        height: 1.5,
                      ),
                    )),
              ])),
            const SizedBox(
              height: 15,
            ),
            if (data.management.isNotEmpty)
              SelectableText.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Management:\n',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                  ),
                  ...data.management.map((symptom) => TextSpan(
                        text: '• $symptom\n',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          height: 1.5,
                        ),
                      )),
                ]),
              ),
          ],
        ),
      ),
    );
  }
}
