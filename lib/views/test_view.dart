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
  Matrix4 matrix = Matrix4.identity();
  late AnimationController ac, ac2, ac3;
  late Animation animation, animation2, animation3;
  RtmpConnection? _connection;
  RtmpStream? _stream;
  bool _recording = false;
  CameraPosition currentPosition = CameraPosition.back;

  @override
  void initState() {
    super.initState();
    initAc(this);
    init();
    initPlatformState();
  }

  initAc(TickerProvider tp) {
    ac = AnimationController(vsync: tp, duration: const Duration(milliseconds: 800));
    ac2 = AnimationController(vsync: tp, duration: const Duration(milliseconds: 1000));
    ac3 = AnimationController(vsync: tp, duration: const Duration(milliseconds: 1200));
    CurvedAnimation ca = CurvedAnimation(parent: ac, curve: Curves.bounceInOut);
    CurvedAnimation ca2 = CurvedAnimation(parent: ac2, curve: Curves.bounceInOut);
    CurvedAnimation ca3 = CurvedAnimation(parent: ac3, curve: Curves.bounceInOut);
    animation = Tween(begin: 1000.0, end: 0.0).animate(ca);
    animation2 = Tween(begin: 1000.0, end: 0.0).animate(ca2);
    animation3 = Tween(begin: 1800.0, end: 0.0).animate(ca3);

    ac.forward();
    ac2.forward();
    ac3.forward();
    ac.addListener(() {
      setState(() {});
    });
    ac2.addListener(() {
      setState(() {});
    });
    ac3.addListener(() {
      setState(() {});
    });
  }

  init() {
    matrix.setEntry(3, 2, 0.001); // 设置矩阵的元素，实现透视效果
    // matrix.rotateY(pi / 4); // 绕 y 轴旋转
    // matrix.rotateX(90); // 绕 x轴旋转
    matrix.rotateZ(pi / 180 * 3); // 绕 Z 轴旋转
    matrix.rotateY(pi / 180 * -10); // 绕 y 轴旋转
    matrix.rotateX(pi / 180 * 5); // 绕 y 轴旋转

    ///2
    // matrix2.setEntry(3, 2, 0.001); // 设置矩阵的元素，实现透视效果
    // // matrix.rotateY(pi / 4); // 绕 y 轴旋转
    // // matrix.rotateX(90); // 绕 x轴旋转
    // matrix2.rotateZ(pi / 180 * -5); // 绕 Z 轴旋转
    // // matrix2.rotateY(pi / 180 * -10); // 绕 y 轴旋转
    // // matrix2.rotateX(pi / 180 * -20); // 绕 y 轴旋转

    setState(() {});
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
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateZ(pi / 180 * 3)
                    ..rotateY(pi / 180 * -10)
                    ..rotateX(pi / 180 * 5)
                    ..translate(0.0, 0.0, -animation.value),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(12.w),
                    color: Colors.blueGrey,
                    clipBehavior: Clip.antiAlias,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Container(
                        alignment: Alignment.center,
                        height: 120.w,
                        width: MediaQuery.of(context).size.width,
                        child: Text("火火火🔥"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, -0.001)
                    ..rotateZ(pi / 180 * -5)
                    ..rotateX(pi / 180 * -5)
                    ..translate(0.0, 0.0, animation2.value),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(12.w),
                    color: Colors.brown,
                    clipBehavior: Clip.antiAlias,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Container(
                        alignment: Alignment.center,
                        height: 120.w,
                        width: MediaQuery.of(context).size.width,
                        child: Text("火火火🔥"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateZ(pi / 180 * 3)
                    ..rotateY(pi / 180 * -10)
                    ..rotateX(pi / 180 * 5)
                    ..translate(0.0, 0.0, -animation3.value),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(12.w),
                    color: Colors.blueGrey,
                    clipBehavior: Clip.antiAlias,
                    child: TextButton(
                      onPressed: () => startRtmp(),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Container(
                        alignment: Alignment.center,
                        height: 120.w,
                        width: MediaQuery.of(context).size.width,
                        child: Text("火火火🔥"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _stream == null ? const Text("") : Expanded(child: NetStreamDrawableTexture(_stream)),
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

  startRtmp() {}

  @override
  void dispose() {
    ac.dispose();
    ac2.dispose();
    ac3.dispose();

    super.dispose();
  }

  Future<void> initPlatformState() async {
    await Permission.camera.request();
    await Permission.microphone.request();

    // Set up AVAudioSession for iOS.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.allowBluetooth,
    ));

    RtmpConnection connection = await RtmpConnection.create();
    connection.eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["data"]["code"]) {
        case 'NetConnection.Connect.Success':
          _stream?.publish("test");
          setState(() {
            _recording = true;
          });
          break;
      }
    });
    RtmpStream stream = await RtmpStream.create(connection);
    stream.attachAudio(AudioSource());
    stream.attachVideo(VideoSource(position: currentPosition));

    if (!mounted) return;

    setState(() {
      _connection = connection;
      _stream = stream;
    });
  }
}
