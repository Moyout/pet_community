import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/sign_login/sign_login_viewmodel.dart';
import 'package:pet_community/views/sign_login/login_view.dart';
import 'package:pet_community/views/sign_login/sign_view.dart';

class SignLoginView extends StatefulWidget {
  const SignLoginView({Key? key}) : super(key: key);

  @override
  State<SignLoginView> createState() => _SignLoginViewState();
}

class _SignLoginViewState extends State<SignLoginView> {
  @override
  void initState() {
    context.read<SignLoginViewModel>().initViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: context.watch<SignLoginViewModel>().pageC,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          SignView(),
          LoginView(),
        ],
      ),
    );
  }
}
