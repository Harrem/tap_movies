import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tap_movies/app/extensions/image_extension.dart';
import 'package:tap_movies/app/theme/app_colors.dart';
import 'package:tap_movies/app/theme/app_gradients.dart';
import 'package:tap_movies/controller/home_controller.dart';
import 'package:tap_movies/controller/theme_controller.dart';
import 'package:tap_movies/widgets/error_widget.dart';
import 'package:tap_movies/widgets/movie_card.dart';

/* 
This is the home view of the application that displays the list of movies 
in the home screen. It uses custom sliver app bar with sliver list and sliver grid 
to display the data to elevate ui and ux.

it has three main sections: now playing movies, top rated movies, and similar movies
it also has a drawer that displays the list of movies in the home screen.
it also has a search icon in the app bar that navigates to the search view.

the error widget and empty widget are also customized to display the data to elevate ui and ux.

the theme controller is used to switch between dark and light mode.
*/

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomeController controller = Get.find<HomeController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // Delegate the logic to the controller
        final shouldExit = controller.handleBackPress();

        if (shouldExit) {
          await controller.exitApp();
        } else {
          // Keep UI actions like SnackBar in the View layer
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },

      child: Scaffold(
        key: _scaffoldKey,
        drawer: _drawer(),
        body: Obx(
          () => RefreshIndicator(
            onRefresh: () async => await controller.refreshAll(),
            child: SafeArea(
              top: false,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    toolbarHeight: 80,
                    expandedHeight: Get.height * .46,
                    floating: true,
                    pinned: true,
                    backgroundColor: AppColors.darkSurface,
                    foregroundColor: Colors.white,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => Get.toNamed('/search'),
                      ),
                    ],
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TAP MOVIES',
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Discover the best movies',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    centerTitle: false,
                    flexibleSpace:
                        controller.errorMessage.value.isNotEmpty &&
                            !controller.isLoadingAll
                        ? null
                        : FlexibleSpaceBar(background: _hero()),
                  ),
                  controller.errorMessage.value.isNotEmpty &&
                          !controller.isLoadingAll
                      ? SliverList(
                          delegate: SliverChildListDelegate([
                            CustomErrorWidget(
                              errorMessage: controller.errorMessage.value,
                              retryAction: () => controller.refreshAll(),
                            ),
                          ]),
                        )
                      : SliverList(
                          delegate: SliverChildListDelegate([
                            _section("Upcoming movies", _upcoming()),
                            _section("Top rated movies", _topRated()),
                            _section("Discover movies", _discover()),
                          ]),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
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

  Widget _hero() {
    return Obx(
      () => Skeletonizer(
        enabled: controller.isLoadingNowPlaying.value,
        child: CarouselSlider.builder(
          options: CarouselOptions(
            height: Get.height * .8,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: false,
          ),
          itemCount: controller.nowPlaying.length,
          itemBuilder: (context, index, realIndex) {
            return Stack(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w1280${controller.nowPlaying[index].backdropPath}',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ).withDefaultOnError(),
                Positioned(
                  top: 0,
                  child: Container(
                    height: Get.height * .3,
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // shade from bottom
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${controller.nowPlaying[index].posterPath}',
                            height: 150,
                            fit: BoxFit.cover,
                          ).withDefaultOnError(),
                        ),
                        SizedBox(width: 10),
                        Text(
                          controller.nowPlaying[index].title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          spacing: 4,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 14),
                            Text(
                              controller.nowPlaying[index].voteAverage
                                  .toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            //Dot
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withAlpha(128),
                              ),
                            ),
                            Text(
                              '${DateTime.parse(controller.nowPlaying[index].releaseDate).year}',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: GoogleFonts.poppins().toString(),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withAlpha(128),
                              ),
                            ),
                            Text(
                              '${controller.nowPlaying[index].voteCount} votes',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: 128,
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () => Get.toNamed(
                              '/movie/${controller.nowPlaying[index].id}',
                            ),
                            child: Text("More details"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Positioned(
                //   top: 16,
                //   left: 16,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                //     decoration: BoxDecoration(
                //       gradient: AppGradients.cinematic.withOpacity(.5),
                //       borderRadius: BorderRadius.circular(20),
                //       border: Border.all(
                //         color: Colors.white.withOpacity(.5),
                //         width: 1,
                //       ),
                //     ),
                //     child: Row(
                //       children: [
                //         Icon(Icons.play_circle, color: Colors.white),
                //         SizedBox(width: 8),
                //         Text(
                //           "Now Playing",
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 14,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(gradient: AppGradients.cinematic),
            accountName: Text("Tap Movies"),
            accountEmail: Text("Discover your next favorite movie"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite_border, size: 22),
            title: Text(
              'Watch List',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.toNamed('/watchlist');
            },
          ),
          Divider(height: 2, indent: 16, endIndent: 16),
          Obx(
            () => SwitchListTile(
              secondary: Get.find<ThemeController>().isDark.value
                  ? Icon(Icons.dark_mode, size: 22)
                  : Icon(Icons.wb_sunny, size: 22),
              value: Get.find<ThemeController>().isDark.value,
              title: Text(
                'Dark Mode',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onChanged: (value) {
                Get.find<ThemeController>().toggleTheme();
              },
            ),
          ),
          Spacer(),
          SafeArea(
            child: Text(
              'Tap Movies © 2026',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _upcoming() {
    return SizedBox(
      height: 200,
      child: Skeletonizer(
        enabled: controller.isLoadingUpcomingMovies.value,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 16),
          scrollDirection: Axis.horizontal,
          itemCount: controller.upcomingMovies.length,
          itemBuilder: (context, index) {
            return MovieCard(movie: controller.upcomingMovies[index]);
          },
        ),
      ),
    );
  }

  Widget _discover() {
    return SizedBox(
      height: 200,
      child: Skeletonizer(
        enabled: controller.isLoadingDiscoverMovies.value,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 16),
          scrollDirection: Axis.horizontal,
          itemCount: controller.discoverMovies.length,
          itemBuilder: (context, index) {
            return MovieCard(movie: controller.discoverMovies[index]);
          },
        ),
      ),
    );
  }

  Widget _topRated() {
    return SizedBox(
      height: 200,
      child: Skeletonizer(
        enabled: controller.isLoadingTopRatedMovies.value,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 16),
          scrollDirection: Axis.horizontal,
          itemCount: controller.topRatedMovies.length,
          itemBuilder: (context, index) {
            return MovieCard(movie: controller.topRatedMovies[index]);
          },
        ),
      ),
    );
  }
}
