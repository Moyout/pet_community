import 'package:pet_community/util/tools.dart';
import 'package:pet_community/views/sign_login/sign_view.dart';

class SignLoginView extends StatefulWidget {
  final int initialPage;

  const SignLoginView({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  State<SignLoginView> createState() => _SignLoginViewState();
}

class _SignLoginViewState extends State<SignLoginView> {
  late PageController pageC;

  @override
  void initState() {
    pageC = PageController(initialPage: widget.initialPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        children: [
          SignView(),
          Text("ads"),
        ],
      ),
    );
  }
}
