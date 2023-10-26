import 'dart:math';

import 'package:pet_community/util/tools.dart';

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
              height: 300,
              width: 300,
              color: Colors.brown,
              child: CustomPaint(
                painter: CustomTestPainter(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTestPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    debugPrint("size-------------------->${size}");

    Paint paint = Paint()
      ..color = Colors.blueGrey
      // ..isAntiAlias = true
      // ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    Paint helpPaint = Paint()
      ..color = Colors.pink.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    {
      var dashWidth = 6;
      var dashSpace = 6;
      double startX = 0;
      double startY = 0;
      final space = (dashSpace + dashWidth);
      while (startX < size.width) {
        canvas.drawLine(Offset(startX, size.height / 2), Offset(startX + dashWidth, size.height / 2), helpPaint);
        startX += space;
      }
      while (startY < size.height) {
        canvas.drawLine(Offset(size.width / 2, startY), Offset(size.width / 2, startY + dashWidth), helpPaint);
        startY += space;
      }
      canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 4, helpPaint);
    }
    double padding = 20;
    Path path = Path();

    ///左上边四分之一贝塞尔曲线

    path.moveTo(0, size.height / 2 - padding);
    // path.quadraticBezierTo(size.width / 4, size.height / 2, size.width / 2, size.height / 4);
    path.cubicTo(
      size.width / 4,
      size.height / 2 - padding,
      size.width / 4,
      size.height / 4 - padding,
      size.width / 2,
      size.height / 4 - padding,
    );

    ///右上边四分之一贝塞尔曲线
    path.moveTo(size.width / 2, size.height / 4 - padding);
    path.cubicTo(
      size.width * (3 / 4),
      size.height / 4 - padding,
      size.width * (3 / 4),
      size.height / 2 - padding,
      size.width,
      size.height / 2 - padding,
    );

    ///左下边四分之一贝塞尔曲线
    path.moveTo(0, size.height / 2 + padding);
    path.cubicTo(
      size.width / 4,
      size.height / 2 + padding,
      size.width / 4,
      size.height * (3 / 4) + padding,
      size.width / 2,
      size.height * (3 / 4) + padding,
    );

    ///右下边四分之一贝塞尔曲线
    path.moveTo(size.width / 2, size.height * (3 / 4) + padding);
    path.cubicTo(
      size.width * (3 / 4),
      size.height * (3 / 4) + padding,
      size.width * (3 / 4),
      size.height / 2 + padding,
      size.width,
      size.height / 2 + padding,
    );

    canvas.drawPath(path, paint);
    // canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), helpPaint);

    // canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), helpPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
