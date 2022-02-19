import 'package:get/get.dart';
import '/controllers/controllers.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController());
  }
}
