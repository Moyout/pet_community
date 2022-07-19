import 'package:pet_community/util/tools.dart';

class VideoDetailViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();
  ScrollController sc = ScrollController();
  bool showComment = false;

  void initViewModel() {
    textC.clear();
    showComment = false;
  }

  void openComment() {
    showComment = true;
    notifyListeners();
  }

  void closeComment() {
    showComment = false;
    notifyListeners();
  }
}
