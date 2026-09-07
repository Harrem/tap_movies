import 'package:get/get.dart';
import 'package:tap_movies/model/movie_model.dart';
import 'package:tap_movies/core/service/api_service.dart';

class SearchMovieController extends GetxController {
  RxString query = ''.obs;
  RxList<MovieModel> results = <MovieModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  final ApiService apiService = Get.find<ApiService>();

  Future<void> searchMovies() async {
    isLoading.value = true;
    try {
      final response = await apiService.searchMovies(query.value);
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['results'];
        final List<MovieModel> movies = jsonList
            .map((json) => MovieModel.fromJson(json))
            .toList();
        results.value = movies;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
