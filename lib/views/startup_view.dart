import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/init_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';

class StartUpView extends StatefulWidget {
  static const String routeName = 'StartUpView';

  const StartUpView({Key? key}) : super(key: key);

  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  @override
  void initState() {
    context.read<NavViewModel>().checkNet();
    context.read<StartUpViewModel>().initViewModel(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StartUpViewModel state = context.read<StartUpViewModel>();
    context.read<InitAppViewModel>().appInitSetting();

    return Scaffold(
      body: SizedBox(
        width: AppUtils.getWidth(),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child:Image.asset(
                "assets/images/launch_images/pet${state.random}.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.w, right: 15.w),
              alignment: Alignment.bottomRight,
              child: context.watch<StartUpViewModel>().seconds == 0
                  ? const SizedBox()
                  : RawChip(
                      backgroundColor: Colors.transparent,
                      label: Text(
                        "跳过${state.seconds}",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      onPressed: () => state.pushNewPage(context),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
