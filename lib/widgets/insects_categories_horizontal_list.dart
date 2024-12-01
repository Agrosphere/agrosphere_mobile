import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/screen/insects/bloc/insects_bloc.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/utils/lang_utils.dart';
import 'package:late_blight/widgets/horizontal_item.dart';
import 'package:late_blight/widgets/rounded_item.dart';

class InsectsCategoryHorizontalList extends StatelessWidget {
  final bool isHorizontal;
  const InsectsCategoryHorizontalList({super.key, this.isHorizontal = true});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<InsectsBloc>(context).fetchInsects();
    Widget renderList(InsectStateModel state) {
      return ListView(
        scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
        children: [
          for (final item in state.insects.sublist(
            0,
            state.insects.length >= 10 ? 10 : state.insects.length,
          ))
            isHorizontal
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: KuKrishiRoundedItem(
                      radius: const Radius.circular(15),
                      onClick: () {
                        Navigator.of(context).pushNamed(
                          "/insects",
                          arguments: item.insects,
                        );
                      },
                      size: const Size(68, 68),
                      title: item.id,
                      imageUrl: API.getUrl(item.insects[0].image),
                    ),
                  )
                : KuKrishiHorizontalItem(
                    onClick: () {
                      Navigator.of(context).pushNamed(
                        "/insects",
                        arguments: item.insects,
                      );
                    },
                    title: item.id,
                    imageUrl: API.getUrl(item.insects[0].image),
                  )
        ],
      );
    }

    return BlocBuilder<InsectsBloc, InsectStateModel>(
      builder: (context, state) {
        switch (state.state) {
          case RequestState.success:
            if (state.insects.isEmpty) return const SizedBox();
            if (!isHorizontal) {
              return renderList(state);
            }
            return SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (isHorizontal)
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Insects categories",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (state.insects.length > 10)
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                "/insect_categories",
                              );
                            },
                            child: Text(
                                YajnaLocalization.seeMore['np'].toString()),
                          )
                      ],
                    ),
                  Expanded(child: renderList(state))
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
