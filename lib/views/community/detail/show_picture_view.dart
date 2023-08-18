import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/community_detail_viewmodel.dart';
import 'package:photo_view/photo_view.dart';

class ShowPictureView extends StatefulWidget {
  static const String routeName = 'ShowPictureView';

  final List<String> picUrlList;
  final int index;

  const ShowPictureView({
    Key? key,
    required this.picUrlList,
    required this.index,
  }) : super(key: key);

  @override
  State<ShowPictureView> createState() => _ShowPictureViewState();
}

class _ShowPictureViewState extends State<ShowPictureView> {
  @override
  void initState() {
    context.read<CommunityDetailViewModel>().initPageController(widget.index);
    context.read<CommunityDetailViewModel>().initViewModel(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        child: ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: Stack(
            children: [
              PageView(
                onPageChanged: (index) => context.read<CommunityDetailViewModel>().pageOnPageChanged(index),
                controller: context.watch<CommunityDetailViewModel>().pc,
                children: [
                  ...List.generate(widget.picUrlList.length, (index) {
                    return PhotoView(imageProvider: NetworkImage(widget.picUrlList[index]));
                  })
                ],
              ),
              Positioned(
                top: kToolbarHeight,
                left: 0,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey, shape: const CircleBorder(), primary: Colors.white),
                  child: const Icon(Icons.close),
                  onPressed: () => RouteUtil.pop(context),
                ),
              ),
              Positioned(
                bottom: 10.w,
                right: 10.w,
                child: Text(
                  "${context.watch<CommunityDetailViewModel>().currentIndex + 1}/${widget.picUrlList.length}",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
