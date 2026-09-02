import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap_movies/controller/connectivity_controller.dart';

class ChromeConnectionWrapper extends StatelessWidget {
  final Widget child;

  const ChromeConnectionWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Find the injected controller instance
    final ConnectivityController controller =
        Get.find<ConnectivityController>();

    return Scaffold(
      body: Column(
        children: [
          // Obx automatically repaints this slice whenever our network states morph
          Obx(() {
            final Color backgroundColor = controller.isOffline.value
                ? const Color(0xFF202124)
                : Colors.green;
            final String labelText = controller.isOffline.value
                ? 'You are offline'
                : 'Back online';
            final IconData icon = controller.isOffline.value
                ? Icons.cloud_off
                : Icons.check_circle_outline;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: controller.displayBanner
                  ? 50 + MediaQuery.of(context).padding.top
                  : 0,
              color: backgroundColor,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  height: 50 + MediaQuery.of(context).padding.top,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(icon, color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        labelText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          // Remaining screen UI layout
          Expanded(child: child),
        ],
      ),
    );
  }
}
