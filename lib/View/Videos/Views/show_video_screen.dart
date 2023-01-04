import 'package:flutter/material.dart';
import 'package:otobucks/widgets/video_view.dart';

import '../../../../../global/app_colors.dart';
import '../../../../../global/app_views.dart';

class ShowVideoScreen extends StatefulWidget {
  final String strVideoURL;

  const ShowVideoScreen({Key? key, required this.strVideoURL})
      : super(key: key);

  @override
  ShowVideoScreenState createState() => ShowVideoScreenState();
}

class ShowVideoScreenState extends State<ShowVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: "Video View",
        isShowNotification: false,
        isShowSOS: false,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.getMainBgColor(),
      body: Stack(
        children: [
          VideoView(
            strVideoURL: widget.strVideoURL,
            isMainView: true,
          )
        ],
      ),
    );
  }
}
