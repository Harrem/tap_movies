import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tap_movies/app/theme/app_colors.dart';

class ThemeController extends GetxController {
  RxBool isDark = false.obs;
  ThemeMode get themeMode => isDark.value ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    // Load theme from storage
    loadTheme();
  }

  void loadTheme() async {
    // Load theme from storage
    var prefs = await SharedPreferences.getInstance();
    isDark.value = prefs.getBool('isDark') ?? false;
  }

  void toggleTheme() {
    isDark.toggle();
    // Save theme to storage
    saveTheme();
  }

  void saveTheme() async {
    // Save theme to storage
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark.value);
  }
}
