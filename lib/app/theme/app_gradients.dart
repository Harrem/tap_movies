import 'package:flutter/material.dart';
import 'package:tap_movies/app/theme/app_colors.dart';

/// Reusable gradients for cinematic UI elements.
class AppGradients {
  AppGradients._();

  static const cinematic = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.navy, Color(0xFF071B3D), Color(0xFF0A4FA3)],
  );

  static const blueGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.blue, AppColors.blueDark],
  );

  static const goldGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.gold, AppColors.orange],
  );

  static const darkOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xCC030712)],
  );
}
