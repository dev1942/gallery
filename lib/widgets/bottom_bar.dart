import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';

import '../global/app_images.dart';

class BottomBar extends StatelessWidget {
  final int indexM;
  final Function onTap;

  const BottomBar({Key? key, required this.indexM, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: AppDimens.bottom_bar_height,
        child: Material(
            color: AppColors.colorBlueStart,
            child: BottomNavigationBar(
              selectedFontSize: 0,
              unselectedFontSize: 0,
              showSelectedLabels: false,
              backgroundColor: AppColors.colorBlueStart,
              showUnselectedLabels: false,
              currentIndex: indexM,
              selectedItemColor: AppColors.colorWhite,
              unselectedItemColor: AppColors.colorWhite.withOpacity(0.6),
              type: BottomNavigationBarType.fixed,
              onTap: (int index) {
                onTap(index);
              },
              items: BottomNavBarHelper.bottomBarItems(context),
            )));
  }
}

class BottomNavBarHelper {
  static bottomBarItems(BuildContext context) {
    bottomNavIcon(String image) {
      return ImageIcon(
        AssetImage(image),
      );
    }

    return [
      BottomNavigationBarItem(
          icon: bottomNavIcon(AppImages.ic_home_white),
          label: "",
          activeIcon: Container(
            alignment: Alignment.center,
            child: bottomNavIcon(AppImages.ic_home_white),
          )),
      BottomNavigationBarItem(
          icon: bottomNavIcon(AppImages.ic_message),
          label: "",
          activeIcon: Container(
            alignment: Alignment.center,
            height: AppDimens.dimens_20,
            child: bottomNavIcon(AppImages.ic_message),
          )),
      BottomNavigationBarItem(
          icon: bottomNavIcon(AppImages.ic_cart),
          label: "",
          activeIcon: Container(
            alignment: Alignment.center,
            height: AppDimens.dimens_20,
            child: bottomNavIcon(AppImages.ic_cart),
          )),
      BottomNavigationBarItem(
          icon: Stack(children: <Widget>[
            bottomNavIcon(AppImages.ic_notification),
            const Positioned(
              // draw a red marble
              top: 0.0,
              right: 0.0,
              child:
                  Icon(Icons.brightness_1, size: 10.0, color: Colors.redAccent),
            )
          ]),
          label: "",
          activeIcon: Container(
            alignment: Alignment.center,
            height: AppDimens.dimens_20,
            child: bottomNavIcon(AppImages.ic_notification),
          )),
      BottomNavigationBarItem(
          icon: bottomNavIcon(AppImages.ic_user_filled),
          label: "",
          activeIcon: Container(
            alignment: Alignment.center,
            height: AppDimens.dimens_20,
            child: bottomNavIcon(AppImages.ic_user_filled),
          )),
    ];
  }
}
