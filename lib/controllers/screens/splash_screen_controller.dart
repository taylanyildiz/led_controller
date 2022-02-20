import 'package:get/get.dart';
import 'package:led_controller/routes/app_routes.dart';
import '/widgets/widgets.dart';

class SplashScreenController extends GetxController {
  /// Lotti widget controller.
  late LottieController lottieController;

  @override
  void onInit() {
    lottieController = LottieController(duration: const Duration(seconds: 2))
      ..addListener(_lottieListen);
    super.onInit();
  }

  void _lottieListen() {
    if (lottieController.isDone) {
      Get.toNamed(AppRoutes.connection);
    }
  }
}
