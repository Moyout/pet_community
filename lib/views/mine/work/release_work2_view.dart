import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_community/models/upload/upload_model.dart';
import 'package:pet_community/models/upload/upload_video_model.dart';
import 'package:pet_community/models/video/video_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/work/release_work_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ReleaseWork2View extends StatefulWidget {
  static const String routeName = 'ReleaseWork2View';

  const ReleaseWork2View({Key? key}) : super(key: key);

  @override
  State<ReleaseWork2View> createState() => _ReleaseWorkViewState();
}

class _ReleaseWorkViewState extends State<ReleaseWork2View> {
  NavViewModel nvm = AppUtils.getContext().read<NavViewModel>();
  TextEditingController titleC = TextEditingController();
  TextEditingController contentC = TextEditingController();

  ImagePicker picker = ImagePicker();
  XFile? videoXFile;
  String? fileName;

  late File cover;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("发布作品", style: TextStyle(fontSize: 14.sp)),
          actions: [
            Center(
              child: SizedBox(
                height: 25.w,
                width: 45.w,
                child: TextButton(
                  onPressed: (titleC.text.trim().isNotEmpty || videoXFile != null) ? () => onSubmit() : null,
                  style: TextButton.styleFrom(
                    backgroundColor:
                        (titleC.text.trim().isNotEmpty || videoXFile != null) ? const Color(0xff07C160) : Colors.grey,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                  ),
                  child: Text("发表", style: TextStyle(fontSize: 12.sp)),
                ),
              ),
            ),
            SizedBox(width: 10.w)
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: TextField(
                    controller: titleC,
                    maxLength: 20,
                    minLines: 1,
                    style: const TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "#标题",
                      counterText: "",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: TextField(
                    controller: contentC,
                    maxLines: 6,
                    maxLength: 200,
                    style: const TextStyle(letterSpacing: 1.2),
                    decoration: const InputDecoration(border: InputBorder.none, hintText: "#内容"),
                  ),
                ),
                if (videoXFile != null)
                  GestureDetector(
                    onTap: () => selectVideo(),
                    child: Container(
                      height: 150.w,
                      constraints: BoxConstraints(minWidth: 150.w),
                      margin: EdgeInsets.only(top: 10.w),
                      child: Image.file(cover, fit: BoxFit.cover),
                    ),
                  ),
                if (videoXFile == null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 10.w, left: 10.w),
                      width: 90.w,
                      height: 90.w,
                      color: Colors.grey.withOpacity(0.2),
                      child: TextButton(
                        onPressed: () => selectVideo(),
                        child: const Icon(Icons.add, size: 40),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectVideo() async {
    videoXFile = await picker.pickVideo(source: ImageSource.gallery);
    if (videoXFile != null) {
      String path = (await getTemporaryDirectory()).path;
      String thumbnailPath = path + "/${DateTime.now().millisecond}.jpg";
      fileName = await VideoThumbnail.thumbnailFile(
        video: videoXFile!.path,
        imageFormat: ImageFormat.JPEG,
        thumbnailPath: thumbnailPath,
        maxWidth: 128,
        // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 100,
      );
      cover = File(thumbnailPath);
      setState(() {});
    }
  }

  void onSubmit() async {
    String? token = SpUtil.getString(PublicKeys.token);
    UploadVideoModel um = await UploadRequest.uploadVideoFile(videoXFile!.path, nvm.userInfoModel?.data?.userId, token);
    if (um.data?.video != null) {
      bool isSuccess = await VideoRequest.releaseVideo(
        title: titleC.text.trim(),
        content: contentC.text.trim(),
        cover: um.data?.cover,
        videoPath: um.data?.video,
        userId: nvm.userInfoModel?.data?.userId,
        token: token,
      );
      if (isSuccess) {
        ToastUtil.showBottomToast("发布成功");
        Navigator.pop(context);
      }
    }
  }
}
