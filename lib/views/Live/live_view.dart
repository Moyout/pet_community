import 'package:pet_community/util/tools.dart';
import 'package:pet_community/views/test_view.dart';

class LiveView extends StatefulWidget {
  static const String routeName = "LiveView";

  const LiveView({super.key});

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, TestView.routeName),
      child: Scaffold(
        appBar: AppBar(title: const Text("LIVE")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
