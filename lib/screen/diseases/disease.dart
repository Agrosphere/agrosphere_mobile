import 'package:flutter/material.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/model/diseases_model.dart';
import 'package:late_blight/widgets/network.image.dart';

class Disease extends StatelessWidget {
  const Disease({super.key});

  @override
  Widget build(BuildContext context) {
    final PlantDisease? data =
        ModalRoute.of(context)?.settings.arguments as PlantDisease?;
    if (data == null) return const Scaffold();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 11,
          title: Text(data.diseaseName),
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
                        url: API.getUrl(data.imageUrl),
                        radius: const Radius.circular(8),
                        size: Size(Size.infinite.width, 150),
                      ),
                    ),
                  ),
                  Text(
                    data.diseaseName,
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
              if (data.cause.isNotEmpty)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'रोगको कारण:\n',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                      ),
                      TextSpan(
                        text: data.cause,
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
              if (data.symptoms.isNotEmpty)
                SelectableText.rich(TextSpan(children: [
                  TextSpan(
                    text: 'लक्षणहरू:\n',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                  ),
                  ...data.symptoms.map((symptom) => TextSpan(
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
                SelectableText.rich(TextSpan(children: [
                  TextSpan(
                    text: 'व्यवस्थापन:\n',
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
                ])),
            ],
          ),
        ),
      ),
    );
  }
}
