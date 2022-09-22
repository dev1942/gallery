import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../global/app_colors.dart';
import '../global/app_dimens.dart';

// ignore: must_be_immutable
class VideoView extends StatefulWidget {
  String strVideoURL = "";
  bool isMainView;

  VideoView({Key? key, required this.strVideoURL, required this.isMainView})
      : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    log(widget.strVideoURL);
    _controller = VideoPlayerController.network(widget.strVideoURL,
        httpHeaders: {'Content-Disposition': 'inline'})
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isMainView) {
      _controller.play();
    }
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        InkWell(
          child: Center(
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                    child: Container(
                      alignment: Alignment.center,
                      height: AppDimens.dimens_170,
                      width: width,
                      color: AppColors.colorBlack.withOpacity(0.1),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
          ),
          onTap: () {
            if (widget.isMainView) {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            }
          },
        ),
        // widget.isMainView
        //     ? !_controller.value.isPlaying
        //         ? Center(
        //             child: FloatingActionButton(
        //               onPressed: () {
        //                 setState(() {
        //                   _controller.value.isPlaying
        //                       ? _controller.pause()
        //                       : _controller.play();
        //                 });
        //               },
        //               child: Icon(
        //                 _controller.value.isPlaying
        //                     ? Icons.pause
        //                     : Icons.play_arrow,
        //                 color: AppColors.colorWhite,
        //               ),
        //             ),
        //           )
        //         : Container()
        //     : Container()
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
