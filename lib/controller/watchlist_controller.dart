import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tap_movies/core/service/sqlite_service.dart';
import 'package:tap_movies/model/movie_model.dart';

class WatchlistController extends GetxController {
  RxList<MovieModel> watchlist = RxList<MovieModel>();
  final db = Get.find<SqliteService>();

  void addToWatchlist(MovieModel movie) {
    db.addToWatchList(movie).then((_) {
      watchlist.add(movie);
      Fluttertoast.showToast(
        msg: "Movie added to watchlist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  void removeFromWatchlist(int movieId) {
    db.removeFromWatchList(movieId).then((_) {
      watchlist.removeWhere((movie) => movie.id == movieId);
      Fluttertoast.showToast(
        msg: "Movie removed from watchlist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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
      Fluttertoast.showToast(
        msg: "Watchlist cleared",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }
}
