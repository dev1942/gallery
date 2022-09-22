import 'package:get/get.dart';
import 'package:otobucks/controllers/home_screen_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController(),
        fenix: true);
  }
}
