import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/edit_data/edit_data_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:photo_view/photo_view.dart';

class SetBackgroundView extends StatefulWidget {
  static const String routeName = "SetBackgroundView";
  final String? background;
  final bool isOther;

  const SetBackgroundView({
    Key? key,
    required this.background,
    this.isOther = false,
  }) : super(key: key);

  @override
  State<SetBackgroundView> createState() => _SetBackgroundViewState();
}

class _SetBackgroundViewState extends State<SetBackgroundView> {


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
        child: Stack(
          children: [
            PageView(
              children: [
                Hero(
                  tag: "background",
                  child: widget.background != null && widget.background != "null"
                      ? PhotoView(
                          imageProvider: NetworkImage(widget.background!),
                        )
                      : PhotoView(imageProvider: const AssetImage("assets/images/backgrounds/pet_bg.png")),
                )
              ],
            ),
            Positioned(
              bottom: 20.w,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                // height: 90.w,
                height: 45.w,
                child: widget.isOther
                    ? const SizedBox()
                    : context.watch<NavViewModel>().isLogin
                        ? Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("更换背景图"),
                                          Icon(Icons.edit_sharp, size: 18),
                                        ],
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xff252525),
                                      primary: Colors.white,
                                      textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () => context.read<EditDataViewModel>().setBackground(context),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: SizedBox(
                              //     width: double.infinity,
                              //     child: TextButton(
                              //       child: Padding(
                              //         padding: EdgeInsets.symmetric(horizontal: 10.w),
                              //         child: Row(
                              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //           children: const [
                              //             Text("保存头像"),
                              //             Icon(Icons.download_sharp, size: 18),
                              //           ],
                              //         ),
                              //       ),
                              //       style: TextButton.styleFrom(
                              //         backgroundColor: const Color(0xff252525),
                              //         primary: Colors.white,
                              //         textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                              //       ),
                              //       onPressed: () {},
                              //     ),
                              //   ),
                              // ),
                            ],
                          )
                        : const SizedBox(),
              ),
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
          ],
        ),
      ),
    );
  }
}
