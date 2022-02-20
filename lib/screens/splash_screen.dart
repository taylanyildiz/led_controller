import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:led_controller/widgets/widgets.dart';
import '/controllers/controllers.dart';
import '/gen/assets.gen.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLottiAnim,
          ],
        ),
      ),
    );
  }

  Widget get _buildLottiAnim {
    return GetBuilder<SplashScreenController>(builder: (_) {
      return LottieAnimation(
        controller: controller.lottieController,
        source: Assets.json.colorWheel,
        autoAnimate: true,
      );
    });
  }
}
