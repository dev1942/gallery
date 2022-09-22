// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/video_view.dart';

import '../model/media_model.dart';

class MediaSlider extends StatefulWidget {
  final List<MediaModel> alMediaModel;

  const MediaSlider({Key? key, required this.alMediaModel}) : super(key: key);

  @override
  MediaSliderState createState() => MediaSliderState();
}

class MediaSliderState extends State<MediaSlider> {
  MediaModel mSelectedMediaModel = MediaModel(url: 'empty', isImage: false);

  @override
  void initState() {
    super.initState();
    if (widget.alMediaModel.isNotEmpty) {
      for (var media in widget.alMediaModel) {
        if (!media.isImage) {
          mSelectedMediaModel = media;
          break;
        }
      }
      if (mSelectedMediaModel.url == 'empty') {
        mSelectedMediaModel = widget.alMediaModel[0];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double imageSizeSub = AppDimens.dimens_60;
    double imageSizeMain = AppDimens.dimens_170;
    double width = MediaQuery.of(context).size.width;

    Widget mMainView = Container();
    if (mSelectedMediaModel.isImage) {
      mMainView = ClipRRect(
          borderRadius: BorderRadius.circular(AppDimens.dimens_5),
          child: NetworkImageCustom(
              height: imageSizeMain,
              width: width,
              fit: BoxFit.fitWidth,
              image: mSelectedMediaModel.url));
    } else {
      mMainView = VideoView(
        strVideoURL: mSelectedMediaModel.url,
        isMainView: true,
      );
    }
    return Column(
      children: [
        Container(
          child: mMainView,
          height: imageSizeMain,
          width: width,
        ),
        Container(
            height: imageSizeSub,
            margin: const EdgeInsets.only(top: AppDimens.dimens_15),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(0),
                itemBuilder: (BuildContext contextM, index) {
                  MediaModel mServiceModel = widget.alMediaModel[index];
                  Widget mChild = Container(
                    color: AppColors.colorBlack.withOpacity(0.1),
                    height: imageSizeSub,
                    width: imageSizeSub,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoView(
                          strVideoURL: mServiceModel.url,
                          isMainView: false,
                        ),
                        Icon(
                          Icons.play_circle_fill,
                          size: AppDimens.dimens_30,
                          color: AppColors.colorBlack.withOpacity(0.6),
                        ),
                      ],
                    ),
                  );
                  if (mServiceModel.isImage) {
                    mChild = NetworkImageCustom(
                        height: imageSizeSub,
                        width: imageSizeSub,
                        fit: BoxFit.cover,
                        image: mServiceModel.url);
                  }

                  return Container(
                    margin: const EdgeInsets.only(
                      right: AppDimens.dimens_10,
                    ),
                    child: InkWell(
                      child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppDimens.dimens_5),
                          child: mChild),
                      onTap: () {
                        setState(() {
                          mSelectedMediaModel = mServiceModel;
                        });
                      },
                    ),
                  );
                },
                itemCount: widget.alMediaModel.length))
      ],
    );
  }
}
