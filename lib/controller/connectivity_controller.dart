import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityController extends GetxController {
  late final InternetConnectionChecker _internetConnection;
  StreamSubscription<InternetConnectionStatus>? _subscription;
  Timer? _hideTimer;

  // State observables for the UI layout
  final RxBool isOffline = false.obs;
  final RxBool showSuccessBanner = false.obs;

  // Track history to distinguish fresh boots from toggles
  bool _wasOffline = false;

  // Computed property to let your UI know when to drop the banner down
  bool get displayBanner => isOffline.value || showSuccessBanner.value;

  @override
  void onInit() {
    super.onInit();
    _internetConnection = InternetConnectionChecker.createInstance();
  }

  @override
  void onReady() {
    super.onReady();
    _initConnectionListener();
  }

  void _initConnectionListener() {
    _subscription = _internetConnection.onStatusChange.listen((
      InternetConnectionStatus status,
    ) {
      final bool isCurrentlyConnected =
          status == InternetConnectionStatus.connected;

      if (!isCurrentlyConnected) {
        // User dropped connection
        isOffline.value = true;
        _wasOffline = true;
        showSuccessBanner.value = false;
        _hideTimer?.cancel();
      } else {
        // User regained connection
        isOffline.value = false;

        if (_wasOffline) {
          showSuccessBanner.value = true;
          _wasOffline = false;

          // Trigger the 2-second flash auto-hide
          _hideTimer?.cancel();
          _hideTimer = Timer(const Duration(seconds: 2), () {
            showSuccessBanner.value = false;
          });
        }
      }
    });
  }

  @override
  void onClose() {
    _subscription?.cancel();
    _hideTimer?.cancel();
    super.onClose();
  }
}
