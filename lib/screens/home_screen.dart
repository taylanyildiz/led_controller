import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/widgets/widgets.dart';
import '/controllers/controllers.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: _buildAppBar,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircleColorPicker,
                  _buildColorPicker,
                  _buildSpeedSlider,
                  _buildSettingSlider,
                ],
              ),
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

  Widget get _buildCircleColorPicker {
    return CircleColorPicker(
      strokeWidth: 50.0,
      size: const Size(200.0, 200.0),
      onChange: controller.onChangeColor,
      child: _buildOnOffButton,
      initialColor: controller.color,
    );
  }

  Widget get _buildColorPicker {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      child: ColorPickerBox(onSelect: controller.onChangeColor),
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
              size: 40.0,
              color: controller.color,
            ),
            const SizedBox(height: 10.0),
            Text(
              controller.ledOn ? "On" : "Off",
              style: TextStyle(
                color: controller.color,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildSpeedSlider {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: SliderLineHoriz(
        prefixIcon: const Icon(
          FontAwesomeIcons.forward,
          color: Colors.white,
          size: 20.0,
        ),
        onChanged: (value) {},
      ),
    );
  }

  Widget get _buildSettingSlider {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SliderLineHoriz(
        prefixIcon: const Icon(Icons.settings, color: Colors.white),
        onChanged: (value) {},
      ),
    );
  }
}
