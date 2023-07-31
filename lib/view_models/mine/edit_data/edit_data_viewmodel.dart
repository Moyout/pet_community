import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_community/models/upload/avatar_model.dart';
import 'package:pet_community/models/upload/background_model.dart';
import 'package:pet_community/models/user/set_area_model.dart';
import 'package:pet_community/models/user/set_avatar_model.dart';
import 'package:pet_community/models/user/set_background_model.dart';
import 'package:pet_community/models/user/set_sex_model.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/sign_login/login_viewmodel.dart';

class EditDataViewModel extends ChangeNotifier {
  ImagePicker picker = ImagePicker();

  void initViewModel() {}

  ///设置头像
  Future<void> setAvatar(BuildContext context) async {
    File? pickedFile = await getImage(context);
    if (pickedFile != null) {
      File? croppedFile = await cropFile(context, pickedFile.path);
      if (croppedFile != null) {
        String? token = SpUtil.getString(PublicKeys.token);
        int? userId = SpUtil.getInt(PublicKeys.userId);
        AvatarModel avatarModel = await UploadAvatarRequest.uploadAvatar(userId!, token!, croppedFile.path);
        if (avatarModel.code == 0) {
          String? filePath = avatarModel.data;
          SetAvatarModel setAvatarModel = await SetAvatarRequest.setUserAvatar(userId, token, filePath!);
          ToastUtil.showBottomToast(setAvatarModel.msg);
          UserInfoRequest.getUserInfo(userId, token);
          notifyListeners();
        } else if (avatarModel.code == 1007) {
          LoginViewModel.tokenExpire(msg: avatarModel.msg);
        }
      }
    }
  }

  ///设置背景
  Future<void> setBackground(BuildContext context) async {
    File? pickedFile = await getImage(context);
    if (pickedFile != null) {
      File? croppedFile = await cropFile(context, pickedFile.path, maxHeight: 2000, ratioY: 3, ratioX: 5);
      if (croppedFile != null) {
        String? token = SpUtil.getString(PublicKeys.token);
        int? userId = SpUtil.getInt(PublicKeys.userId);
        BackgroundModel backgroundModel =
            await UploadBackgroundRequest.uploadBackground(userId!, token!, croppedFile.path);
        if (backgroundModel.code == 0) {
          String? filePath = backgroundModel.data;
          SetBackgroundModel setBackgroundModel =
              await SetBackgroundRequest.setUserBackground(userId, token, filePath!);
          ToastUtil.showBottomToast(setBackgroundModel.msg);
          UserInfoRequest.getUserInfo(userId, token);
          notifyListeners();
        } else if (backgroundModel.code == 1007) {
          LoginViewModel.tokenExpire(msg: backgroundModel.msg);
        }
      }
    }
  }

  ///设置性别
  Future<void> setUserSex(String sex, BuildContext context) async {
    int userId = SpUtil.getInt(PublicKeys.userId)!;
    String token = SpUtil.getString(PublicKeys.token)!;
    SetSexModel setSexModel = await SetSexRequest.setUserSex(userId, token, sex);
    ToastUtil.showBottomToast(setSexModel.msg);
    await UserInfoRequest.getUserInfo(userId, token);
    notifyListeners();
    Navigator.pop(context);
  }

  ///设置地区
  Future<void> setUserArea(String area) async {
    int userId = SpUtil.getInt(PublicKeys.userId)!;
    String token = SpUtil.getString(PublicKeys.token)!;
    SetAreaModel setAreaModel = await SetAreaRequest.setUserArea(userId, token, area);
    ToastUtil.showBottomToast(setAreaModel.msg);
    await UserInfoRequest.getUserInfo(userId, token);
    notifyListeners();
  }

  ///选择图片
  Future<File?> getImage(BuildContext context) async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    File? image;
    if (pickedFile != null) image = File(pickedFile.path);
    return image;
  }

  ///图片裁剪
  Future<File?> cropFile(
    BuildContext context,
    String sourcePath, {
    int maxHeight = 4000,
    int maxWidth = 2500,
    double ratioY = 275,
    double ratioX = 200,
  }) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      aspectRatio: CropAspectRatio(ratioY: ratioY, ratioX: ratioX),
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      compressQuality: 90,
    );
    File? file;
    if (croppedFile != null) file = File(croppedFile.path);
    return file;
  }
}
