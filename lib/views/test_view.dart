import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:haishin_kit/audio_source.dart';
import 'package:haishin_kit/net_stream_drawable_texture.dart';
import 'package:haishin_kit/rtmp_connection.dart';
import 'package:haishin_kit/rtmp_stream.dart';
import 'package:haishin_kit/video_source.dart';
import 'package:pet_community/util/tools.dart';

class TestView extends StatefulWidget {
  static const String routeName = "TestView";

  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> with TickerProviderStateMixin {
  late RtmpConnection? _connection;
  RtmpStream? _stream;
  bool _recording = false;
  CameraPosition currentPosition = CameraPosition.back;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    bool res = await initPermission();
    debugPrint("res-------------------->${res}");
    if (res) initPlatformState();
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
            if (_stream != null) Expanded(child: NetStreamDrawableTexture(_stream)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: _recording ? const Icon(Icons.fiber_smart_record) : const Icon(Icons.not_started),
          onPressed: () {
            if (_recording) {
              _connection?.close();
              setState(() {
                _recording = false;
              });
            } else {
              _connection?.connect("rtmp://192.168.0.113:1935/live");
            }
          },
        ),
      ),
    );
  }

  Future<bool> initPermission() async {
    return await Permission.camera.request().isGranted && await Permission.microphone.request().isGranted;
  }

  Future<void> initPlatformState() async {
    // Set up AVAudioSession for iOS.
    AudioSession session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.allowBluetooth,
    ));

    _connection = await RtmpConnection.create();
    _connection?.eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["data"]["code"]) {
        case 'NetConnection.Connect.Success':
          _stream?.publish("test");
          setState(() {
            _recording = true;
          });
          break;
      }
    });
    if (_connection != null) {
      _stream = await RtmpStream.create(_connection!);
      _stream?.attachAudio(AudioSource());
      _stream?.attachVideo(VideoSource(position: currentPosition));
      setState(() {});
    }

    if (!mounted) return;
  }

  @override
  void dispose() {
    _connection?.close();
    super.dispose();
  }
}
