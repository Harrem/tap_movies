import 'package:get/get.dart';
import 'package:tap_movies/model/backdrop_model.dart';
import 'package:tap_movies/model/movie_model.dart';
import 'package:tap_movies/service/api_service.dart';

class HomeController extends GetxController {
  RxList<MovieModel> nowPlaying = RxList<MovieModel>();
  RxList<MovieModel> upcomingMovies = RxList<MovieModel>();
  RxList<MovieModel> latestMovies = RxList<MovieModel>();
  final ApiService apiService = Get.find<ApiService>();

  RxBool isLoadingNowPlaying = RxBool(false);
  RxBool isLoadingUpcomingMovies = RxBool(false);
  RxBool isLoadingLatestMovies = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    fetchNowPlaying();
    fetchUpcomingMovies();
    fetchLatestMovies();
  }

  Future<void> fetchNowPlaying() async {
    isLoadingNowPlaying.value = true;
    try {
      await Future.delayed(Duration(seconds: 10));
      final response = await apiService.getNowPlayingMovies();
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['results'];
        nowPlaying.assignAll(
          jsonList.map((json) => MovieModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingNowPlaying.value = false;
    }
  }

  Future<void> fetchUpcomingMovies() async {
    isLoadingUpcomingMovies.value = true;
    try {
      await Future.delayed(Duration(seconds: 10));

      final response = await apiService.getUpcomingMovies();
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['results'];
        upcomingMovies.assignAll(
          jsonList.map((json) => MovieModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingUpcomingMovies.value = false;
    }
  }

  Future<List<BackdropModel>> fetchMovieImages(int movieId) async {
    try {
      await Future.delayed(Duration(seconds: 10));

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

  Future<void> fetchLatestMovies() async {
    isLoadingLatestMovies.value = true;
    try {
      final response = await apiService.getTopRatedMovies();
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['results'];
        latestMovies.assignAll(
          jsonList.map((json) => MovieModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingLatestMovies.value = false;
    }
  }
}
