import 'package:flutter/material.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/colors/colors.dart';

import 'package:late_blight/model/insect_model.dart';
import 'package:late_blight/widgets/horizontal_item.dart';

class InsectsView extends StatelessWidget {
  const InsectsView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Insect> insects =
        ModalRoute.of(context)!.settings.arguments as List<Insect>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 3,
        shadowColor: Colors.black,
        title: Text(insects.isNotEmpty ? insects[0].type : "Insect type"),
      ),
      body: ListView(
        children: [
          for (final insect in insects)
            KuKrishiHorizontalItem(
              title: insect.name,
              imageUrl: API.getUrl(insect.image),
              onClick: () {
                Navigator.of(context).pushNamed(
                  "/insect",
                  arguments: insect,
                );
              },
            )
        ],
      ),
    );
  }
}
