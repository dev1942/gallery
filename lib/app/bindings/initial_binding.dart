import 'package:get/get.dart';
import 'package:otobucks/View/Home/Controllers/home_screen_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController(),
        fenix: true);
  }
}
