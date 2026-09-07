import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tap_movies/app/extensions/image_extension.dart';
import 'package:tap_movies/app/theme/app_colors.dart';
import 'package:tap_movies/controller/movie_controller.dart';
import 'package:tap_movies/core/service/api_endpoints.dart';
import 'package:tap_movies/widgets/error_widget.dart';
import 'package:tap_movies/widgets/movie_card.dart';

/* 
This is a movie detail view that displays the details of a movie, 
including the movie's title, overview, images, trailers, similar movies, 
and recommendation movies. 
it uses custom sliver app bar with sliver list and sliver grid to display the data to elevate ui and ux.
*/

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
          // ignoreContainers: true,
          enabled: controller.isLoading.value,
          child: RefreshIndicator(
            onRefresh: () async => await controller.refreshPage(),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: Get.height * .5,
                  floating: true,
                  pinned: true,
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
                            height: double.infinity,
                            viewportFraction: 1,
                            autoPlay: true,
                            enlargeCenterPage: false,
                          ),
                          items: controller.backdrops.map((backdrop) {
                            return Image.network(
                              '${ApiEndPoints.imageUrl1280}${backdrop.filePath}',
                              fit: BoxFit.cover,
                            ).withDefaultOnError();
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
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  '${ApiEndPoints.imageUrl500}${controller.movie.value?.posterPath}',
                                  height: Get.height * .24,
                                  fit: BoxFit.cover,
                                ).withDefaultOnError(),
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width * .6,
                                    child: Text(
                                      controller.movie.value?.title ?? '',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildGenreChips(),

                            _section("Overview", _buildOverview()),
                            _section('Photos', _buildPhotos()),
                            _section('Trailers', _buildTrailers()),
                            _section('Similar Movies', _similarMovies()),
                            SafeArea(child: SizedBox()),
                          ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: controller.movie.value!.genres.map((genre) {
          return _chip(genre.name, null);
        }).toList(),
      ),
    );
  }

  Widget _buildOverview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        controller.movie.value?.overview ?? '',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  Widget _buildPhotos() {
    return controller.backdrops.isEmpty
        ? Center(
            child: Text(
              'No photos found',
              style: TextStyle(color: Colors.grey),
            ),
          )
        : SizedBox(
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: controller.backdrops.length,
              itemBuilder: (context, index) {
                final backdrop = controller.backdrops[index];

                return Container(
                  width: Get.width * 0.8,
                  margin: const EdgeInsets.only(right: 12),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    backdrop.getBackdropUrl(),
                    fit: BoxFit.cover,
                  ).withDefaultOnError(),
                );
              },
            ),
          );
  }

  Widget _buildTrailers() {
    return controller.trailers.isEmpty
        ? Center(
            child: Text(
              'No trailers found',
              style: TextStyle(color: Colors.grey),
            ),
          )
        : SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.trailers.length,
              itemBuilder: (context, index) {
                final trailer = controller.trailers[index];

                return Container(
                  width: Get.width * 0.8,
                  margin: const EdgeInsets.only(right: 12),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(trailer.getYoutubeThumbnail()),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      controller.launchTrailerUrl(trailer);
                    },
                    child: const Icon(
                      Icons.play_arrow,
                      size: 64,
                      color: Colors.white,
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
