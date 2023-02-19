import 'package:get/get.dart';

import '../../View/Auth/controllers/otp_controller.dart';

class OtpBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      () => OtpController(),
    );
  }
}
