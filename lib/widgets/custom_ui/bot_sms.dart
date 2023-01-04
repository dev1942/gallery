import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/text_styles.dart';

class BotSms extends StatefulWidget {
  const BotSms({Key? key}) : super(key: key);

  @override
  State<BotSms> createState() => _BotSmsState();
}

class _BotSmsState extends State<BotSms> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = const Duration(seconds: 2);
    return Timer(_duration, navigateToHomePage);
  }

  void navigateToHomePage() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.only(
                  top: 25, left: 25, right: 25, bottom: 70),
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.asset('assets/images/ic_sms.png').image,
                      fit: BoxFit.fill)),
              child: Text(
                "This Functionality is under development. It will be available you you soon",
                textAlign: TextAlign.center,
                style: regularText(15),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/ic_bot.png',
                height: 200,
              ),
            )
          ],
        ),
      ),
    );
  }
}
