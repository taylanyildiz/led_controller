import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:led_controller/services/services.dart';

class HomeScreenController extends GetxController {
  Color color = Colors.orange;
  bool ledOn = true;

  @override
  void onInit() async {
    await UDPConnectionService.initializeSocket("192.168.1.102", 4023);
    super.onInit();
  }

  void onChangeColor(color) async {
    this.color = color;
    await UDPConnectionService.sendUdpData(color.toString());
    update();
  }

  void onOffOnPress() {
    ledOn = !ledOn;
    if (!ledOn) {
      UDPConnectionService.close();
    } else {
      UDPConnectionService.connect();
    }
    update();
  }
}
