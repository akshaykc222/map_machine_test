import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_machine_test/map/presentation/manager/map_bloc.dart';
import 'package:map_machine_test/map/presentation/res/app_theme.dart';
import 'package:map_machine_test/map/presentation/route/route_manager.dart';

class MapApp extends StatelessWidget {
  const MapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapBloc(),
      child: MaterialApp.router(
        routerConfig: RouteManger.routes,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
