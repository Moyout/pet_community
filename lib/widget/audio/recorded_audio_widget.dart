import 'dart:async';
import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/message/chat_viewmodel.dart';
import 'package:pet_community/widget/painters/record_audio_painter.dart';

class RecordAudioWidget extends StatefulWidget {
  const RecordAudioWidget({Key? key}) : super(key: key);

  @override
  State<RecordAudioWidget> createState() => _RecordAudioWidgetState();
}

class _RecordAudioWidgetState extends State<RecordAudioWidget> {
  FlutterSoundRecorder? recorderModule;

  StreamSubscription? _recorderSubscription;
  String _recorderTxt = '00:00:00';
  double _dbLevel = 0.0;
  var _duration = 0.0;
  String? _path;

  final _maxLength = 59.0;

  @override
  void initState() {
    super.initState();
    initSetting();
  }

  void initSetting() async {
    context.read<ChatViewModel>().recordPath = null;
    recorderModule = FlutterSoundRecorder();
    recorderModule?.openRecorder();
    await recorderModule?.setSubscriptionDuration(const Duration(milliseconds: 30));

    startRecorder();
  }

  void startRecorder() async {
    Directory tempDir = await getTemporaryDirectory();
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String path = Platform.isAndroid
        ? '${tempDir.path}/$timestamp${ext[Codec.aacADTS.index]}'
        // ? '${tempDir.path}/$timestamp.jpg}'
        : "${tempDir.path}/$timestamp${ext[Codec.pcm16WAV.index]}";
    debugPrint('===>  准备开始录音');
    await recorderModule?.startRecorder(
      toFile: path,
      codec: Platform.isAndroid ? Codec.aacADTS : Codec.pcm16WAV,
      bitRate: 1411200,
      sampleRate: 44100,
    );
    debugPrint('===>  开始录音');
    _recorderSubscription = recorderModule?.onProgress?.listen((e) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds, isUtc: true);
      String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
      if (date.second >= _maxLength) {
        _stopRecorder();
      }
      _recorderTxt = txt.substring(0, 8);
      if (mounted) {
        setState(() {
          _dbLevel = e.decibels!;
        });
      }
      // print("当前振幅：$_dbLevel");
    });
    _path = path;
    context.read<ChatViewModel>().recordPath = _path;
    debugPrint("path-----we---->${_path}");
  }

  /// 结束录音
  _stopRecorder() async {
    try {
      await recorderModule?.stopRecorder();
      await recorderModule?.closeRecorder();
      recorderModule?.dispositionStream();
      recorderModule = null;
      debugPrint('stopRecorder');
      _cancelRecorderSubscriptions();

      // _getDuration();
    } catch (err) {
      debugPrint('stopRecorder error: $err');
    }

    _dbLevel = 0.0;
  }

  /// 取消录音监听
  void _cancelRecorderSubscriptions() {
    _recorderSubscription?.cancel();

    _recorderSubscription = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.w,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      decoration: BoxDecoration(
        color: ThemeUtil.reversePrimaryColor(context),
        borderRadius: BorderRadius.circular(5.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
            size: Size(ScreenUtil.screenWidth / 2.5, 120.w / 2),
            foregroundPainter: LCPainter(amplitude: _dbLevel / 2, number: 30 - _dbLevel ~/ 20),
          ),
          Text(_recorderTxt)
        ],
      ),
    );
  }

  @override
  void dispose() {
    _stopRecorder();
    super.dispose();
  }
}
