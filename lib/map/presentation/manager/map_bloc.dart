import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_machine_test/map/presentation/res/app_assets.dart';
import 'package:map_machine_test/map/presentation/res/app_colors.dart';
import 'package:map_machine_test/map/presentation/res/app_constants.dart';
import 'package:map_machine_test/map/presentation/widgets/car_details_sheet.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<MapEvent>((event, emit) async {});
    on<LoadMapEvent>((event, emit) async {
      emit(MapLoading());
      await setRoutes(event.context);
      emit(MapLoaded());
    });
    on<ShowCarDetails>((event, emit) {
      showModalBottomSheet(
          context: event.context,
          builder: (context) => CarDetailsBottomSheet(
                onTap: () {
                  Navigator.pop(context);
                },
              ));
    });
  }
  //map controller
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  //setting starting latitude and longitude
  final startPos = const CameraPosition(
    target: LatLng(10.371516, 76.304287),
    zoom: 13,
  );

  final List<Polyline> polyline = [];
  List<LatLng> routeCords = [];
  ValueNotifier<List<Marker>> markers = ValueNotifier([]);
  int currentIndex = 0;

  ///to create routes between starting position and destination position

  setRoutes(BuildContext context) async {
    currentIndex = 0;
    var start = const LatLng(10.371516, 76.304287);
    var dest = const LatLng(10.011564, 76.362599);
    var startMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), AppAssets.startingIcon);
    var endMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), AppAssets.finishingIcon);
    var carMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), AppAssets.car);
    markers.value.clear();
    markers.value.add(Marker(
        markerId: const MarkerId('start_point'),
        position: start,
        icon: startMarker));
    markers.value.add(Marker(
        markerId: const MarkerId('end_point'),
        position: dest,
        icon: endMarker));

    markers.value.add(Marker(
        markerId: const MarkerId('car'),
        icon: carMarker,
        onTap: () {
          add(ShowCarDetails(context));
        }));
    var data = await googleMapPolyline.getCoordinatesWithLocation(
        origin: start, destination: dest, mode: RouteMode.driving);
    // print(data);

    if (data != null) {
      routeCords.clear();
      routeCords.addAll(data);
    }

    polyline.add(Polyline(
        polylineId: const PolylineId('item'),
        visible: true,
        points: routeCords,
        width: 4,
        color: AppColors.blue,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap));
    animateCar();
  }

  ///to animate the car between the route
  animateCar() {
    if (currentIndex < routeCords.length) {
      markers.value[2] =
          markers.value[2].copyWith(positionParam: routeCords[currentIndex]);
      currentIndex++;
      markers.notifyListeners();
      Timer(const Duration(milliseconds: 300), animateCar);
    }
  }

  GoogleMapPolyline googleMapPolyline =
      GoogleMapPolyline(apiKey: AppConstants.mapKey);
  static MapBloc get(context) => BlocProvider.of(context);
}
