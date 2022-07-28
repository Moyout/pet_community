import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/home/video_viewmodel.dart';

class VideoWidget extends StatefulWidget {
  final String videoUrl;
  final String picUrl;
  final int index;

  const VideoWidget({
    Key? key,
    required this.videoUrl,
    required this.picUrl,
    required this.index,
  }) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  void initState() {
    super.initState();
    context.read<VideoViewModel>().initViewModel(widget.videoUrl, context);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (context.read<VideoViewModel>().playerController?.value.isPlaying ?? false) {
                context.read<VideoViewModel>().playerController?.pause();
              } else {
                context.read<VideoViewModel>().playerController?.play();
              }
            },
            child: Container(
              alignment: Alignment.center,
              // color: Colors.black,
              child: AspectRatio(
                aspectRatio: context.watch<VideoViewModel>().playerController?.value.aspectRatio ?? 1 / 2,
                child: !context.watch<VideoViewModel>().playerController!.value.isInitialized
                    ? Hero(
                        tag: widget.picUrl + widget.index.toString(),
                        child: CachedNetworkImage(
                          cacheKey: widget.picUrl,
                          imageUrl: widget.picUrl,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Hero(
                        tag: widget.picUrl + widget.index.toString(),
                        child: VideoPlayer(context.watch<VideoViewModel>().playerController!),
                      ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: buildProgress(),
          ),
          if (!context.watch<VideoViewModel>().playerController!.value.isPlaying)
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  if (context.read<VideoViewModel>().playerController?.value.isPlaying ?? false) {
                    context.read<VideoViewModel>().playerController?.pause();
                  } else {
                    context.read<VideoViewModel>().playerController?.play();
                  }
                },
                child: const Icon(IconData(0xe7fd, fontFamily: "AliIcon"), color: Colors.grey, size: 80),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildProgress() {
    return SafeArea(
      child: context.watch<VideoViewModel>().position.isNaN ||
              context.watch<VideoViewModel>().playerController!.value.isBuffering
          ? Container(
              height: 22.w,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: SizedBox(
                height: 2.w,
                child: const LinearProgressIndicator(color: Colors.white),
              ),
            )
          : Container(
              height: 22.w,
              width: MediaQuery.of(context).size.width,
              // color: Colors.grey.withOpacity(0.2),
              alignment: Alignment.center,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanDown: (DragDownDetails e) {
                  context.read<VideoViewModel>().dragState = DragState.dragStateBegin;
                  context.read<VideoViewModel>().playerController?.pause();
                  context.read<VideoViewModel>().notifyListeners();
                },
                onHorizontalDragUpdate: (DragUpdateDetails v) {
                  context.read<VideoViewModel>().onHorizontalDragUpdate(context, v.globalPosition.dx);
                },
                onHorizontalDragEnd: (DragEndDetails v) {
                  context.read<VideoViewModel>().onHorizontalDragEnd(context);
                },
                onTapUp: (v) {
                  context.read<VideoViewModel>().dragState = DragState.dragStateEnd;
                  context.read<VideoViewModel>().playerController?.play();
                  context.read<VideoViewModel>().notifyListeners();
                },
                onVerticalDragEnd: (v) {
                  context.read<VideoViewModel>().dragState = DragState.dragStateEnd;
                  context.read<VideoViewModel>().notifyListeners();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 10.w,
                      left: 0,
                      bottom: 10.w,
                      child: Container(
                        height: 2.w,
                        color: Colors.grey.withOpacity(0.5),
                        width: context.watch<VideoViewModel>().cacheWidth,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            constraints: BoxConstraints(
                              minWidth: 0,
                              maxWidth: MediaQuery.of(context).size.width - 8.w,
                            ),
                            duration: const Duration(milliseconds: 200),
                            width: context.watch<VideoViewModel>().position,
                            color: Colors.white,
                            height: context.watch<VideoViewModel>().dragState == DragState.dragStateBegin ? 12.w : 3.w,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: context.watch<VideoViewModel>().dragState == DragState.dragStateBegin ? 18.w : 5.w,
                            width: context.watch<VideoViewModel>().dragState == DragState.dragStateBegin ? 8.w : 5.w,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(22.w),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    AppUtils.getContext().read<VideoViewModel>().disposeController();
    super.dispose();
  }
}
// import 'package:pet_community/util/tools.dart';
// import 'package:pet_community/view_models/home/video_viewmodel.dart';
//
// class VideoWidget extends StatefulWidget {
//   final String videoUrl;
//   final String picUrl;
//   final int index;
//
//   const VideoWidget({
//     Key? key,
//     required this.videoUrl,
//     required this.picUrl,
//     required this.index,
//   }) : super(key: key);
//
//   @override
//   State<VideoWidget> createState() => _VideoWidgetState();
// }
//
// class _VideoWidgetState extends State<VideoWidget> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<VideoViewModel>().initViewModel(widget.videoUrl);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: const SystemUiOverlayStyle(
//           statusBarBrightness: Brightness.dark,
//           statusBarIconBrightness: Brightness.light,
//           statusBarColor: Colors.transparent,
//         ),
//         child: GestureDetector(
//           onTap: () {
//             if (context.read<VideoViewModel>().chewC?.isPlaying ?? false) {
//               context.read<VideoViewModel>().chewC?.pause();
//             } else {
//               context.read<VideoViewModel>().chewC?.play();
//             }
//           },
//           child: Container(
//             alignment: Alignment.center,
//             // color: Colors.black,
//             child: AspectRatio(
//               aspectRatio: context.watch<VideoViewModel>().playerController?.value.aspectRatio ?? 1 / 1,
//               child: context.watch<VideoViewModel>().chewC == null ||
//                       context.watch<VideoViewModel>().playerController == null
//                   ? Hero(
//                       tag: widget.picUrl + widget.index.toString(),
//                       child: CachedNetworkImage(
//                         imageUrl: widget.picUrl,
//                         fit: BoxFit.cover,
//                       ),
//                     )
//                   : Hero(
//                       tag: widget.picUrl + widget.index.toString(),
//                       child: Chewie(
//                         controller: context.watch<VideoViewModel>().chewC!,
//                       ),
//                     ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     AppUtils.getContext().read<VideoViewModel>().disposeController();
//     super.dispose();
//   }
// }
