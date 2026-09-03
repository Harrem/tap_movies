import 'package:get/get.dart';
import 'package:tap_movies/core/service/sqlite_service.dart';
import 'package:tap_movies/model/movie_model.dart';

class WatchlistController extends GetxController {
  RxList<MovieModel> watchlist = RxList<MovieModel>();
  final db = Get.find<SqliteService>();

  void addToWatchlist(MovieModel movie) {
    db.addToWatchList(movie).then((_) {
      watchlist.add(movie);
    });
  }

  void removeFromWatchlist(int movieId) {
    db.removeFromWatchList(movieId).then((_) {
      watchlist.removeWhere((movie) => movie.id == movieId);
    });
  }

  void toggleWatchlist(MovieModel movie) {
    if (isInWatchlist(movie.id)) {
      removeFromWatchlist(movie.id);
    } else {
      addToWatchlist(movie);
    }
  }

  bool isInWatchlist(int movieId) {
    return watchlist.any((movie) => movie.id == movieId);
  }

  void getWatchlist() {
    db.getWatchList().then((movies) {
      watchlist.assignAll(movies);
    });
  }

  void clearWatchlist() {
    db.clearWatchlist().then((_) {
      watchlist.clear();
    });
  }
}
