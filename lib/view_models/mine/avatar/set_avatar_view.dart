import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/edit_data/edit_data_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';
import 'package:photo_view/photo_view.dart';

class SetAvatarView extends StatefulWidget {
  const SetAvatarView({Key? key}) : super(key: key);

  @override
  State<SetAvatarView> createState() => _SetAvatarViewState();
}

class _SetAvatarViewState extends State<SetAvatarView> {
  @override
  void initState() {
    super.initState();

    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.centerLeft,
              height: 80.w,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.clear, color: Colors.white, size: 28),
              ),
            ),
            SizedBox(
              height: 400.w,
              width: 400.w,
              child: PhotoView(
                minScale: 0.1,
                imageProvider: NetworkImage(
                  !context.watch<NavViewModel>().isLogin
                      ? ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg"
                      : context.watch<NavViewModel>().userInfoModel?.data?.avatar == "" ||
                              context.watch<NavViewModel>().userInfoModel?.data?.avatar == null
                          ? ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg"
                          : context.watch<NavViewModel>().userInfoModel?.data?.avatar ?? "",
                ),
              ),
            ),
            // Hero(
            //   tag: "avatar",
            //   child: Image.network(
            //     !context.watch<NavViewModel>().isLogin
            //         ? ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg"
            //         : context.watch<NavViewModel>().userInfoModel?.data?.avatar == "" ||
            //                 context.watch<NavViewModel>().userInfoModel?.data?.avatar == null
            //             ? ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg"
            //             : context.watch<NavViewModel>().userInfoModel?.data?.avatar ?? "",
            //     height: 400.w,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            const Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.w),
              ),
              // height: 90.w,
              height: 45.w,
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("更换头像"),
                              Icon(Icons.edit_sharp, size: 18),
                            ],
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xff252525),
                          primary: Colors.white,
                          textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => context.read<EditDataViewModel>().setAvatar(),
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
              ),
            ),
            SizedBox(height: 20.w),
          ],
        ),
      ),
    );
  }
}
