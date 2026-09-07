import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tap_movies/model/backdrop_model.dart';
import 'package:tap_movies/model/movie_model.dart';
import 'package:tap_movies/core/service/api_service.dart';

// Fake movie data for skeletonizer
final fakeMovieModel = MovieModel(
  genreIds: [],
  id: 1,
  originalTitle: '-----',
  overview: '-----',
  popularity: 0,
  releaseDate: '0000-00-00',
  title: '-----',
  voteAverage: 0,
  voteCount: 0,
  posterPath: '',
);

class HomeController extends GetxController {
  RxList<MovieModel> nowPlaying = RxList<MovieModel>();
  RxList<MovieModel> upcomingMovies = RxList<MovieModel>();
  RxList<MovieModel> discoverMovies = RxList<MovieModel>();
  RxList<MovieModel> topRatedMovies = RxList<MovieModel>();
  final ApiService apiService = Get.find<ApiService>();

  RxString errorMessage = RxString("");

  RxBool isLoadingNowPlaying = RxBool(false);
  RxBool isLoadingUpcomingMovies = RxBool(false);
  RxBool isLoadingDiscoverMovies = RxBool(false);
  RxBool isLoadingTopRatedMovies = RxBool(false);
  bool get isLoadingAll =>
      isLoadingNowPlaying.value ||
      isLoadingUpcomingMovies.value ||
      isLoadingDiscoverMovies.value ||
      isLoadingTopRatedMovies.value;

  DateTime? _lastPressedAt;

  @override
  void onInit() {
    super.onInit();
    nowPlaying.add(fakeMovieModel);
    upcomingMovies.add(fakeMovieModel);
    discoverMovies.add(fakeMovieModel);
    topRatedMovies.add(fakeMovieModel);
    fetchNowPlaying();
    fetchUpcomingMovies();
    fetchDiscoverMovies();
    fetchTopRatedMovies();
  }

  bool handleBackPress() {
    final now = DateTime.now();

    final isFirstPressOrTooDelayed =
        _lastPressedAt == null ||
        now.difference(_lastPressedAt!) > const Duration(seconds: 2);

    if (isFirstPressOrTooDelayed) {
      _lastPressedAt = now;
      return false; // Do not exit yet
    }

    // Secondary press within 2 seconds
    return true; // Safe to exit
  }

  /// Cleans up the app and triggers the system exit
  Future<void> exitApp() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  Future<void> refreshAll() async {
    fetchNowPlaying();
    fetchUpcomingMovies();
    fetchDiscoverMovies();
    fetchTopRatedMovies();
  }

  Future<void> fetchNowPlaying() async {
    isLoadingNowPlaying.value = true;
    errorMessage.value = "";
    try {
      final response = await apiService.getNowPlayingMovies();
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['results'];
        nowPlaying.assignAll(
          jsonList.map((json) => MovieModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingNowPlaying.value = false;
    }
  }

  Future<void> fetchUpcomingMovies() async {
    isLoadingUpcomingMovies.value = true;
    errorMessage.value = "";
    try {
      final response = await apiService.getUpcomingMovies();
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['results'];
        upcomingMovies.assignAll(
          jsonList.map((json) => MovieModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingUpcomingMovies.value = false;
    }
  }

  Future<List<BackdropModel>> fetchMovieImages(int movieId) async {
    try {
      final response = await apiService.getMovieImages(movieId);
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['backdrops'];
        return jsonList.map((json) => BackdropModel.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> fetchDiscoverMovies() async {
    isLoadingDiscoverMovies.value = true;
    errorMessage.value = "";
    try {
      final response = await apiService.getDiscoverMovies();
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['results'];
        discoverMovies.assignAll(
          jsonList.map((json) => MovieModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingDiscoverMovies.value = false;
    }
  }

  Future<void> fetchTopRatedMovies() async {
    isLoadingTopRatedMovies.value = true;
    errorMessage.value = "";
    try {
      final response = await apiService.getTopRatedMovies();
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['results'];
        topRatedMovies.assignAll(
          jsonList.map((json) => MovieModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingTopRatedMovies.value = false;
    }
  }
}
