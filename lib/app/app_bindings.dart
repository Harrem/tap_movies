import 'package:get/get.dart';
import 'package:tap_movies/controller/connectivity_controller.dart';
import 'package:tap_movies/controller/home_controller.dart';
import 'package:tap_movies/controller/movie_controller.dart';
import 'package:tap_movies/controller/watchlist_controller.dart';
import 'package:tap_movies/controller/theme_controller.dart';
import 'package:tap_movies/core/service/sqlite_service.dart';
import 'package:tap_movies/core/service/api_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(), permanent: true);
    Get.put(ConnectivityController(), permanent: true);
    Get.put(ApiService(), permanent: true);
    Get.put(SqliteService(), permanent: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => MovieController());
    Get.put(WatchlistController(), permanent: true);
  }
}
