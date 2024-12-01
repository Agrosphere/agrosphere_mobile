import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/home/ensemble_lcc/bloc/lcc_model.dart';
import 'package:late_blight/screen/home/late_blight/bloc/late_blight.probability.bloc.dart';
import 'package:late_blight/screen/home/late_blight/bloc/late_blight_history_bloc.dart';
import 'package:late_blight/screen/home/late_blight_segmentation/late_blight_segmentation_bloc.dart';
import 'package:late_blight/screen/home/lcc/bloc/lcc_model.dart';
import 'package:late_blight/screen/home/lcc/bloc/lcc_model_update_bloc.dart';
import 'package:late_blight/screen/insects/bloc/insects_bloc.dart';
import 'package:late_blight/screen/diseases/bloc/diseases_bloc.dart';
import 'package:late_blight/bloc/lcc_version_bloc.dart';

getDiseasesProviders(String? lccVersion) {
  final diseasesProviders = [
    BlocProvider(create: (context) => LateBlightProbabilityBloc()),
    BlocProvider(create: (context) => DiseasesBloc()),
    BlocProvider(create: (context) => LCCVersionBloc(lccVersion)),
    BlocProvider(create: (context) => LCCUpdateBloc()),
    BlocProvider(create: (context) => LateBlightHistoryBloc()),
    BlocProvider(create: (context) => LateBlightSegModelBloc()),
    BlocProvider(create: (context) => EnsembleLCCModelBloc()),
    BlocProvider(create: (context) => InsectsBloc()),
    BlocProvider(create: (context) => LCCModelBloc()),
  ];
  return diseasesProviders;
}
