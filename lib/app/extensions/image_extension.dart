import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tap_movies/app/theme/app_gradients.dart';

// an extention for image network with loading and error handling
extension ImageExt on Image {
  Widget withDefaultOnError({String? defaultImagePath}) {
    return Image.network(
      (this.image as NetworkImage).url,
      height: height,
      width: width,
      fit: this.fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: height,
          decoration: BoxDecoration(gradient: AppGradients.cinematic),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // Return the default image on error
        return Container(
          height: height,
          decoration: BoxDecoration(gradient: AppGradients.cinematic),
        );
      },
    );
  }
}
