import 'dart:io';
import 'dart:typed_data';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_community/models/upload/avatar_model.dart';
import 'package:pet_community/models/user/set_area_model.dart';
import 'package:pet_community/models/user/set_avatar_model.dart';
import 'package:pet_community/models/user/set_sex_model.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/toast_util.dart';
import 'package:pet_community/util/tools.dart';

class EditDataViewModel extends ChangeNotifier {
  ImagePicker picker = ImagePicker();
  Uint8List? uint8list;
  File? image;
  CroppedFile? croppedFile;

  void initViewModel() {
    image = null;
    croppedFile = null;
    uint8list = null;
  }

  void setAvatar() {
    getImage();
  }

  ///选择图片
  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      cropFile();
      Uint8List? data = await image?.readAsBytes();
      debugPrint("data----------${data!.length}");
      debugPrint("data----------${(data.length / 1024)}");
    } else {
      debugPrint('No image selected.');
    }
    notifyListeners();
  }

  ///图片裁剪
  void cropFile() async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      aspectRatio: const CropAspectRatio(ratioY: 275, ratioX: 200),
      // compressQuality: 100,
      maxHeight: 4000,
      maxWidth: 2500,
      compressQuality: 90,
    );

    uint8list = (await croppedFile?.readAsBytes())!;
    debugPrint("uint8list?.length----------->${uint8list?.length}");
    debugPrint("uint8list?.length----------->${(uint8list?.length)! / 1024}");

    String? token = SpUtil.getString(PublicKeys.token);
    int? userId = SpUtil.getInt(PublicKeys.userId);
    AvatarModel avatarModel = await UploadAvatarRequest.uploadAvatar(userId!, token!, croppedFile!.path);
    String? filePath = avatarModel.data;

    SetAvatarModel setAvatarModel = await SetAvatarRequest.setUserAvatar(userId, token, filePath!);
    ToastUtil.showBottomToast(setAvatarModel.msg!);
    UserInfoRequest.getUserInfo(userId, token);
    notifyListeners();
  }

  ///设置性别
  Future<void> setUserSex(String sex, BuildContext context) async {
    int userId = SpUtil.getInt(PublicKeys.userId)!;
    String token = SpUtil.getString(PublicKeys.token)!;
    SetSexModel setSexModel = await SetSexRequest.setUserSex(userId, token, sex);
    ToastUtil.showBottomToast(setSexModel.msg!);
    await UserInfoRequest.getUserInfo(userId, token);
    notifyListeners();
    Navigator.pop(context);
  }

  Future<void> setUserArea(String area) async {
    int userId = SpUtil.getInt(PublicKeys.userId)!;
    String token = SpUtil.getString(PublicKeys.token)!;
    SetAreaModel setAreaModel = await SetAreaRequest.setUserArea(userId, token, area);
    ToastUtil.showBottomToast(setAreaModel.msg!);
    await UserInfoRequest.getUserInfo(userId, token);
    notifyListeners();
  }
}
