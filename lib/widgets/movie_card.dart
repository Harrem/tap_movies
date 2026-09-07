import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap_movies/app/theme/app_gradients.dart';
import 'package:tap_movies/controller/theme_controller.dart';
import 'package:tap_movies/model/movie_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () {
          Get.toNamed('/movie/${movie.id}');
        },
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      decoration: BoxDecoration(
                        gradient: AppGradients.cinematic,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: AppGradients.cinematic,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.image, color: Colors.grey[600]),
                    );
                  },
                ),
              ),
            ),
            Text(
              movie.title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Text(
                  '(${movie.voteCount})',
                  style: TextStyle(
                    fontSize: 12,
                    color: Get.find<ThemeController>().isDark.value
                        ? Colors.white70
                        : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
