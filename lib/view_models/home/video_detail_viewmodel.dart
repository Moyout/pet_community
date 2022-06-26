import 'package:pet_community/util/tools.dart';

class VideoDetailViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();
  bool isShow = true;
  int numLines = 1;

  void initViewModel() {
    isShow = true;
    textC.clear();
  }

  void setHideOrShow() {
    isShow = !isShow;
    notifyListeners();
  }

  void getTextLines() {
    numLines = '\n'.allMatches(textC.text).length + 1;
    notifyListeners();
  }
}
