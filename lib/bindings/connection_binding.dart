import 'package:get/get.dart';
import '/controllers/controllers.dart';

class ConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectionScreenController());
  }
}
