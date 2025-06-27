import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'controllers/user_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(UserController(),permanent: true);
  }
}
