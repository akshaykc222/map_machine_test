import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_machine_test/map/presentation/manager/map_bloc.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  late MapBloc _mapBloc;

  @override
  void initState() {
    _mapBloc = MapBloc.get(context);
    _mapBloc.add(LoadMapEvent(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return state is MapLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ValueListenableBuilder(
                  valueListenable: _mapBloc.markers,
                  builder: (context, data, child) {
                    return GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: _mapBloc.startPos,
                      polylines: _mapBloc.polyline.toSet(),
                      markers: _mapBloc.markers.value.toSet(),
                      onMapCreated: (GoogleMapController controller) {
                        _mapBloc.mapController.complete(controller);
                      },
                    );
                  });
        },
      ),
    );
  }
}
