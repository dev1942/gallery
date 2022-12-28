
import 'package:get/get.dart';

import '../View/Home/Views/home_page.dart';

class Navigation{


void navigateToHomePage() {
  Get.offAll(() => const HomePage());
}
}
