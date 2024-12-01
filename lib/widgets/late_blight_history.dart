import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/home/late_blight/bloc/late_blight.probability.bloc.dart';
import 'package:late_blight/screen/home/late_blight/bloc/late_blight_history_bloc.dart';
import 'package:late_blight/utils/enums.dart';

class LateBlightHistoryChart extends StatefulWidget {
  const LateBlightHistoryChart({super.key});

  @override
  State<LateBlightHistoryChart> createState() => _LateBlightHistoryChartState();
}

class _LateBlightHistoryChartState extends State<LateBlightHistoryChart> {
  @override
  void initState() {
    BlocProvider.of<LateBlightHistoryBloc>(context).fetchHistory("Panchkhal");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // LateBlightHistoryBloc

    return BlocBuilder<LateBlightProbabilityBloc, LateBlightProbabilityState>(
        builder: (context, currentData) {
      List<String> locations = [];

      for (final item in currentData.predictions) {
        locations.add(item.placeName);
      }
      if (locations.isEmpty) {
        return const SizedBox();
      }
      String selcted = locations[0];
      return BlocBuilder<LateBlightHistoryBloc, LateBlightHistoryBlocModel>(
        builder: (context, state) {
          if (state.requestState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.data.isEmpty) {
            return const SizedBox();
          }
          List<FlSpot> spots = [];
          List<DateTime> dates = [];
          int i = 0;
          for (final item in state.data) {
            try {
              final predictedDate = DateTime.parse(item.predictedDate);
              bool dateExists =
                  dates.any((date) => date.isAtSameMomentAs(predictedDate));
              if (dateExists) {
                continue;
              }
              dates.add(predictedDate);
              spots.add(FlSpot(i.toDouble(), item.lateblightprobability));
              i++;
            } catch (e) {
              // debugPrint(e.toString());
            }
          }
          List<String> months = [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec"
          ];

          String xAxisLabel = "";
          if (dates[0].month == dates[dates.length - 1].month) {
            xAxisLabel = months[dates[0].month - 1];
          } else {
            xAxisLabel =
                "${months[dates[0].month - 1]}-${months[dates[dates.length - 1].month - 1]}";
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 0, 0),
                child: Text(
                  "Select the Station",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: DropdownButton<String>(
                  value: locations.isNotEmpty ? selcted : null,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    selcted = newValue!;
                    BlocProvider.of<LateBlightHistoryBloc>(context)
                        .fetchHistory(newValue);
                  },
                  items:
                      locations.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Card(
                elevation: 3,
                color: cardColor,
                surfaceTintColor: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      AspectRatio(
                        aspectRatio: 1.2,
                        child: SizedBox(
                          height: 200,
                          width: 350,
                          child: LineChart(LineChartData(
                            borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                  color: Colors.black12,
                                )),
                            titlesData: FlTitlesData(
                                leftTitles: const AxisTitles(
                                  axisNameSize: 25,
                                  sideTitles: SideTitles(showTitles: false),
                                  axisNameWidget: Text(
                                    "Probability",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                topTitles: const AxisTitles(
                                    drawBelowEverything: false),
                                bottomTitles: AxisTitles(
                                  axisNameSize: 25,
                                  axisNameWidget: Text(
                                    xAxisLabel,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    reservedSize: 30,
                                    getTitlesWidget: (value, meta) {
                                      return Transform.rotate(
                                        angle: 0,
                                        child: Text(
                                          "${dates[value.toInt()].day}",
                                        ),
                                      );
                                    },
                                  ),
                                )),
                            lineBarsData: [
                              LineChartBarData(
                                isCurved: true,
                                color: const Color.fromARGB(255, 1, 63, 113),
                                spots: spots,
                                belowBarData: BarAreaData(show: false),
                              )
                            ],
                            minX: 0,
                            maxX: i.toDouble() - 1,
                            maxY: 1,
                            minY: 0,
                            lineTouchData: const LineTouchData(enabled: true),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
