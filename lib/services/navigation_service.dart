import 'package:flutter/cupertino.dart';
import 'package:stacked_services/stacked_services.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  navigateTo({required Widget to}) {
    StackedService.navigatorKey!.currentState!
        .push(CupertinoPageRoute(builder: (context) => to));
  }

  back() {
    StackedService.navigatorKey!.currentState!.pop();
  }

  back1(BuildContext context) {
    //StackedService.navigatorKey!.currentState!.pop();
    Navigator.pop(context);
  }

  // navigateToSearchScreen({required Widget to}){
  //   StackedService.navigatorKey!.currentState!.pushAndRemoveUntil(CupertinoPageRoute(builder: (context)=> to), (route) => false);
  // }

  navigateToUntil({required Widget to}) {
    StackedService.navigatorKey!.currentState!.pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => to), (route) => true);
  }

  navigateToReplacement({required Widget to}) {
    StackedService.navigatorKey!.currentState!
        .pushReplacement(CupertinoPageRoute(builder: (context) => to));
  }

  navigateToSearchScreen({required Widget to}) {
    StackedService.navigatorKey!.currentState!
        .pushReplacement(CupertinoPageRoute(builder: (context) => to));
  }

  navigateToSerachScreen({required Widget to}) {
    StackedService.navigatorKey!.currentState!
        .pushReplacement(CupertinoPageRoute(builder: (context) => to));
  }

  navigateToSearchServicesScreen({required Widget to}) {
    StackedService.navigatorKey!.currentState!
        .pushReplacement(CupertinoPageRoute(builder: (context) => to));
  }
}
