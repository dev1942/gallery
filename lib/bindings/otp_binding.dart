import 'package:get/get.dart';
import 'package:otobucks/controllers/auth_controllers/otp_controller.dart';

class OtpBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      () => OtpController(),
    );
  }
}
