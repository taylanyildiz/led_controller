import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  Color color = Colors.orange;

  void changeColor(color) {
    this.color = color;
    update();
  }
}
