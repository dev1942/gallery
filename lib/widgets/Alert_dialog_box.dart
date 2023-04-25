// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_style.dart';

class LogoutOverlay extends StatefulWidget {
  final void Function()? onSubmitTap;
  final void Function()? onCancelTap;
  final TextEditingController? textcontroller;
  final TextEditingController? noteController;

  const LogoutOverlay({Key? key, this.onSubmitTap, this.onCancelTap, this.textcontroller, this.noteController}) : super(key: key);
  @override
  State<StatefulWidget> createState() => LogoutOverlayState();
}

class LogoutOverlayState extends State<LogoutOverlay> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;
  //TextEditingController _textcontroller=TextEditingController();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
              margin: MediaQuery.of(context).viewInsets,
              padding: const EdgeInsets.all(15.0),
              height: 250.0,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  //   color: const Color.fromRGBO(41, 167, 77, 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
              child: Column(
                children: <Widget>[
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                    child: Text(
                      "Please Enter Your Offering Amount ?",
                      style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
                    child: TextField(
                      controller: widget.textcontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(label: Text("Enter Amount"), hintText: "AED"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
                    child: TextField(
                      controller: widget.noteController,
                      //keyboardType: TextInputType.number,
                      decoration: const InputDecoration(label: Text("Enter Note"), hintText: "note"),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: widget.onCancelTap,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.colorBlueEnd,
                                AppColors.colorBlueStart,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            child: Text('Close',
                                textAlign: TextAlign.center,
                                style:
                                    AppStyle.textViewStyleNormalButton(context: context, color: Colors.white, fontSizeDelta: 0, fontWeightDelta: 2)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: widget.onSubmitTap,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white, //
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.colorBlueEnd,
                                AppColors.colorBlueStart,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            child: Text('Submit',
                                textAlign: TextAlign.center,
                                style:
                                    AppStyle.textViewStyleNormalButton(context: context, color: Colors.white, fontSizeDelta: 0, fontWeightDelta: 2)),
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              )),
        ),
      ),
    );
  }
}
