import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Home/Controllers/home_screen_controller.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Chat/Models/local_chat_model.dart';
import 'package:otobucks/View/Chat/Models/server_chat_model.dart';
import 'package:otobucks/services/repository/chat_repo.dart';
import 'package:otobucks/widgets/image_selection_bottom_sheet.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatDetailController extends GetxController {
  bool mShowData = false;
  bool isShowLoader = false;
  bool isShowEmojis = false;
  late io.Socket socket;
  List<LocalChatModel> alChat = [];
  int initialCount = 0;
  TextEditingController controllerMessage = TextEditingController();

  bool showSendButton = false;

  String imgProfilePic = '';

  initSocket(String roomId) {
    socket = io.io(
        'https://api.otobucks.com',
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .enableForceNewConnection() // disable auto-connection
            .build());
    socket.connect();
    socket.emitWithAck('join', {
      "user": {
        "_id": Get.find<HomeScreenController>().userId,
      },
      'roomId': roomId
    }, ack: (data) {
      log('ack: $data');
    });
    socket.onConnect((data) {
      log(socket.connected.toString());
      log('connected on coonection');
      socket.on('join', (data) {
        for (int i = 0; i < alChat.length; i++) {
          alChat[i].isRead = true;
        }
        update();
        log(data.toString());
      });
    });

    socket.on('message', (data) {
      if (data['message'] != null) {
        if (alChat.isNotEmpty) {
          alChat.insert(
              0,
              LocalChatModel(
                  time: Global.getTimeFormat(
                      DateTime.now().toString().split(' ')[1]),
                  id: '',
                  image: '',
                  name: '',
                  message: data['message'],
                  images: [],
                  isRead: false,
                  mMsgType: MsgType.left));
        } else {
          alChat.add(LocalChatModel(
              time:
                  Global.getTimeFormat(DateTime.now().toString().split(' ')[1]),
              id: '',
              image: '',
              name: '',
              message: data['message'],
              images: [],
              isRead: false,
              mMsgType: MsgType.left));
        }
        for (int i = 0; i < alChat.length; i++) {
          alChat[i].isRead = true;
        }
        update();
      }
    });
    socket.on('messageReadSuccessfully', (data) {
      for (int i = 0; i < alChat.length; i++) {
        alChat[i].isRead = true;
      }
      update();
      log('recice data: ' + data.toString());
    });
  }

  sendMessage(String roomId, {String url = ''}) {
    socket.emitWithAck("sendMessage", {
      {
        'message': controllerMessage.text.isEmpty
            ? 'image sent'
            : controllerMessage.text,
        'files': [url]
      },
      roomId
    }, ack: (data) {
      log('ack Message: $data');
    });
    log('image: ' + url);
    if (alChat.isNotEmpty) {
      alChat.insert(
          0,
          LocalChatModel(
              time:
                  Global.getTimeFormat(DateTime.now().toString().split(' ')[1]),
              id: '',
              image: '',
              name: '',
              message: controllerMessage.text.isEmpty
                  ? 'image sent'
                  : controllerMessage.text,
              images: url.isNotEmpty ? [url] : [],
              isRead: false,
              mMsgType: MsgType.right));
    } else {
      alChat.add(LocalChatModel(
          time: Global.getTimeFormat(DateTime.now().toString().split(' ')[1]),
          id: '',
          image: '',
          name: '',
          message: controllerMessage.text.isEmpty
              ? 'image sent'
              : controllerMessage.text,
          images: url.isNotEmpty ? [url] : [],
          isRead: false,
          mMsgType: MsgType.right));
    }
    controllerMessage.clear();
    showSendButton = false;
    update();
  }

  List<ServerChatModel> chats = [];

  getMessages(String roomId) async {
    initialCount = 0;
    chats.clear();
    alChat.clear();
    mShowData = true;
    // isShowLoader = true
    update();

    HashMap<String, Object> requestParams = HashMap();

    var alTransactions = await ChatRepo().getMyMessages(requestParams, roomId);

    alTransactions.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);

      mShowData = false;
      update();
    }, (mResult) async {
      chats = mResult.responseData as List<ServerChatModel>;
      chats = chats.reversed.toList();
      if (chats.isNotEmpty) {
        for (var chat in chats) {
          bool isMe = chat.to.id == Get.find<HomeScreenController>().userId
              ? true
              : false;
          List<String> files = [];
          for (var file in chat.files) {
            if (file.isNotEmpty && file.startsWith('http')) {
              files.add(file);
            }
          }
          LocalChatModel localChatModel = LocalChatModel(
              time: Global.getTimeFormat(
                  chat.getDateInFormate().toString().split(' ')[1]),
              id: chat.id,
              image: isMe ? chat.to.image : chat.from.image,
              name: isMe ? chat.from.firstName : chat.to.firstName,
              message: chat.message,
              images: files,
              isRead: chat.status == 'read' ? true : false,
              mMsgType: isMe ? MsgType.left : MsgType.right);
          alChat.add(localChatModel);
        }
        initialCount = alChat.length;
        mShowData = false;
        update();
        await ChatRepo().readRoomMessages(requestParams, roomId);
      } else {
        mShowData = false;
        update();
      }
      update();
    });
  }

  uploadImage(String roomId) async {
    HashMap<String, String> requestParams = HashMap();
    HashMap<String, String> requestParamsImage = HashMap();

    if (Global.checkNull(imgProfilePic)) {
      if (Global.isURL(imgProfilePic)) {
        requestParams[PARAMS.PARAM_IMAGE] = imgProfilePic;
      } else {
        requestParamsImage[PARAMS.PARAM_IMAGE] = imgProfilePic;
      }
    }

    var categories =
        await ChatRepo().uploadFile(requestParams, requestParamsImage);
    isShowLoader = false;
    update();
    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
    }, (mResult) async {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);

      List<String> urls = mResult.responseData as List<String>;
      log(urls[0]);
      sendMessage(roomId, url: urls[0]);
    });
  }

  selectProfilePic(BuildContext context, String roomId) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ImageSelection(
            isCropImage: true,
            mImagePath: (String strPath) {
              imgProfilePic = strPath;
              update();
              uploadImage(roomId);
            },
            mMaxHeight: 1024,
            mMaxWidth: 1024,
            mRatioX: 1.0,
            mRatioY: 1.0,
          );
        });
  }

  changeText(String strvalue) {
    if (Global.checkNull(strvalue)) {
      showSendButton = true;
    } else {
      showSendButton = false;
    }
    update();
  }

  addEmojis(String strvalue) {
    controllerMessage.text = controllerMessage.text + strvalue;
    showSendButton = true;
    update();
  }

  showEmoji() {
    isShowEmojis = isShowEmojis ? false : true;
    update();
  }

  disableEmoji() {
    isShowEmojis = false;

    update();
  }

  List<String> emojis = [
    '😀',
    '😃',
    '😄',
    '😁',
    '😅',
    '😂',
    '🤣',
    '🥲',
    '😊',
    '😇',
    '🙂',
    '🙃',
    '😉',
    '😌',
    '😍',
    '🥰',
    '😘',
    '😗',
    '😙',
    '😚'
  ];
}
