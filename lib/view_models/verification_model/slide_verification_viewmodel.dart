import 'dart:math';

import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/sign_login/sign_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';

class SlideVerificationViewModel extends ChangeNotifier {
  double initial = 0;
  double sliderDistance = 0;
  double margin = 40.w;
  double padding = 10.w;
  double sliderWidth = 40.w;
  double picHeight = 160.w;
  late int dxRandom = 0;
  late int dyRandom = 0;
  double opacity = 0.8;
  bool isPass = false;
  bool isShowError = false;
  int randomIndex = 0;

  void initViewModel() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      refresh();
    });
  }

  void refresh() {
    randomIndex = Random().nextInt(AppUtils.getContext().read<StartUpViewModel>().jpgFileCount);
    opacity = 0.8;
    sliderDistance = 0;
    isPass = false;

    dxRandom =
        Random().nextInt((AppUtils.getWidth() - (2 * margin + 2 * padding + sliderWidth) - sliderWidth * 2).toInt());
    dyRandom = Random().nextInt(120.w.toInt());
    notifyListeners();
  }

  void onHorizontalDragStart(DragStartDetails details) {
    initial = details.globalPosition.dx;
    notifyListeners();
  }

  void onHorizontalDragUpdate(DragUpdateDetails details, BuildContext context) {
    sliderDistance = details.globalPosition.dx - initial;
    if (sliderDistance < 0) {
      sliderDistance = 0;
    }
    if (sliderDistance >= MediaQuery.of(context).size.width - (2 * margin + 2 * padding + sliderWidth)) {
      sliderDistance = MediaQuery.of(context).size.width - (2 * margin + 2 * padding + sliderWidth);
    }
    if (((dxRandom + sliderWidth).floor() - sliderDistance.floor()).abs() <= 2) {
      opacity = 0;
      notifyListeners();
    } else {
      opacity = 0.8;
      notifyListeners();
    }
    notifyListeners();
  }

  void onHorizontalDragEnd(BuildContext context) {
    if (opacity == 0) {
      isPass = true;
      context.read<SignViewModel>().isSendVerification = true;
      notifyListeners();
      context.read<SignViewModel>().sendVerificationCode();
      Future.delayed(const Duration(milliseconds: 800)).then((value) {
        Navigator.pop(context);
      });
    } else {
      isPass = false;
      isShowError = true;
      sliderDistance = 0;
      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        isShowError = false;
      });
    }
    notifyListeners();
  }
}
