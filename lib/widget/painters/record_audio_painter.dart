
import 'package:pet_community/util/tools.dart';

class LCPainter extends CustomPainter {
  final double amplitude;
  final int number;

  LCPainter({this.amplitude = 100.0, this.number = 20});

  @override
  void paint(Canvas canvas, Size size) {
    var centerY = 0.0;
    var width = size.width / number;

    for (var a = 0; a < 4; a++) {
      var path = Path();
      path.moveTo(0.0, centerY);
      var i = 0;
      while (i < number) {
        path.cubicTo((width * i).clamp(0, size.width), centerY, (width * (i + 1)).clamp(0, size.width),
            centerY + amplitude - a * (30), (width * (i + 2)).clamp(0, size.width).toDouble(), centerY);
        path.cubicTo((width * (i + 2)).clamp(0, size.width), centerY, (width * (i + 3)).clamp(0, size.width),
            centerY - amplitude + a * (30), (width * (i + 4)).clamp(0, size.width), centerY);
        i = i + 4;
      }
      // canvas.drawColor(ThemeUtil.scaffoldColor(AppUtils.getContext()), BlendMode.color);
      canvas.drawPath(
        path,
        Paint()
          ..color = a == 0 ? Colors.blueAccent : Colors.transparent
          ..strokeWidth = a == 0 ? 3.0 : 2.0
          ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5)
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
