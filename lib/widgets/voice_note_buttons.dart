import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data' show Uint8List;

import 'package:audio_session/audio_session.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../global/app_dimens.dart';
import '../global/app_images.dart';
import '../global/global.dart';
import 'media_button.dart';

const int tSAMPLERATE = 8000;
const int tSTREAMSAMPLERATE = 44000;

enum Media {
  file,
  remoteExampleFile,
}

enum AudioState {
  isPlaying,
  isPaused,
  isStopped,
  isRecording,
  isRecordingPaused,
}

class VoiceRecordingButton extends StatefulWidget {
  final Function callback;
  final String strVoiceNotePath;

  const VoiceRecordingButton(
      {Key? key, required this.callback, required this.strVoiceNotePath})
      : super(key: key);

  @override
  VoiceRecordingState createState() => VoiceRecordingState();
}

class VoiceRecordingState extends State<VoiceRecordingButton> {
  bool _isRecording = false;
  bool isShowRecordButton = true;
  bool isShowPlayView = false;
  bool isHideRemoveButton = true;
  String _path = "";

  String remoteSample = "";

  StreamSubscription? _recorderSubscription;
  StreamSubscription? _playerSubscription;
  StreamSubscription? _recordingDataSubscription;

  FlutterSoundPlayer playerModule = FlutterSoundPlayer();
  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();

  String _recorderTxt = '00:00';
  String _playerTxt = '00:00';
  double? _dbLevel;

  double sliderCurrentPosition = 0.0;
  double maxDuration = 1.0;
  Media _media = Media.file;
  Codec _codec = Codec.aacMP4;

  bool? _encoderSupported = true; // Optimist
  bool _decoderSupported = true; // Optimist

  StreamController<Food>? recordingDataController;
  IOSink? sink;

  Future<void> _initializeExample() async {
    await playerModule.closeAudioSession();
    await playerModule.openAudioSession();
    await playerModule
        .setSubscriptionDuration(const Duration(milliseconds: 10));
    await recorderModule
        .setSubscriptionDuration(const Duration(milliseconds: 10));
    await initializeDateFormatting();
    await setCodec(_codec);
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await recorderModule.openAudioSession();

    if (!await recorderModule.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
    }
  }

  Future<void> init() async {
    await openTheRecorder();
    await _initializeExample();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  @override
  void initState() {
    if (Global.checkNull(widget.strVoiceNotePath)) {
      if (Global.isURL(widget.strVoiceNotePath)) {
        isShowRecordButton = false;
        isShowPlayView = true;
        isHideRemoveButton = false;
        _media = Media.remoteExampleFile;
        remoteSample = widget.strVoiceNotePath;
      }
    }
    super.initState();
    init();
  }

  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
      _recorderSubscription = null;
    }
  }

  void cancelPlayerSubscriptions() {
    if (_playerSubscription != null) {
      _playerSubscription!.cancel();
      _playerSubscription = null;
    }
  }

  void cancelRecordingDataSubscription() {
    if (_recordingDataSubscription != null) {
      _recordingDataSubscription!.cancel();
      _recordingDataSubscription = null;
    }
    recordingDataController = null;
    if (sink != null) {
      sink!.close();
      sink = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelPlayerSubscriptions();
    cancelRecorderSubscriptions();
    cancelRecordingDataSubscription();
    releaseFlauto();
  }

  Future<void> releaseFlauto() async {
    try {
      await playerModule.closeAudioSession();
      await recorderModule.closeAudioSession();
    } on Exception {
      playerModule.logger.e('Released unsuccessful');
    }
  }

  void startRecorder() async {
    try {
      // Request Microphone permission if needed
      if (!kIsWeb) {
        var status = await Permission.microphone.request();
        if (status != PermissionStatus.granted) {
          throw RecordingPermissionException(
              'Microphone permission not granted');
        }
      }
      var path = '';

      var tempDir = await getTemporaryDirectory();
      path = '${tempDir.path}/flutter_sound${ext[_codec.index]}';

      await recorderModule.startRecorder(
        toFile: path,
        codec: _codec,
        bitRate: 8000,
        numChannels: 1,
        sampleRate: (_codec == Codec.pcm16) ? tSTREAMSAMPLERATE : tSAMPLERATE,
      );
      recorderModule.logger.d('startRecorder');

      _recorderSubscription = recorderModule.onProgress!.listen((e) {
        var date = DateTime.fromMillisecondsSinceEpoch(
            e.duration.inMilliseconds,
            isUtc: true);
        var txt = DateFormat('mm:ss', 'en_GB').format(date);

        setState(() {
          _recorderTxt = txt; //.substring(0, 8);
          _dbLevel = e.decibels;
        });
      });

      setState(() {
        _isRecording = true;
        _path = path;
        updatePath();
      });
    } on Exception catch (err) {
      recorderModule.logger.e('startRecorder error: $err');
      setState(() {
        stopRecorder();
        _isRecording = false;
        cancelRecordingDataSubscription();
        cancelRecorderSubscriptions();
      });
    }
  }

  updatePath() {
    widget.callback(_path);
  }

  void stopRecorder() async {
    try {
      await recorderModule.stopRecorder();
      recorderModule.logger.d('stopRecorder');
      cancelRecorderSubscriptions();
      cancelRecordingDataSubscription();
    } on Exception catch (err) {
      recorderModule.logger.d('stopRecorder error: $err');
    }
    setState(() {
      isShowRecordButton = false;
      isShowPlayView = true;
      _isRecording = false;
    });
  }

  Future<bool> fileExists(String path) async {
    return await File(path).exists();
  }

  // In this simple example, we just load a file in memory.This is stupid but just for demonstration  of startPlayerFromBuffer()
  Future<Uint8List?> makeBuffer(String path) async {
    try {
      if (!await fileExists(path)) return null;
      var file = File(path);
      file.openRead();
      var contents = await file.readAsBytes();
      playerModule.logger.i('The file is ${contents.length} bytes long.');
      return contents;
    } on Exception catch (e) {
      playerModule.logger.e(e);
      return null;
    }
  }

  void _addListeners() {
    cancelPlayerSubscriptions();
    _playerSubscription = playerModule.onProgress!.listen((e) {
      maxDuration = e.duration.inMilliseconds.toDouble();
      if (maxDuration <= 0) maxDuration = 0.0;

      sliderCurrentPosition =
          min(e.position.inMilliseconds.toDouble(), maxDuration);
      if (sliderCurrentPosition < 0.0) {
        sliderCurrentPosition = 0.0;
      }

      var date = DateTime.fromMillisecondsSinceEpoch(e.position.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss', 'en_GB').format(date);
      setState(() {
        _playerTxt = txt; //.substring(0, 8);
      });
    });
  }

  Future<Uint8List> _readFileByte(String filePath) async {
    var myUri = Uri.parse(filePath);
    var audioFile = File.fromUri(myUri);
    Uint8List bytes;
    var b = await audioFile.readAsBytes();
    bytes = Uint8List.fromList(b);
    playerModule.logger.d('reading of bytes is completed');
    return bytes;
  }

  Future<Uint8List> getAssetData(String path) async {
    var asset = await rootBundle.load(path);
    return asset.buffer.asUint8List();
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, dialogTitle: "select file", type: FileType.audio);

    if (result != null) {
      setState(() {
        _path = result.files.first.path!;
        _media = Media.file;
        // remoteSample = widget.strVoiceNotePath;
      });
    } else {
      // User canceled the picker
    }
  }

  /*
  Future<void> feedHim(String path) async {
    var data = await _readFileByte(path);
    return await playerModule.feedFromStream(data);
  }
*/

  final int blockSize = 4096;

  Future<void> feedHim(String path) async {
    var buffer = await _readFileByte(path);
    //var buffer = await getAssetData('assets/samples/sample.pcm');

    var lnData = 0;
    var totalLength = buffer.length;
    while (totalLength > 0 && !playerModule.isStopped) {
      var bsize = totalLength > blockSize ? blockSize : totalLength;
      await playerModule
          .feedFromStream(buffer.sublist(lnData, lnData + bsize)); // await !!!!
      lnData += bsize;
      totalLength -= bsize;
    }
  }

  Future<void> startPlayer() async {
    try {
      Uint8List? dataBuffer;
      String? audioFilePath;
      var codec = _codec;
      if (_media == Media.file) {
        // Do we want to play from buffer or from file ?
        if (kIsWeb || await fileExists(_path)) {
          audioFilePath = _path;
        }
      } else if (_media == Media.remoteExampleFile) {
        audioFilePath = remoteSample;
      }

      if (audioFilePath != null) {
        await playerModule.startPlayer(
            fromURI: audioFilePath,
            codec: codec,
            sampleRate: tSTREAMSAMPLERATE,
            whenFinished: () {
              playerModule.logger.d('Play finished');
              setState(() {});
            });
      } else if (dataBuffer != null) {
        if (codec == Codec.pcm16) {
          dataBuffer = await flutterSoundHelper.pcmToWaveBuffer(
            inputBuffer: dataBuffer,
            numChannels: 1,
            sampleRate: tSAMPLERATE,
          );
          codec = Codec.pcm16WAV;
        }
        await playerModule.startPlayer(
            fromDataBuffer: dataBuffer,
            sampleRate: tSAMPLERATE,
            codec: codec,
            whenFinished: () {
              playerModule.logger.d('Play finished');
              setState(() {});
            });
      }
      _addListeners();
      setState(() {});
      playerModule.logger.d('<--- startPlayer');
    } on Exception catch (err) {
      playerModule.logger.e('error: $err');
    }
  }

  Future<void> stopPlayer() async {
    try {
      await playerModule.stopPlayer();
      playerModule.logger.d('stopPlayer');
      if (_playerSubscription != null) {
        await _playerSubscription!.cancel();
        _playerSubscription = null;
      }
      sliderCurrentPosition = 0.0;
    } on Exception catch (err) {
      playerModule.logger.d('error: $err');
    }
    setState(() {});
  }

  void pauseResumePlayer() async {
    try {
      if (playerModule.isPlaying) {
        await playerModule.pausePlayer();
      } else {
        await playerModule.resumePlayer();
      }
    } on Exception catch (err) {
      playerModule.logger.e('error: $err');
    }
    setState(() {});
  }

  void pauseResumeRecorder() async {
    try {
      if (recorderModule.isPaused) {
        await recorderModule.resumeRecorder();
      } else {
        await recorderModule.pauseRecorder();
        assert(recorderModule.isPaused);
      }
    } on Exception catch (err) {
      recorderModule.logger.e('error: $err');
    }
    setState(() {});
  }

  Future<void> seekToPlayer(int milliSecs) async {
    //playerModule.logger.d('-->seekToPlayer');
    try {
      if (playerModule.isPlaying) {
        await playerModule.seekToPlayer(Duration(milliseconds: milliSecs));
      }
    } on Exception catch (err) {
      playerModule.logger.e('error: $err');
    }
    setState(() {});
    //playerModule.logger.d('<--seekToPlayer');
  }

  void Function()? onPauseResumePlayerPressed() {
    if (playerModule.isPaused || playerModule.isPlaying) {
      return pauseResumePlayer;
    }
    return null;
  }

  void Function()? onPauseResumeRecorderPressed() {
    if (recorderModule.isPaused || recorderModule.isRecording) {
      return pauseResumeRecorder;
    }
    return null;
  }

  void Function()? onStopPlayerPressed() {
    return (playerModule.isPlaying || playerModule.isPaused)
        ? stopPlayer
        : null;
  }

  void Function()? onStartPlayerPressed() {
    if (_media == Media.file) // A file must be already recorded to play it
    {
      if (!Global.checkNull(_path)) return null;
    }

    // Disable the button if the selected codec is not supported
    if (!(_decoderSupported || _codec == Codec.pcm16)) {
      return null;
    }

    return (playerModule.isStopped) ? startPlayer : null;
  }

  void startStopRecorder() {
    if (recorderModule.isRecording || recorderModule.isPaused) {
      stopRecorder();
    } else {
      startRecorder();
    }
  }

  void Function()? onStartRecorderPressed() {
    // Disable the button if the selected codec is not supported
    if (!_encoderSupported!) return null;
    return startStopRecorder;
  }

  Icon recorderIcon() {
    if (onStartRecorderPressed() == null) {
      return const Icon(Icons.mic_off);
    }
    return (recorderModule.isStopped)
        ? Icon(
            Icons.mic,
            color: AppColors.colorChatBgRight,
          )
        : const Icon(Icons.stop);
  }

  Future<void> setCodec(Codec codec) async {
    _encoderSupported = await recorderModule.isEncoderSupported(codec);
    _decoderSupported = await playerModule.isDecoderSupported(codec);

    setState(() {
      _codec = codec;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget recorderSection = Visibility(
      child: Row(
        children: [
          Container(
            child: MediaButton(
              strImage: AppImages.ic_cloud,
              onPressed: () {
                if (!_isRecording) {
                  //pickFile();
                  Global.inProgressAlert(context);
                } else {}
              },
            ),
            margin: const EdgeInsetsDirectional.only(end: AppDimens.dimens_15),
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                child: Container(
                  color: AppColors.colorGray2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Visibility(
                          child: Text(
                            _recorderTxt,
                            style: AppStyle.textViewStyleNormalSubtitle2(
                                context: context, color: AppColors.colorBlack),
                          ),
                          visible: _isRecording,
                        ),
                        Visibility(
                          child: LinearProgressIndicator(
                              value: 100.0 / 160.0 * (_dbLevel ?? 1) / 100,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.colorGreen),
                              backgroundColor: AppColors.colorBlueEnd),
                          visible: false,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: AppDimens.dimens_50,
                              height: AppDimens.dimens_50,
                              child: TextButton(
                                onPressed: onStartRecorderPressed(),
                                child: recorderIcon(),
                              ),
                            ),
                            // Visibility(
                            //   child: Container(
                            //     width: AppDimens.dimens_50,
                            //     height: AppDimens.dimens_50,
                            //     child: ClipOval(
                            //       child: TextButton(
                            //           onPressed: onPauseResumeRecorderPressed(),
                            //           child: Icon(Icons.pause)),
                            //     ),
                            //   ),
                            //   visible: onPauseResumeRecorderPressed() != null,
                            // )
                          ],
                        ),
                      ]),
                  width: AppDimens.dimens_100,
                  height: AppDimens.dimens_100,
                )),
            margin: const EdgeInsetsDirectional.only(end: AppDimens.dimens_15),
          ),
        ],
      ),
      visible: isShowRecordButton,
    );
    Widget playerSection = Visibility(
      child: SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: AppColors.colorGray2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    child: Text(
                      _playerTxt,
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context, color: AppColors.colorBlack),
                    ),
                    visible: onPauseResumePlayerPressed() != null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: AppDimens.dimens_50,
                        height: AppDimens.dimens_50,
                        child: TextButton(
                            onPressed: onStartPlayerPressed(),
                            child: Icon(
                              Icons.play_arrow,
                              color: AppColors.colorChatBgRight,
                            )),
                      ),
                      SizedBox(
                        width: AppDimens.dimens_50,
                        height: AppDimens.dimens_50,
                        child: TextButton(
                          onPressed: onPauseResumePlayerPressed(),
                          child: const Icon(Icons.pause),
                        ),
                      ),
                      SizedBox(
                        width: AppDimens.dimens_50,
                        height: AppDimens.dimens_50,
                        child: TextButton(
                            onPressed: onStopPlayerPressed(),
                            child: const Icon(Icons.stop)),
                      ),
                    ],
                  ),
                  // Container(
                  //     height: 30.0,
                  //     child: Slider(
                  //         value: min(sliderCurrentPosition, maxDuration),
                  //         min: 0.0,
                  //         max: maxDuration,
                  //         onChanged: (value) async {
                  //           await seekToPlayer(value.toInt());
                  //         },
                  //         divisions: maxDuration == 0.0 ? 1 : maxDuration.toInt())),
                ],
              ),
              width: AppDimens.dimens_150,
              height: AppDimens.dimens_100,
            ),
            Positioned(
                right: 0,
                top: 0,
                child: Visibility(
                  child: InkWell(
                    child: const Icon(Icons.close),
                    onTap: () {
                      print("------close--------");
                      // setState(() {
                      //   _path = "";
                      //   isShowPlayView = false;
                      //   isShowRecordButton = true;
                      // });
                      // updatePath();
                    },
                  ),
                  visible: isHideRemoveButton,
                ))
          ],
        ),
        width: AppDimens.dimens_150,
      ),
      visible: isShowPlayView,
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Flutter Sound Demo'),
    //   ),
    //   body: Row(
    //     children: <Widget>[
    //       recorderSection,
    //       playerSection,
    //     ],
    //   ),
    // );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          recorderSection,
          playerSection,
        ],
      ),
    );
  }
}
