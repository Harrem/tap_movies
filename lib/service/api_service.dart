import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:tap_movies/helpers/dio_error_handler.dart';

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
    } on DioException catch (e) {
      debugPrint('Dio Error: ${e.message}');
      // Convert the ugly DioException into our friendly local handler
      final errorHandler = DioErrorHandler.fromDioException(e);

      // Throw the human-readable message onward to your UI or state management
      throw errorHandler.message;
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<Response> getUpcomingMovies() async {
    try {
      var response = await dio.get('/movie/upcoming');
      return response;
    } on DioException catch (e) {
      // Convert the ugly DioException into our friendly local handler
      final errorHandler = DioErrorHandler.fromDioException(e);

      // Throw the human-readable message onward to your UI or state management
      throw errorHandler.message;
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<Response> getNowPlayingMovies() async {
    try {
      var response = await dio.get('/movie/now_playing');
      return response;
    } on DioException catch (e) {
      // Convert the ugly DioException into our friendly local handler
      final errorHandler = DioErrorHandler.fromDioException(e);

      // Throw the human-readable message onward to your UI or state management
      throw errorHandler.message;
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<Response> getMovieDetails(int movieId) async {
    try {
      var response = await dio.get('/movie/$movieId');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMovieTrailers(int movieId) async {
    try {
      var response = await dio.get('/movie/$movieId/videos');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getSimilarMovies(int movieId) async {
    try {
      var response = await dio.get('/movie/$movieId/similar');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMovieRecommendations(int movieId) async {
    try {
      var response = await dio.get('/movie/$movieId/recommendations');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMovieImages(int movieId) async {
    try {
      var response = await dio.get('/movie/$movieId/images');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> searchMovies(String query) async {
    try {
      var response = await dio.get(
        '/search/movie',
        queryParameters: {'query': query, 'include_adult': true},
      );
      return response;
    } on DioException catch (e) {
      // Convert the ugly DioException into our friendly local handler
      final errorHandler = DioErrorHandler.fromDioException(e);

      // Throw the human-readable message onward to your UI or state management
      throw errorHandler.message;
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<Response> getMovie(int movieId) async {
    try {
      var response = await dio.get('/movie/$movieId');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
