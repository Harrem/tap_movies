import 'package:flutter/material.dart';
import 'package:tap_movies/app/theme/app_colors.dart';
import 'package:tap_movies/controller/watchlist_controller.dart';
import 'package:get/get.dart';
import 'package:tap_movies/widgets/movie_card.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  final WatchlistController watchlistController =
      Get.find<WatchlistController>();

  @override
  void initState() {
    super.initState();
    watchlistController.getWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watchlist')),
      body: Obx(
        () => watchlistController.watchlist.isEmpty ? _emptyState() : _list(),
      ),
    );
  }

  Widget _list() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: .6,
        crossAxisCount: 2,
      ),
      itemCount: watchlistController.watchlist.length,
      itemBuilder: (context, index) {
        return MovieCard(movie: watchlistController.watchlist[index]);
      },
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('No movies in watchlist')],
      ),
    );
  }
}
