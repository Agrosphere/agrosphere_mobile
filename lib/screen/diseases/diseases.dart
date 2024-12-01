import 'package:flutter/material.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/diseases/bloc/diseases_bloc.dart';
import 'package:late_blight/widgets/horizontal_item.dart';

class Diseases extends StatelessWidget {
  const Diseases({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 7,
          title: const Text("रोगहरु"),
        ),
        body: BlocBuilder<DiseasesBloc, DiseasesStateModel>(
          builder: (context, state) {
            switch (state.state) {
              case RequestState.success:
                if (state.diseases.isEmpty) return const SizedBox();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          for (final item in state.diseases)
                            KuKrishiHorizontalItem(
                              onClick: () {
                                Navigator.of(context)
                                    .pushNamed("/disease", arguments: item);
                              },
                              size: const Size(68, 68),
                              title: item.diseaseName,
                              imageUrl: API.getUrl(item.imageUrl),
                            )
                        ],
                      ),
                    )
                  ],
                );
              default:
                return const SizedBox();
            }
          },
        ));
  }
}
