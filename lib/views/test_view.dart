import 'dart:math';

import 'package:audio_session/audio_session.dart';

import 'package:pet_community/util/tools.dart';
import 'package:rtmp_broadcaster/camera.dart';
// import 'package:video_stream/camera.dart';
import 'package:video_player/video_player.dart';

class TestView extends StatefulWidget {
  static const String routeName = "TestView";

  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> with TickerProviderStateMixin {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  String streamURL = "rtmp://192.168.0.113:1935/live/test";
  bool _recording = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    bool res = await initPermission();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller?.initialize();
    controller?.addListener(() {});
  }

  Future<bool> initPermission() async {
    return await Permission.camera.request().isGranted && await Permission.microphone.request().isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Test"),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.w),
            if (_recording) Expanded(child: CameraPreview(controller!)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: _recording ? const Icon(Icons.stop_circle) : const Icon(Icons.not_started),
          onPressed: () => startRecord(),
        ),
      ),
    );
  }

  startRecord() async {
    if (!_recording) {
      controller?.startVideoStreaming(streamURL, androidUseOpenGL: false);
    } else {
      await controller?.pauseVideoStreaming();
      controller?.stopVideoStreaming();
    }
    _recording = !_recording;
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
