import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/model/insect_model.dart';
import 'package:late_blight/screen/insects/bloc/insects_bloc.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/utils/lang_utils.dart';
import 'package:late_blight/widgets/rounded_item.dart';

class InsectsHorizontalList extends StatelessWidget {
  const InsectsHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    Widget horizontalSlider(InsectGroup item, String type) {
      return SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    type,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                if (item.insects.length > 10)
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        "/insects",
                      );
                    },
                    child: Text(
                      YajnaLocalization.seeMore['np'].toString(),
                      softWrap: true,
                    ),
                  )
              ],
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final item in item.insects.sublist(
                    0,
                    item.insects.length >= 10 ? 10 : item.insects.length,
                  ))
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: KuKrishiRoundedItem(
                        radius: const Radius.circular(34),
                        onClick: () {
                          Navigator.of(context)
                              .pushNamed("/insect", arguments: item);
                        },
                        size: const Size(68, 68),
                        title: item.name,
                        imageUrl: API.getUrl(item.image),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      );
    }

    return BlocBuilder<InsectsBloc, InsectStateModel>(
      builder: (context, state) {
        switch (state.state) {
          case RequestState.success:
            if (state.insects.isEmpty) {
              return const SliverToBoxAdapter(child: SizedBox());
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return horizontalSlider(
                      state.insects[index], state.insects[index].id);
                },
                childCount: state.insects.length > 3 ? 3 : state.insects.length,
              ),
            );
          default:
            return const SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
}
