import 'package:pet_community/util/tools.dart';

class VideoViewModel extends ChangeNotifier {
  VideoPlayerController? playerController;
  double position = 0;
  double cacheWidth = 0;
  DragState dragState = DragState.dragStateIdle;

  void initViewModel(String videoUrl, BuildContext context) {
    initController(videoUrl, context);
  }

  ///初始化播放器
  Future<void> initController(String videoUrl, BuildContext context) async {
    position = 0;
    playerController = VideoPlayerController.network(videoUrl)
      ..initialize()
      ..setLooping(true)
      ..play()
      ..addListener(() {
        position = (MediaQuery.of(context).size.width) *
            ((playerController?.value.position.inMilliseconds ?? 0) /
                (playerController?.value.duration.inMilliseconds ?? 1));
        if (playerController!.value.buffered.isNotEmpty) {
          cacheWidth = MediaQuery.of(context).size.width *
              ((playerController?.value.buffered.first.end.inMilliseconds ?? 0) /
                  (playerController?.value.duration.inMilliseconds ?? 1));
        }
        notifyListeners();
      });
  }

  void onHorizontalDragUpdate(BuildContext context, double width) {
    dragState = DragState.dragStateBegin;
    position = width;
    debugPrint("Percent--------->${width / MediaQuery.of(context).size.width}");

    notifyListeners();
  }

  void onHorizontalDragEnd(BuildContext context) {
    dragState = DragState.dragStateEnd;
    double percent = position / MediaQuery.of(context).size.width;
    int inMilliseconds = (playerController!.value.duration.inMilliseconds * percent).toInt();
    playerController?.seekTo(Duration(milliseconds: inMilliseconds));
    playerController?.play();
    notifyListeners();
  }

  ///dispose控制器
  void disposeController() {
    playerController?.dispose();
  }
}

// import 'package:pet_community/util/tools.dart';
//
// class VideoViewModel extends ChangeNotifier {
//   ChewieController? chewC;
//   VideoPlayerController? playerController;
//
//   void initViewModel(String videoUrl) {
//     initController(videoUrl);
//   }
//
//   ///初始化播放器
//   void initController(String videoUrl) async {
//     playerController = VideoPlayerController.network(
//       videoUrl,
//     )..initialize().then((value) {
//         chewC = ChewieController(
//           videoPlayerController: playerController!,
//           showControls: false,
//           showOptions: false,
//           showControlsOnInitialize: false,
//           autoInitialize: true,
//           // customControls: Text(
//           //   "asd",
//           //   style: TextStyle(color: Colors.white),
//           // ),
//         )..play().then((value) => notifyListeners());
//       });
//   }
//
//   ///dispose控制器
//   void disposeController() {
//     playerController?.dispose();
//     playerController = null;
//     chewC?.dispose();
//     chewC = null;
//   }
// }
