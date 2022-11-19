
import 'package:get/get.dart';

import '../page/home_page.dart';

class Navigation{


void navigateToHomePage() {
  Get.offAll(() => const HomePage());
}
}
