import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;

class ApiService extends GetxService {
  late Dio dio;

  @override
  void onInit() {
    super.onInit();
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        queryParameters: {'api_key': dotenv.env['API_KEY']},
      ),
    );
  }

  Future<Response> getTopRatedMovies() async {
    try {
      var response = await dio.get('/movie/top_rated');
      return response;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  Future<Response> getUpcomingMovies() async {
    try {
      var response = await dio.get('/movie/upcoming');
      return response;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  Future<Response> getNowPlayingMovies() async {
    try {
      var response = await dio.get('/movie/now_playing');
      return response;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  Future<Response> getMovieDetails(int movieId) async {
    try {
      var response = await dio.get('/movie/$movieId');
      return response;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  Future<Response> getMovieTrailers(int movieId) async {
    try {
      var response = await dio.get('/movie/$movieId/videos');
      return response;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  Future<Response> getSimilarMovies(int movieId) async {
    try {
      var response = await dio.get('/movie/$movieId/similar');
      return response;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  Future<Response> getMovieRecommendations(int movieId) async {
    try {
      var response = await dio.get('/movie/$movieId/recommendations');
      return response;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  Future<Response> getMovieImages(int movieId) async {
    try {
      var response = await dio.get('/movie/$movieId/images');
      return response;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  Future<Response> getMovie(int movieId) async {
    try {
      var response = await dio.get('/movie/$movieId');
      return response;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }
}
