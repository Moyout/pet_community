import 'package:pet_community/util/tools.dart';

class ChatViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();
  bool isVoice = false;
  int numLines = 1;

  void initViewModel() {}

  void setIsVoice() {
    isVoice = !isVoice;
    notifyListeners();
  }

  void getTextLines() {
    numLines = '\n'.allMatches(textC.text).length + 1;
    notifyListeners();
  }
}
