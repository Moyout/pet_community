import 'dart:math';

import 'package:pet_community/util/tools.dart';
import 'package:pet_community/widget/painters/live_button_painter.dart';

class LiveView extends StatefulWidget {
  static const String routeName = "LiveView";

  const LiveView({super.key});

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LIVE")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 200,
              width: 300,
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.brown,
              child: CustomPaint(
                painter: LiveButtonPainter(
                  paddingHeight: 10,
                  primaryColor: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
