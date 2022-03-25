import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  @override
  void initState() {
    context.read<StartUpViewModel>().initViewModel(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StartUpViewModel state = context.read<StartUpViewModel>();
    return Scaffold(
      body: Container(
        width: AppUtils.getWidth(),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 0,
              child: Image.network(
                "https://bing.ioliu.cn/v1/rand",
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress?.cumulativeBytesLoaded != loadingProgress?.expectedTotalBytes) {
                    return Image.memory(
                      context.watch<StartUpViewModel>().bytes,
                      fit: BoxFit.fitWidth,
                    );
                  }
                  return child;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.w, right: 25.w),
              alignment: Alignment.bottomRight,
              child: context.watch<StartUpViewModel>().seconds == 0
                  ? const SizedBox()
                  : RawChip(
                      backgroundColor: Colors.transparent,
                      label: Consumer<StartUpViewModel>(
                        builder: (_, StartUpViewModel stModel, __) {
                          return Text(
                            "跳过${stModel.seconds.toString()}",
                            style: TextStyle(fontSize: 14.sp),
                          );
                        },
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
