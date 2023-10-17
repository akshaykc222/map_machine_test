import 'package:go_router/go_router.dart';
import 'package:map_machine_test/map/presentation/pages/map_view_screen.dart';
import 'package:map_machine_test/map/presentation/route/app_pages.dart';

class RouteManger {
  static final routes =
      GoRouter(initialLocation: AppPages.pagePath(AppPages.home), routes: [
    GoRoute(
        path: AppPages.pagePath(AppPages.home),
        name: AppPages.home,
        builder: (context, state) => const MapViewScreen())
  ]);
}
