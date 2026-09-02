import 'package:get/get.dart';
import 'package:tap_movies/controller/connectivity_controller.dart';
import 'package:tap_movies/controller/home_controller.dart';
import 'package:tap_movies/controller/movie_controller.dart';
import 'package:tap_movies/controller/watchlist_controller.dart';
import 'package:tap_movies/controller/theme_controller.dart';
import 'package:tap_movies/database/sqlite_helper.dart';
import 'package:tap_movies/service/api_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectivityController(), permanent: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => MovieController());
    Get.lazyPut(() => WatchlistController(), fenix: true);
    Get.lazyPut(() => ApiService());
    Get.put(() => ThemeController(), permanent: true);
    Get.put(SqliteHelper());
  }
}
