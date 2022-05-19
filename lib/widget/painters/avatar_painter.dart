import 'package:pet_community/util/tools.dart';

class AvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = false
      ..strokeWidth = 30.0
      ..color = Colors.red;
    print(size);
    canvas.drawLine(Offset(50.0, -150.0), Offset(100.0, 50.0), paint..strokeCap);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
