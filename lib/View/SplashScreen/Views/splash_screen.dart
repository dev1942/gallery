// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:otobucks/View/SplashScreen/Controllers/splash_screen_controller.dart';
// import 'package:otobucks/global/app_colors.dart';
// import 'package:otobucks/global/screen_utils.dart';
// import 'package:otobucks/global/size_config.dart';
// import 'package:video_player/video_player.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   late VideoPlayerController _controller;
//   @override
//   void initState() {
//     _controller = VideoPlayerController.asset('assets/videos/splashvid.mp4');
//     _controller.addListener(() {
//      // setState(() {});
//     });
//     _controller.setLooping(true);
//     _controller.initialize().then((_) => setState(() {}));
//     _controller.play();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Get.put(SplashScreenController(context: context));
//     // var size = MediaQuery.of(context).size;
//     ScreenUtil.getInstance().init(context);

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return OrientationBuilder(
//           builder: (context, orientation) {
//             SizeConfig().init(constraints, orientation);
//             return Scaffold(
//               resizeToAvoidBottomInset: false,
//               backgroundColor: AppColors.colorBlueEnd,
//               body:
//               // body: Stack(
//               //   children: <Widget>[
//               //     // Container(
//               //     //   height: MediaQuery.of(context).size.height,
//               //     //   width: MediaQuery.of(context).size.width,
//               //     //   decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/splash.jpg"), fit: BoxFit.fitHeight)),
//               //     // ),
//               //     // Positioned(
//               //     //   bottom: MediaQuery.of(context).size.height * 0.1,
//               //     //   left: MediaQuery.of(context).size.width * 0.45,
//               //     //   child: const CircularProgressIndicator(
//               //     //     color: Colors.white,
//               //     //   ),
//               //     // )
//               //     // _ControlsOverlay(controller: _controller),
//               //     // VideoProgressIndicator(_controller, allowScrubbing: false),
//               //   ],
//               // ),

//               // if you want to replace image with video use this

//               SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: Stack(
//                   children: <Widget>[
//                     VideoPlayer(_controller),
//                     ClosedCaption(text: _controller.value.caption.text),
//                     // _ControlsOverlay(controller: _controller),
//                     // VideoProgressIndicator(_controller, allowScrubbing: false),
//                   ],
//                 ),
//               ),

//               // ConstrainedBox(
//               //   constraints: const BoxConstraints.expand(),
//               //   child: Container(
//               //       height: size.height,
//               //       width: size.width,
//               //       decoration: const BoxDecoration(
//               //           image: DecorationImage(
//               //               image: AssetImage(AppImages.ic_login_bg),
//               //               fit: BoxFit.cover)),
//               //       child: Center(
//               //         child: Image.asset(
//               //           AppImages.icSplashScreenIcon,
//               //           width: size.width / 1.5,
//               //           fit: BoxFit.fill,
//               //         ),
//               //       )),
//               // ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';

import '../../../global/screen_utils.dart';
import '../Controllers/splash_screen_controller.dart';

class AppSplashScreen extends StatefulWidget {
  static String tag = '/ProkitSplashScreen';

  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  bool _a = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;
  bool secondAnim = false;

  Color boxColor = Colors.transparent;

  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    Timer(const Duration(milliseconds: 600), () {
      setState(() {
        boxColor = AppColors.colorWhite;
        _a = true;
      });
    });
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        boxColor = AppColors.colorPrimary;
        _c = true;
      });
    });
    Timer(const Duration(milliseconds: 1700), () {
      setState(() {
        _e = true;
      });
    });
    Timer(const Duration(milliseconds: 3200), () {
      secondAnim = true;

      scaleController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      )..forward();
      scaleAnimation = Tween<double>(begin: 0.0, end: 12).animate(scaleController);

      setState(() {
        // boxColor = Colors.black;
        _d = true;
      });
    });
    // Timer(const Duration(milliseconds: 4200), () {
    //   secondAnim = true;
    //   setState(() {});

    //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()), (Route<dynamic> route) => false);
    // });

    // afterBuildCreated(() async {
    //   setValue(appOpenCount, (getIntAsync(appOpenCount)) + 1);
    //   await appStore.setLanguage(getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: defaultLanguage), context: context);
    // });
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    Get.put(SplashScreenController(context: context));
//     // var size = MediaQuery.of(context).size;
    ScreenUtil.getInstance().init(context);

    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _d ? 900 : 2500),
              curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _d
                  ? 0
                  : _a
                      ? _h / 2.5
                      : 20,
              width: 20,
            ),
            AnimatedContainer(
              duration: Duration(seconds: _c ? 2 : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? _h
                  : _c
                      ? 130
                      : 20,
              width: _d
                  ? _w
                  : _c
                      ? 130
                      : 20,
              decoration: BoxDecoration(
                  color: boxColor,
                  //shape: _c? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: _d ? const BorderRadius.only() : BorderRadius.circular(30)),
              child: secondAnim
                  ? Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(color: Color.fromRGBO(233, 235, 240, 0.584), shape: BoxShape.circle),
                        //  color: themeMode.obs.value == ThemeMode.dark ? Get.theme.cardColor : Get.theme.splashColor, shape: BoxShape.circle),
                        child: AnimatedBuilder(
                          animation: scaleAnimation,
                          builder: (c, child) => Transform.scale(
                            scale: scaleAnimation.value,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: _e
                          ? Image.asset(
                              'assets/images/autofix.png',
                              height: 130,
                              width: 130,
                              fit: BoxFit.contain,
                              color: Colors.white,
                            )
                          : const SizedBox(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
