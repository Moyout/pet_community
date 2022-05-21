import 'package:pet_community/util/tools.dart';

class SignLoginViewModel extends ChangeNotifier {
  late PageController pageC;
  int initialPage = 0;

  void initViewModel() {
    pageC = PageController(initialPage: initialPage);
  }
}
