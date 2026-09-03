import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tap_movies/app/extensions/image_extension.dart';
import 'package:tap_movies/controller/movie_controller.dart';
import 'package:tap_movies/controller/theme_controller.dart';
import 'package:tap_movies/widgets/error_widget.dart';
import 'package:tap_movies/widgets/movie_card.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({super.key});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  late MovieController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(MovieController(), tag: Get.parameters['id']);
    controller.fetchMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Skeletonizer(
          ignoreContainers: true,
          enabled: controller.isLoading.value,
          child: RefreshIndicator(
            onRefresh: () async => await controller.refreshPage(),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: Get.height * .5,
                  floating: true,
                  pinned: true,
                  title: Text(controller.movie.value?.title ?? ''),
                  actions: [
                    IconButton(
                      icon: controller.isInWatchlist()
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border),
                      onPressed: () {
                        controller.toggleWatchlist(
                          controller.movie.value!.toMovieModel(),
                        );
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: Get.height * .5,
                            viewportFraction: 1,
                            autoPlay: true,
                            enlargeCenterPage: false,
                          ),
                          items: controller.backdrops.map((backdrop) {
                            return Image.network(
                              'https://image.tmdb.org/t/p/w500${backdrop.filePath}',
                              height: Get.height * .5,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey,
                                      height: Get.height * .5,
                                      child: Center(child: Icon(Icons.error)),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey,
                                  height: Get.height * .5,
                                  child: Center(child: Icon(Icons.error)),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [
                                AppColors.darkBackground,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.center,
                              colors: [
                                AppColors.darkSurfaceElevated,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 16,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${controller.movie.value?.posterPath}',
                                  height: 200,
                                  fit: BoxFit.cover,
                                ).withDefaultOnError(),
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.movie.value?.title ?? '',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      _chip(
                                        DateTime.parse(
                                          controller.movie.value?.releaseDate ??
                                              '0000-00-00',
                                        ).year.toString(),
                                        Icons.calendar_today,
                                      ),
                                      _chip(
                                        controller.movie.value?.voteAverage
                                                .toStringAsFixed(1) ??
                                            '',
                                        Icons.star,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '(${controller.movie.value?.voteCount})',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                controller.errorMessage.value.isNotEmpty &&
                        !controller.isLoading.value
                    ? SliverToBoxAdapter(
                        child: CustomErrorWidget(
                          errorMessage: controller.errorMessage.value,
                          retryAction: () => controller.refreshPage(),
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildGenreChips(),

                              Text(
                                'Overview',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                controller.movie.value?.overview ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              _section('Trailers', _buildTrailers()),
                              _section('Similar Movies', _similarMovies()),
                              _section(
                                'Recommendation Movies',
                                _recommendationMovies(),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, IconData? icon) {
    return Chip(
      label: Text(label),
      labelPadding: icon != null
          ? EdgeInsets.only(right: 8)
          : EdgeInsets.symmetric(horizontal: 8),
      avatar: icon != null
          ? Icon(icon, color: Colors.white.withAlpha(128), size: 14)
          : null,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      side: BorderSide.none,
      shape: StadiumBorder(),
      backgroundColor: AppColors.darkSurfaceElevated,
      labelStyle: TextStyle(color: Colors.white.withAlpha(128)),
    );
  }

  Widget _buildGenreChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: controller.movie.value!.genres.map((genre) {
        return _chip(genre.name, null);
      }).toList(),
    );
  }

  Widget _buildTrailers() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.trailers.length,
        itemBuilder: (context, index) {
          final trailer = controller.trailers[index];

          return GestureDetector(
            onTap: () {
              controller.launchTrailerUrl(trailer);
            },
            child: Container(
              width: Get.width * 0.8,
              margin: const EdgeInsets.only(right: 12),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Image.network(
                trailer.getYoutubeThumbnail(),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[900],
                  child: const Icon(Icons.broken_image, color: Colors.white54),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _similarMovies() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: controller.similarMovies.length,
        itemBuilder: (context, index) {
          return MovieCard(movie: controller.similarMovies[index]);
        },
      ),
    );
  }

  Widget _recommendationMovies() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: controller.similarMovies.length,
        itemBuilder: (context, index) {
          return MovieCard(movie: controller.similarMovies[index]);
        },
      ),
    );
  }

  Widget _section(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 36),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12),
        child,
      ],
    );
  }
}
