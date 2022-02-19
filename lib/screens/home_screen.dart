import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:led_controller/widgets/widgets.dart';
import '/controllers/controllers.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (_) {
        return Scaffold(
          appBar: _buildAppBar,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleColorPicker(
                  strokeWidth: 50.0,
                  size: const Size(250.0, 250.0),
                  onChange: controller.changeColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar get _buildAppBar {
    return AppBar(
      backgroundColor: controller.color,
    );
  }
}
