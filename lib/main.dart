import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap_movies/app_bindings.dart';
import 'package:tap_movies/controller/theme_controller.dart';
import 'package:tap_movies/widgets/chrome_connection_wrapper.dart';
import 'app_routes.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'Tap Movies',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: Get.put(ThemeController()).themeMode,
        builder: (context, child) {
          return ChromeConnectionWrapper(
            child: child ?? const SizedBox.shrink(),
          );
        },
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.routes,
        initialBinding: AppBindings(),
      ),
    );
  }
}
