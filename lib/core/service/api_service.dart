import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:tap_movies/core/helpers/dio_error_handler.dart';
import 'package:tap_movies/core/service/api_endpoints.dart';

/* we don't need repositories for such small scale app that's why
   we directly implement fetching movies from ApiService
   instead of using multiple layers of abstraction.
*/

class ApiService extends GetxService {
  late Dio dio;

  @override
  void onInit() async {
    super.onInit();
    try {
      await dotenv.load(fileName: ".env");
      dio = Dio(
        BaseOptions(
          baseUrl: ApiEndPoints.baseUrl,
          queryParameters: {'api_key': dotenv.env['API_KEY']},
        ),
      );
    } catch (e) {
      debugPrint('Failed to load .env file: $e');
      dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          debugPrint('Request: ${options.method} ${options.path}');
          debugPrint('data: ${options.data}');
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          debugPrint('Error: ${e.response?.statusCode} ${e.response?.data}');
          return handler.next(e);
        },

        onResponse: (response, handler) async {
          debugPrint('Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
      ),
    );
  }

  Future<Response> getTopRatedMovies() async {
    try {
      var response = await dio.get(ApiEndPoints.topRatedMovies);
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
      var response = await dio.get(ApiEndPoints.upcomingMovies);
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
      var response = await dio.get(ApiEndPoints.nowPlayingMovies);
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

  Future<Response> getDiscoverMovies() async {
    try {
      var response = await dio.get(ApiEndPoints.discoverMovies);
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
      var response = await dio.get(ApiEndPoints.movieDetail(movieId));
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

  Future<Response> getMovieTrailers(int movieId) async {
    try {
      var response = await dio.get(ApiEndPoints.movieTrailers(movieId));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getSimilarMovies(int movieId) async {
    try {
      var response = await dio.get(ApiEndPoints.similarMovies(movieId));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getRecommendationMovies(int movieId) async {
    try {
      var response = await dio.get(ApiEndPoints.movieRecommendations(movieId));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMovieImages(int movieId) async {
    try {
      var response = await dio.get(ApiEndPoints.movieImages(movieId));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> searchMovies(String query) async {
    try {
      var response = await dio.get(
        ApiEndPoints.searchMovies,
        queryParameters: {'query': query},
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
}
