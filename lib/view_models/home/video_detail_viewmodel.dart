import 'package:flutter/rendering.dart';
import 'package:pet_community/util/tools.dart';

class VideoDetailViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();
  ScrollController sc = ScrollController();
  bool showComment = false;
  FocusNode focusNode = FocusNode();
  bool isNoSliding = false;
  late PointerMoveEvent pointerMoveEvent;

  void initViewModel() {
    textC.clear();
    showComment = false;
  }

  ///打开评论
  void openComment() {
    showComment = true;
    notifyListeners();
  }

  ///关闭评论
  void closeComment() {
    showComment = false;
    notifyListeners();
  }

  void getFocusNode(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(focusNode); // 获取焦点
    });
  }

  bool slidingProcessing(ScrollNotification notification, ScrollController sc) {
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.forward && pointerMoveEvent.localDelta.dy > 0 && sc.offset == 0.0) {
        isNoSliding = true;
        notifyListeners();
      }
    }
    return true;
  }

  void slidingListener(PointerMoveEvent value) {
    pointerMoveEvent = value;
    notifyListeners();
    debugPrint("pointerMoveEvent--------------》》${pointerMoveEvent.localDelta.dy}");
    if (pointerMoveEvent.localDelta.dy < 0) {
      isNoSliding = false;
      notifyListeners();
    }
  }
}
