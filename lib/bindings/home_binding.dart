import 'package:get/get.dart';
import '/controllers/controllers.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
  }
}
