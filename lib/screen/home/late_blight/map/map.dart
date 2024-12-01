import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:late_blight/model/late_blight_prediction.dart';
import 'package:late_blight/screen/home/late_blight/map/bloc/map_bloc.dart';
import 'package:late_blight/utils/enums.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

class LateBlightMap extends StatefulWidget {
  const LateBlightMap({super.key});

  @override
  State<LateBlightMap> createState() => _LateBlightMapState();
}

class _LateBlightMapState extends State<LateBlightMap> {
  MapController controller = MapController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> marks(LateBlightPrediction prediction) {
      List<Marker> markers = [];
      markers.add(Marker(
        rotate: false,
        point: LatLng(prediction.latitude, prediction.longitude),
        child: IconButton(
          icon: const Icon(Icons.location_pin),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(prediction.placeName),
              ),
            );
          },
        ),
      ));
      // markers.add(Marker(
      //   width: 50,
      //   alignment: Alignment.bottomCenter,
      //   rotate: false,
      // point: LatLng(prediction.latitude, prediction.longitude),
      //   child: Padding(
      //     padding: const EdgeInsets.all(4.0),
      //     child: Text(
      //       prediction.placeName,
      //       style: const TextStyle(fontWeight: FontWeight.bold),
      //     ),
      //   ),
      // ));
      markers.add(Marker(
        width: 55,
        height: 35,
        alignment: Alignment.topCenter,
        rotate: false,
        point: LatLng(
          prediction.latitude,
          prediction.longitude,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: prediction.lateblightProbability > 0.4
                  ? prediction.lateblightProbability > 0.7
                      ? Colors.red
                      : Colors.orange
                  : Colors.green,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              "${(prediction.lateblightProbability * 100).toStringAsFixed(0)}%",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ));
      return markers;
    }

    MapBloc mapBloc = BlocProvider.of<MapBloc>(context, listen: true);

    return Scaffold(
      body: GestureDetector(
        child: FlutterMap(
          mapController: controller,
          options: MapOptions(
            keepAlive: true,
            minZoom: 10,
            onMapEvent: (p0) {
              // for (var point in mapBloc.state.predictions) {
              //   print(p0.camera.visibleBounds
              //       .contains(LatLng(point.latitude, point.longitude)));
              // }
            },
            onTap: (tapPosition, point) {
              // controller.mapEventStream.map((event) => print(event));
            },
            initialCenter: mapBloc.getPosition() == null
                ? const LatLng(28.93, 81.27)
                : LatLng(mapBloc.getPosition()!.latitude,
                    mapBloc.getPosition()!.longitude),
            initialZoom: 9.2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.late_blight',
              subdomains: const ['a', 'b', 'c'],
            ),
            CircleLayer(
              circles: [
                CircleMarker(
                  point: mapBloc.getPosition() == null
                      ? const LatLng(28.93, 81.27)
                      : LatLng(mapBloc.getPosition()!.latitude,
                          mapBloc.getPosition()!.longitude),
                  radius: 10.0,
                  color: Colors.blue.withOpacity(0.7),
                  borderColor: Colors.blue,
                  borderStrokeWidth: 2.0,
                ),
              ],
            ),
            BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                if (state.state == RequestState.success) {
                  List<Marker> markers = [];
                  for (final item in state.predictions) {
                    for (final mark in marks(item)) {
                      markers.add(mark);
                    }
                  }
                  return MarkerLayer(
                    markers: markers,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
