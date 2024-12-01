import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/screen/diseases/bloc/diseases_bloc.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/utils/lang_utils.dart';
import 'package:late_blight/widgets/rounded_item.dart';

class DiseasesHorizontalList extends StatelessWidget {
  const DiseasesHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiseasesBloc, DiseasesStateModel>(
      builder: (context, state) {
        switch (state.state) {
          case RequestState.success:
            if (state.diseases.isEmpty) return const SizedBox();
            return SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "रोगहरु",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/diseases");
                        },
                        child: Text(YajnaLocalization.seeMore['np'].toString()),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (final item in state.diseases.sublist(
                          0,
                          state.diseases.length >= 10
                              ? 10
                              : state.diseases.length,
                        ))
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: KuKrishiRoundedItem(
                              onClick: () {
                                Navigator.of(context)
                                    .pushNamed("/disease", arguments: item);
                              },
                              size: const Size(68, 68),
                              title: item.diseaseName,
                              imageUrl: API.getUrl(item.imageUrl),
                            ),
                          )
                      ],
                    ),
                  )
                ],
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
