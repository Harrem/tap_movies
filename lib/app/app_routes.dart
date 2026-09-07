import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tap_movies/view/home_view.dart';
import 'package:tap_movies/view/movie_detail_view.dart';
import 'package:tap_movies/view/search_view.dart';
import 'package:tap_movies/view/splash_view.dart';
import 'package:tap_movies/view/watchlist_view.dart';

class AppRoutes {
  static const splash = '/splash';
  static const home = '/home';
  static const movieDetail = '/movie/:id';
  static const watchlist = '/watchlist';
  static const search = '/search';

  static final routes = [
    GetPage(name: splash, page: () => SplashView()),
    GetPage(name: home, page: () => MyHomePage()),
    GetPage(name: movieDetail, page: () => MovieDetailView()),
    GetPage(name: watchlist, page: () => Watchlist()),
    GetPage(name: search, page: () => SearchView()),
  ];
}
