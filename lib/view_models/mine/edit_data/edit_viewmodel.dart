import 'package:pet_community/models/user/set_signature_model.dart';
import 'package:pet_community/models/user/set_username_model.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';

class EditViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();

  void initViewModel(String title, BuildContext context) {
    if (title == "修改名字") {
      textC.text = context.read<NavViewModel>().userInfoModel?.data?.userName ?? "";
    } else if (title == "修改简介") {
      textC.text = context.read<NavViewModel>().userInfoModel?.data?.signature ?? "";
    }
  }

  void saveEditData(String title, BuildContext context) {
    if (title == "修改名字" && textC.text.trim().isNotEmpty) {
      setUserName(context);
    } else if (title == "修改简介" && textC.text.trim().isNotEmpty) {
      setUserSignature(context);
    }
  }

  ///设置UserName
  Future<void> setUserName(BuildContext context) async {
    int userId = context.read<NavViewModel>().userInfoModel!.data!.userId!;
    String token = SpUtil.getString(PublicKeys.token)!;
    SetUsernameModel setUsernameModel = await SetUserNameRequest.setUserName(userId, token, textC.text.trim());
    ToastUtil.showBottomToast(setUsernameModel.msg!);
    UserInfoRequest.getUserInfo(userId, token);
    Navigator.pop(context);
  }

  ///设置签名
  Future<void> setUserSignature(BuildContext context) async {
    int userId = context.read<NavViewModel>().userInfoModel!.data!.userId!;
    String token = SpUtil.getString(PublicKeys.token)!;
    SetSignatureModel setSignatureModel = await SetSignatureRequest.setUserSignature(userId, token, textC.text.trim());
    ToastUtil.showBottomToast(setSignatureModel.msg!);
    UserInfoRequest.getUserInfo(userId, token);
    Navigator.pop(context);
  }
}
