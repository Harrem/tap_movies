import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:tap_movies/controller/search_controller.dart';
import 'package:tap_movies/widgets/error_widget.dart';
import 'package:tap_movies/widgets/movie_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final controller = Get.put(SearchController());
  var debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          // controller: TextEditingController(text: controller.query.value),
          onChanged: (value) {
            debouncer.call(() {
              controller.query.value = value;
              controller.searchMovies();
            });
          },
          decoration: InputDecoration(hintText: 'Search movies'),
        ),
      ),
      body: Obx(
        () =>
            controller.errorMessage.value.isNotEmpty &&
                !controller.isLoading.value
            ? CustomErrorWidget(
                errorMessage: controller.errorMessage.value,
                // retryAction: () => controller.searchMovies(),
              )
            : controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
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
