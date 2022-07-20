import 'package:pet_community/util/tools.dart';

class VideoDetailViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();
  ScrollController sc = ScrollController();
  bool showComment = false;
  FocusNode focusNode = FocusNode();

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
    FocusScope.of(context).requestFocus(focusNode); // 获取焦点
    notifyListeners();
  }
}
