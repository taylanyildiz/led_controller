import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  child: _buildOnOffButton,
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

  Widget get _buildOnOffButton {
    return GestureDetector(
      onTap: controller.onOffOnPress,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.powerOff,
              size: 60.0,
              color: controller.color,
            ),
            const SizedBox(height: 10.0),
            Text(
              controller.ledOn ? "On" : "Off",
              style: TextStyle(
                color: controller.color,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
