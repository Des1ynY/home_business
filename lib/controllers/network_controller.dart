import 'package:get/get.dart';
import 'package:home_business/appdata/theme.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';

class NetworkController extends GetxController {
  RxBool connected = true.obs;

  @override
  void onReady() {
    ever(connected, showAlert);

    InternetConnectionChecker().onStatusChange.listen((status) {
      connected.value = status == InternetConnectionStatus.connected;
    });

    super.onReady();
  }

  void showAlert(bool connected) {
    if (!connected) {
      Get.showSnackbar(GetSnackBar(
        message: 'Нет соединения',
        icon: Icon(Icons.perm_scan_wifi),
        backgroundColor: CustomTheme.red,
      ));
    } else {
      Get.closeAllSnackbars();
    }
  }
}
