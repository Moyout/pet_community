import 'package:pet_community/util/tools.dart';
import 'package:pet_community/views/test_view.dart';

class LiveView extends StatefulWidget {
  static const String routeName = "LiveView";

  const LiveView({super.key});

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> with TickerProviderStateMixin {
  late AnimationController ac;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    initAnimation(this);
  }

  initAnimation(TickerProvider tp) {
    ac = AnimationController(vsync: tp, duration: const Duration(milliseconds: 600));
    animation = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.bounceOut)).animate(ac);
    ac.forward();
    ac.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.pushNamed(context, TestView.routeName),
      child: Scaffold(
        appBar: AppBar(title: const Text("LIVE")),
        body: Stack(
          children: [
            ListView(
              children: [],
            ),
            Positioned(
              right: 25.w,
              bottom: 80.w,
              child: Transform.scale(
                scale: animation.value,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, TestView.routeName),
                  style: TextButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: ThemeUtil.reversePrimaryColor(context),
                    padding: EdgeInsets.all(15.w),
                  ),
                  child: const Icon(Icons.live_tv),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    debugPrint("dispose--------------------> {dispose}");
    ac.dispose();
    super.dispose();
  }
}
