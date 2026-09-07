import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:tap_movies/app/theme/app_colors.dart';
import 'package:tap_movies/controller/search_movie_controller.dart';
import 'package:tap_movies/widgets/error_widget.dart';
import 'package:tap_movies/widgets/movie_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final controller = Get.put(SearchMovieController());
  var debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height * .1,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: TextField(
            autofocus: true,
            onChanged: (value) {
              debouncer.call(() {
                controller.query.value = value;
                controller.searchMovies();
              });
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search movies',
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              fillColor: AppColors.inputFilled,
            ),
          ),
        ),
      ),
      body: Obx(
        () =>
            controller.errorMessage.value.isNotEmpty &&
                !controller.isLoading.value
            ? CustomErrorWidget(errorMessage: controller.errorMessage.value)
            : controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : (controller.query.isEmpty && controller.results.isEmpty)
            ? Center(
                child: Text(
                  'Search movies',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            : (controller.query.isNotEmpty && controller.results.isEmpty)
            ? Center(
                child: Text(
                  'No movies found',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            : RefreshIndicator(
                onRefresh: () async => await controller.searchMovies(),
                child: SafeArea(
                  child: GridView.builder(
                    padding: EdgeInsetsDirectional.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .6,
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: controller.results.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: controller.results[index]);
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
