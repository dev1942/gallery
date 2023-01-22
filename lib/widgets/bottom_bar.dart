// import 'package:flutter/material.dart';
// import 'package:otobucks/global/app_colors.dart';
// import 'package:otobucks/global/app_dimens.dart';

// import '../global/app_images.dart';

// class BottomBar extends StatelessWidget {
//   final int indexM;
//   final Function onTap;

//   const BottomBar({Key? key, required this.indexM, required this.onTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: AppDimens.bottom_bar_height,
//         child: Material(
//             color: AppColors.colorBlueStart,
//             child: BottomNavigationBar(
//               selectedFontSize: 0,
//               iconSize: 22,
//               unselectedFontSize: 0,
//               showSelectedLabels: false,
//               backgroundColor: AppColors.colorBlueStart,
//               showUnselectedLabels: false,
//               currentIndex: indexM,
//               selectedItemColor: AppColors.colorWhite,
//               unselectedItemColor: AppColors.colorWhite.withOpacity(0.6),
//               type: BottomNavigationBarType.fixed,
//               onTap: (int index) {
//                 onTap(index);
//               },
//               items: BottomNavBarHelper.bottomBarItems(context),
//             )));
//   }
// }

// class BottomNavBarHelper {
//   static bottomBarItems(BuildContext context) {
//     bottomNavIcon(String image) {
//       return Container(
//         // width: 38,
//         // height: 78,
//         padding: EdgeInsets.only(top: 1),
//         child: ImageIcon(
//           AssetImage(image),
//           // size: 22,
//         ),
//       );
//     }

//     return [
//       BottomNavigationBarItem(
//           icon: bottomNavIcon(AppImages.ic_home_white),
//           label: "",
//           activeIcon: Container(
//             alignment: Alignment.center,
//             child: bottomNavIcon(AppImages.ic_home_white),
//           )),
//       // BottomNavigationBarItem(
//       //     icon: bottomNavIcon(AppImages.ic_message),
//       //     label: "",
//       //     activeIcon: Container(
//       //       alignment: Alignment.center,
//       //       height: AppDimens.dimens_20,
//       //       child: bottomNavIcon(AppImages.ic_message),
//       //     )),
//       BottomNavigationBarItem(
//           icon: bottomNavIcon(AppImages.ic_cart),
//           label: "",
//           activeIcon: Container(
//             alignment: Alignment.center,
//             height: AppDimens.dimens_20,
//             child: bottomNavIcon(AppImages.ic_cart),
//           )),
//       BottomNavigationBarItem(
//           icon: Stack(children: <Widget>[
//             bottomNavIcon(AppImages.ic_notification),
//             const Positioned(
//               // draw a red marble
//               top: 0.0,
//               right: 0.0,
//               child: Icon(Icons.brightness_1, size: 10.0, color: Colors.redAccent),
//             )
//           ]),
//           label: "",
//           activeIcon: Container(
//             alignment: Alignment.center,
//             height: AppDimens.dimens_20,
//             child: bottomNavIcon(AppImages.ic_notification),
//           )),
//       BottomNavigationBarItem(
//           icon: bottomNavIcon(AppImages.ic_user_filled),
//           label: "",
//           activeIcon: Container(
//             alignment: Alignment.center,
//             height: AppDimens.dimens_20,
//             child: bottomNavIcon(AppImages.ic_user_filled),
//           )),
//     ];
//   }
// }
import 'dart:ui';

import 'package:flutter/material.dart';

class BottomBarDefault extends StatefulWidget {
  final List<TabItem> items;

  /// view
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final double? blur;

  /// item
  final int indexSelected;
  final Function(int index)? onTap;

  final Color color;
  final Color colorSelected;
  final double iconSize;
  final TextStyle? titleStyle;
  final double? paddingVertical;
  final CountStyle? countStyle;
  final Duration? duration;
  final Curve? curve;
  final double? top;
  final double? bottom;
  final double? pad;
  final bool? enableShadow;
  final bool animated;
  const BottomBarDefault({
    Key? key,
    required this.items,
    required this.backgroundColor,
    this.boxShadow,
    this.blur,
    this.borderRadius,
    this.indexSelected = 0,
    this.onTap,
    required this.color,
    required this.colorSelected,
    this.iconSize = 22,
    this.titleStyle,
    this.paddingVertical,
    this.countStyle,
    this.animated = true,
    this.duration,
    this.curve,
    this.top = 12,
    this.bottom = 12,
    this.pad = 4,
    this.enableShadow = true,
  }) : super(key: key);

  @override
  _BottomBarDefaultState createState() => _BottomBarDefaultState();
}

class _BottomBarDefaultState extends State<BottomBarDefault> with TickerProviderStateMixin {
  late List<AnimationController> _animationControllerList;
  late List<Animation<double>> _animationList;

  int? _lastSelectedIndex;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _lastSelectedIndex = 0;
    _selectedIndex = widget.indexSelected;
    _animationControllerList = List<AnimationController>.empty(growable: true);
    _animationList = List<Animation<double>>.empty(growable: true);

    for (int i = 0; i < widget.items.length; ++i) {
      _animationControllerList.add(AnimationController(duration: widget.duration ?? const Duration(milliseconds: 400), vsync: this));
      _animationList.add(Tween(begin: 1.0, end: 1.18).chain(CurveTween(curve: widget.curve ?? Curves.ease)).animate(_animationControllerList[i]));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationControllerList[_selectedIndex!].forward();
    });
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.items.length; ++i) {
      _animationControllerList[i].dispose();
    }
    super.dispose();
  }

  Widget buildItem(BuildContext context, {required TabItem item, required int index, bool isSelected = false}) {
    double bottom = MediaQuery.of(context).viewPadding.bottom;
    EdgeInsets padDefault = EdgeInsets.only(
      top: widget.top!,
      bottom: widget.bottom! > 2 ? widget.bottom! + bottom : bottom,
    );
    isShadow = widget.enableShadow!;
    Color itemColor = isSelected ? widget.colorSelected : widget.color;
    if (widget.animated) {
      return AnimatedBuilder(
        animation: _animationList[index],
        builder: (context, child) {
          return Transform.scale(
            scale: _animationList[index].value,
            child: buildContentItem(item, itemColor, padDefault),
          );
        },
      );
    }
    return buildContentItem(item, itemColor, padDefault);
  }

  Widget buildContentItem(
    TabItem item,
    Color itemColor,
    EdgeInsets padDefault,
  ) {
    return Container(
      width: double.infinity,
      padding: widget.paddingVertical != null ? EdgeInsets.symmetric(vertical: widget.paddingVertical ?? 17.0) : padDefault,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          BuildIcon(
            item: item,
            iconColor: itemColor,
            iconSize: widget.iconSize,
            countStyle: widget.countStyle,
          ),
          if (item.title is String && item.title != '') ...[
            SizedBox(height: widget.pad),
            Text(
              item.title!,
              style: Theme.of(context).textTheme.overline?.merge(widget.titleStyle).copyWith(color: itemColor),
              textAlign: TextAlign.center,
            )
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.length != _animationControllerList.length) {
      _animationControllerList = List<AnimationController>.empty(growable: true);
      _animationList = List<Animation<double>>.empty(growable: true);

      for (int i = 0; i < widget.items.length; ++i) {
        _animationControllerList.add(AnimationController(duration: widget.duration ?? const Duration(milliseconds: 400), vsync: this));
        _animationList.add(Tween(begin: 1.0, end: 1.18).chain(CurveTween(curve: widget.curve ?? Curves.ease)).animate(_animationControllerList[i]));
      }
    }

    if (widget.indexSelected != _selectedIndex) {
      setState(() {
        _lastSelectedIndex = _selectedIndex;
        _selectedIndex = widget.indexSelected;
      });
      if (widget.animated) {
        _animationControllerList[_selectedIndex!].forward();
        _animationControllerList[_lastSelectedIndex!].reverse();
      }
    }
    isShadow = widget.enableShadow!;
    return BuildLayout(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow ?? shadow,
      ),
      blur: widget.blur,
      child: widget.items.isNotEmpty
          ? IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(widget.items.length, (index) {
                  return Expanded(
                    child: InkWell(
                      onTap: index != _selectedIndex!
                          ? () {
                              if (index != _selectedIndex) {
                                widget.onTap!.call(index);
                                if (widget.onTap == null) {
                                  setState(() {
                                    _lastSelectedIndex = _selectedIndex;
                                    _selectedIndex = index;
                                  });
                                  if (widget.animated) {
                                    _animationControllerList[_selectedIndex!].forward();
                                    _animationControllerList[_lastSelectedIndex!].reverse();
                                  }
                                }
                              }
                            }
                          : null,
                      child: buildItem(
                        context,
                        item: widget.items[index],
                        index: index,
                        isSelected: index == _selectedIndex!,
                      ),
                    ),
                  );
                }),
              ),
            )
          : null,
    );
  }
}

bool isShadow = true;
List<BoxShadow> shadow = [
  if (isShadow)
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.06),
      spreadRadius: 0,
      blurRadius: 20,
      offset: Offset(0, 6), // changes position of shadow
    )
  else
    const BoxShadow(color: Colors.transparent)
];

abstract class BottomBar extends StatefulWidget {
  final List<TabItem> itemData;

  /// view
  final Color background;
  final List<BoxShadow>? shadow;
  final double? doubleBlur;

  /// item
  final int indexActive;
  final Function(int index)? onChange;

  /// style
  final Color colorItem;
  final Color activeColor;
  final double sizeIcon;
  final TextStyle? styleTitle;
  final double? paddingVer;

  final CountStyle? styleCount;
  // final Color? countStyle;
  // final Color? backgroundCount;

  const BottomBar({
    Key? key,
    required this.itemData,
    required this.background,
    this.shadow,
    this.indexActive = 0,
    this.onChange,
    required this.colorItem,
    required this.activeColor,
    this.sizeIcon = 22,
    this.styleTitle,
    this.paddingVer,
    this.doubleBlur,
    this.styleCount,
  })  : assert(indexActive == 0 || indexActive < itemData.length),
        super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();

  Widget buildItem(
    BuildContext context, {
    required TabItem item,
    bool isSelected,
    required Color color,
    required Color activeColor,
    double sizeIcon,
    TextStyle? styleTitle,
    double? paddingVer,
    CountStyle? countStyle,
  });

  @protected
  Widget buildLayout(
    BuildContext context, {
    required List<TabItem> itemData,
    required Color background,
    List<BoxShadow>? shadowLayout,
    double? blur,
    int indexActive,
    Function(int index)? onChange,
    required Widget Function(
      TabItem item,
      bool isSelected,
    )
        buildView,
  });
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return widget.buildLayout(
      context,
      itemData: widget.itemData,
      background: widget.background,
      shadowLayout: widget.shadow,
      blur: widget.doubleBlur,
      indexActive: widget.indexActive,
      onChange: widget.onChange,
      buildView: (TabItem item, bool isSelected) => widget.buildItem(
        context,
        item: item,
        isSelected: isSelected,
        color: widget.colorItem,
        activeColor: widget.activeColor,
        sizeIcon: widget.sizeIcon,
        styleTitle: widget.styleTitle,
        paddingVer: widget.paddingVer,
        countStyle: widget.styleCount,
      ),
    );
  }
}

class BuildLayout extends StatelessWidget {
  final Widget? child;
  final BoxDecoration? decoration;
  final double? blur;
  final Clip? clipBehavior;

  const BuildLayout({
    Key? key,
    this.child,
    this.decoration,
    this.blur,
    this.clipBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (blur != null) {
      return Container(
        decoration: decoration,
        clipBehavior: clipBehavior ?? Clip.antiAlias,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur ?? 4, sigmaY: blur ?? 4),
            child: Container(
              decoration: decoration?.copyWith(color: Colors.transparent),
              child: child,
            ),
          ),
        ),
      );
    }
    return Container(
      decoration: decoration,
      clipBehavior: clipBehavior ?? Clip.antiAliasWithSaveLayer,
      child: child,
    );
  }
}

class TabItem<T> {
  final T icon;
  final String? title;
  final Widget? count;
  final String? key;

  const TabItem({
    required this.icon,
    this.title,
    this.count,
    this.key,
  }) : assert(icon is IconData || icon is Widget, 'TabItem only support IconData and Widget');
}

class CountStyle {
  final double? size;
  final Color? background;
  final Color? color;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? paddingContent;

  const CountStyle({
    this.size,
    this.background,
    this.color,
    this.textStyle,
    this.paddingContent,
  });
}

class BuildIcon extends StatelessWidget {
  final TabItem item;
  final double iconSize;
  final Color iconColor;
  final CountStyle? countStyle;

  const BuildIcon({
    Key? key,
    required this.item,
    required this.iconColor,
    this.iconSize = 22,
    this.countStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget icon = Icon(
      item.icon,
      size: iconSize,
      color: iconColor,
    );
    if (item.count is Widget) {
      double sizeBadge = countStyle?.size ?? 18;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            item.icon,
            size: iconSize,
            color: iconColor,
          ),
          PositionedDirectional(
            start: iconSize - sizeBadge / 2,
            top: -sizeBadge / 2,
            child: item.count!,
          ),
        ],
      );
    }
    return icon;
  }
}
