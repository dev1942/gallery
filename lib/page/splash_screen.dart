import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/splash_screen_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/screen_utils.dart';
import 'package:otobucks/global/size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController(context: context));
    var size = MediaQuery.of(context).size;
    ScreenUtil.getInstance().init(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.colorWhite,
              body: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppImages.ic_login_bg),
                            fit: BoxFit.cover)),
                    child: Center(
                      child: Image.asset(
                        AppImages.icSplashScreenIcon,
                        width: size.width / 1.5,
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
            );
          },
        );
      },
    );
  }
}
