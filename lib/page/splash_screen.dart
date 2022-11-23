import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/splash_screen_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/screen_utils.dart';
import 'package:otobucks/global/size_config.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/videos/introvideo.mp4');
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController(context: context));
    var size = MediaQuery.of(context).size;
    ScreenUtil.getInstance().init(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return
          OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return
              Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.colorWhite,
              body:SizedBox(
                height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
              children: <Widget>[
              VideoPlayer(_controller),
              ClosedCaption(text: _controller.value.caption.text),
           // _ControlsOverlay(controller: _controller),
             // VideoProgressIndicator(_controller, allowScrubbing: false),
              ],
              ),
              )

              // ConstrainedBox(
              //   constraints: const BoxConstraints.expand(),
              //   child: Container(
              //       height: size.height,
              //       width: size.width,
              //       decoration: const BoxDecoration(
              //           image: DecorationImage(
              //               image: AssetImage(AppImages.ic_login_bg),
              //               fit: BoxFit.cover)),
              //       child: Center(
              //         child: Image.asset(
              //           AppImages.icSplashScreenIcon,
              //           width: size.width / 1.5,
              //           fit: BoxFit.fill,
              //         ),
              //       )),
              // ),
            );
          },
     );
      },
    );
  }
}
