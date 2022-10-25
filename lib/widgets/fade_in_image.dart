import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:otobucks/global/app_dimens.dart';

import '../global/app_views.dart';

class NetworkImageCustom extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit? fit;

  const NetworkImageCustom(
      {Key? key,
      required this.height,
      required this.width,
      required this.image,
      this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.dimens_5,),
      child: CachedNetworkImage(
          // placeholder: ((context, url) => Image.asset(AppImages.ic_place_holder)),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              AppViews.getProgressImage(height, width),
          height: height,
          width: width,
          imageUrl: image == ''
              ? 'https://d23jwszswncmo3.cloudfront.net/otobuckslogo.jpg'
              : image,
          errorWidget: ((context, url, error) =>
              AppViews.getErrorImage(height, width)),
           fit: fit != null ? fit! : BoxFit.cover
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:otobucks/global/app_colors.dart';
// import 'package:otobucks/global/app_dimens.dart';
// import 'package:otobucks/global/app_style.dart';

// import '../global/app_images.dart';
// import '../global/app_views.dart';
// import '../global/global.dart';

// class FadeInImageCustom extends StatelessWidget {
//   String image;
//   double height;
//   double width;
//   BoxFit? fit;

//   FadeInImageCustom(
//       {required this.height,
//       required this.width,
//       required this.image,
//       this.fit});

//   @override
//   Widget build(BuildContext context) {
//     if (height != 0 && width != 0) {
//       return FadeInImage.assetNetwork(
//           placeholder: AppImages.ic_place_holder,
//           height: height,
//           width: width,
//           image: image,
//           imageErrorBuilder: (BuildContext? context, Object? exception,
//               StackTrace? stackTrace) {
//             return AppViews.getErrorImage(height, width);
//           },
//           fit: fit != null ? fit! : BoxFit.contain);
//     } else if (height != 0) {
//       return FadeInImage.assetNetwork(
//           placeholder: AppImages.ic_place_holder,
//           height: height,
//           image: image,
//           imageErrorBuilder: (BuildContext? context, Object? exception,
//               StackTrace? stackTrace) {
//             return AppViews.getErrorImage(height, AppDimens.dimens_200);
//           },
//           fit: fit != null ? fit! : BoxFit.contain);
//     } else if (width != 0) {
//       return FadeInImage.assetNetwork(
//           placeholder: AppImages.ic_place_holder,
//           width: width,
//           image: image,
//           imageErrorBuilder: (BuildContext? context, Object? exception,
//               StackTrace? stackTrace) {
//             return AppViews.getErrorImage(AppDimens.dimens_200, width);
//           },
//           fit: fit != null ? fit! : BoxFit.contain);
//     } else {
//       return FadeInImage.assetNetwork(
//           placeholder: AppImages.ic_place_holder,
//           image: image,
//           imageErrorBuilder: (BuildContext? context, Object? exception,
//               StackTrace? stackTrace) {
//             return AppViews.getErrorImage(
//                 AppDimens.dimens_90, AppDimens.dimens_90);
//           },
//           fit: fit != null ? fit! : BoxFit.contain);
//     }
//   }
// }
