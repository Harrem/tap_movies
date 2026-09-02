import 'package:get/get.dart';
import 'package:tap_movies/model/movie_model.dart';
import 'package:tap_movies/service/api_service.dart';

class MovieController extends GetxController {
  RxBool isLoading = RxBool(false);

  final ApiService apiService = Get.find<ApiService>();

  Rx<MovieModel?> movie = Rx<MovieModel?>(null);

  Future<void> fetchMovie() async {
    isLoading.value = true;
    int movieId = int.parse(Get.parameters['id'] ?? '0');
    try {
      final response = await apiService.getMovie(movieId);
      if (response.statusCode == 200) {
        movie.value = MovieModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
