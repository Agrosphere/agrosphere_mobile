import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:late_blight/screen/recommendation/recommendation_bloc.dart';
import 'package:late_blight/screen/recommendation/widgets.dart';
import 'package:late_blight/services/isar_service/location.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    determinePosition(context).then((value) {
      // ignore: use_build_context_synchronously
      context
          .read<AgriculturalReportCubit>()
          .fetchReport(value.longitude, value.latitude);
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // ignore: use_build_context_synchronously
      context.read<AgriculturalReportCubit>().fetchReport(85.556061, 27.625349);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('कृषि सुझाव'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: RecommendationWidget(),
          )
        ],
      ),
    );
  }
}
