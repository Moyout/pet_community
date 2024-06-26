import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:pet_community/models/article/release_article_model.dart';
import 'package:pet_community/models/upload/article_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/mine_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/login_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/sign_login_viewmodel.dart';
import 'package:pet_community/views/sign_login/sign_login_view.dart';
import 'package:pet_community/widget/dialog/cupertino_dialog.dart';

class ReleaseWorkViewModel extends ChangeNotifier {
  ImagePicker picker = ImagePicker();
  TextEditingController titleC = TextEditingController();
  TextEditingController textC = TextEditingController();
  List<File> fileList = [];

  // Set<String> picUrl = {};
  List<String> picUrl = [];

  ///初始化viewModel
  void initViewModel() {
    textC.clear();
    titleC.clear();
    fileList.clear();
    picUrl.clear();
  }

  ///选择图片
  Future<void> selectPicture() async {
    List<XFile>? images2 = await picker.pickMultiImage(maxHeight: 4000, maxWidth: 2500, imageQuality: 90);

    if (fileList.length + images2.length <= 9) {
      for (XFile item in images2) {
        fileList.add(File(item.path));
      }
    } else {
      ToastUtil.showBottomToast("最多可选择9张图片");
    }
    notifyListeners();
  }

  ///移除图片
  void removePicture(int index) {
    fileList.removeAt(index);
    notifyListeners();
  }

  ///上传图片
  Future<bool> uploadPic() async {
    String? token = SpUtil.getString(PublicKeys.token);
    int? userId = SpUtil.getInt(PublicKeys.userId);
    bool isSuccess = true;
    for (File item in fileList) {
      ArticleModel articleModel = await UploadArticlePicRequest.uploadArticlePic(userId!, token!, item.path);
      if (articleModel.code == 0) {
        if (!picUrl.contains(articleModel.data!)) picUrl.add(articleModel.data!);
      } else if (articleModel.code == 1007) {
        isSuccess = false;
        ToastUtil.showBottomToast(articleModel.msg!);
        RouteUtil.pushNamed(AppUtils.getContext(), SignLoginView.routeName);
        break;
      } else {
        ToastUtil.showBottomToast(articleModel.msg!);
        isSuccess = false;
        break;
      }
    }
    debugPrint("picUrl--------->$picUrl");
    return isSuccess;
  }

  ///发布
  Future<bool> releaseArticle(BuildContext context) async {
    debugPrint("picUrl.isNotEmpty--------->${picUrl.isNotEmpty}");
    debugPrint("picUrl.picUrl.length>0--------->${picUrl.isNotEmpty}");
    bool isRelease = false;
    bool isSuccess = await uploadPic();
    if (isSuccess) {
      int userId = SpUtil.getInt(PublicKeys.userId)!;
      String token = SpUtil.getString(PublicKeys.token)!;
      String userName = AppUtils.getContext().read<NavViewModel>().userInfoModel?.data?.userName ?? "";
      ReleaseArticleModel releaseArticleModel = await ReleaseArticleRequest.releaseArticle(
        title: titleC.text.trim(),
        content: textC.text.trim(),
        cover: "cover",
        pictures: picUrl.isNotEmpty ? picUrl.join(";") : null,
        userId: userId,
        token: token,
      );
      if (releaseArticleModel.code == 0) {
        isRelease = true;
        ToastUtil.showBottomToast(releaseArticleModel.msg!);
      } else if (releaseArticleModel.code == 1007) {
        LoginViewModel.tokenExpire(msg: releaseArticleModel.msg);
      }
    }
    return isRelease;
  }

  ///提交
  void onSubmit(BuildContext context) async {
    if (textC.text.trim().isEmpty && fileList.isNotEmpty) {
      showDialog(
        context: context,
        builder: (contextShowDialog) => CupertinoDialog(
          content: "当前图文无配文是否发布",
          onYes: () async {
            Navigator.pop(context);
            bool isRelease = await releaseArticle(context);
            if (isRelease) Navigator.pop(context);
            context.read<MineViewModel>().getUserWorks(context);
          },
        ),
      );
    } else {
      bool isRelease = await releaseArticle(context);
      if (isRelease) Navigator.pop(context);
      context.read<MineViewModel>().getUserWorks(context);
    }
  }
}
