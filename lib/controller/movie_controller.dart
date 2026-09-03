import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tap_movies/controller/watchlist_controller.dart';
import 'package:tap_movies/model/backdrop_model.dart';
import 'package:tap_movies/model/movie_detail_model.dart';
import 'package:tap_movies/model/movie_model.dart';
import 'package:tap_movies/model/video_model.dart';
import 'package:tap_movies/core/service/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

// fake movie data for making skeletonizer work
final fakeMovieModel = MovieDetailModel(
  backdropPath: '',
  id: 1,
  originalTitle: '-----',
  overview: '-----',
  popularity: 0,
  releaseDate: '0000-00-00',
  title: '-----',
  voteAverage: 0,
  voteCount: 0,
  posterPath: '',
  genres: [],
  homepage: '',
  runtime: 0,
  status: '',
  tagline: '',
  adult: false,
  budget: 0,
  imdbId: '',
  originCountry: [],
  originalLanguage: '',
  productionCompanies: [],
  productionCountries: [],
  revenue: 0,
  spokenLanguages: [],
  video: false,
);

class MovieController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final WatchlistController watchlistController =
      Get.find<WatchlistController>();

  Rx<MovieDetailModel?> movie = Rx<MovieDetailModel?>(null);
  RxList<BackdropModel> backdrops = RxList<BackdropModel>();
  RxList<VideoModel> trailers = RxList<VideoModel>();
  RxList<MovieModel> similarMovies = RxList<MovieModel>();
  RxList<MovieModel> recommendationMovies = RxList<MovieModel>();

  RxBool isLoading = RxBool(false);
  RxString errorMessage = RxString("");

  late int movieId;

  @override
  void onInit() async {
    super.onInit();
    movie.value = fakeMovieModel;
    if (Get.parameters['id'] != null && Get.parameters['id'] != '') {
      movieId = int.parse(Get.parameters['id']!);
    } else {
      Get.back();
      Get.rawSnackbar(
        title: 'No movie ID found',
        message: 'Please try again',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    await fetchMovie();
    await fetchMovieDropback();
    await fetchMovieTrailers();
    await fetchSimilarMovies();
    await fetchRecommendationMovies();
  }

  Future<void> refreshPage() async {
    await fetchMovie();
    await fetchMovieDropback();
    await fetchMovieTrailers();
    await fetchSimilarMovies();
    await fetchRecommendationMovies();
  }

  Future<void> fetchMovie() async {
    isLoading.value = true;
    errorMessage.value = "";
    try {
      await Future.delayed(Duration(seconds: 2));
      final response = await apiService.getMovie(movieId);
      if (response.statusCode == 200) {
        movie.value = MovieDetailModel.fromJson(response.data);
      }
    } catch (e) {
      errorMessage.value = '$e';
      debugPrint('fetchMovie: ${e.toString()}');
    } finally {}
  }

  bool isInWatchlist() {
    return watchlistController.isInWatchlist(movieId);
  }

  void toggleWatchlist(MovieModel movie) {
    watchlistController.toggleWatchlist(movie);
  }

  Future<void> fetchMovieDropback() async {
    try {
      final response = await apiService.getMovieImages(movieId);
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['backdrops'];
        backdrops.assignAll(
          jsonList.map((json) => BackdropModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      debugPrint('fetchMovieDropback: ${e.toString()}');
    }
  }

  Future<void> fetchMovieTrailers() async {
    try {
      final response = await apiService.getMovieTrailers(movieId);
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['results'];
        trailers.assignAll(
          jsonList.map((json) => VideoModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      debugPrint('fetchMovieTrailers: ${e.toString()}');
    }
  }

  Future<void> fetchSimilarMovies() async {
    try {
      final response = await apiService.getSimilarMovies(movieId);
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['results'];
        similarMovies.assignAll(
          jsonList.map((json) => MovieModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      debugPrint('fetchSimilarMovies: ${e.toString()}');
    }
  }

  Future<void> fetchRecommendationMovies() async {
    try {
      final response = await apiService.getRecommendationMovies(movieId);
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['results'];
        recommendationMovies.assignAll(
          jsonList.map((json) => MovieModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      debugPrint('fetchRecommendationMovies: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> launchTrailerUrl(VideoModel trailer) async {
    final String urlString = trailer.getTrailorUrl();
    final Uri url = Uri.parse(urlString);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        Get.rawSnackbar(
          title: 'Error',
          message: 'Could not launch video link',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
