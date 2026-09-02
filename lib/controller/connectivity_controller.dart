import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityController extends GetxController {
  late final InternetConnectionChecker _internetConnection;

  @override
  void onInit() {
    super.onInit();
    _internetConnection = InternetConnectionChecker.createInstance();
  }

  RxBool isConnected = RxBool(false);

  @override
  void onReady() {
    super.onReady();
    _checkConnection();
    _internetConnection.onStatusChange.listen((status) {
      _checkConnection();
    });
  }

  Future<void> _checkConnection() async {
    isConnected.value = await _internetConnection.hasConnection;
  }

  void showNoInternetSnackBar() {
    if (!isConnected.value) {
      ScaffoldMessenger.of(Get.context!).showMaterialBanner(
        MaterialBanner(
          content: Text('No Internet', style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(Get.context!).hideCurrentMaterialBanner();
              },
              child: Text('Close', style: TextStyle(color: Colors.white)),
            ),
          ],

          backgroundColor: Colors.red,
          margin: EdgeInsets.all(10),
        ),
      );
    }
  }
}
