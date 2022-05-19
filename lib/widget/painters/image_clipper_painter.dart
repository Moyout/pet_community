import 'package:pet_community/util/tools.dart';
import 'dart:ui' as ui;

class ImageClipper extends CustomPainter {
  final ui.Image image;
  final double left;
  final double top;
  ImageClipper(this.image, this.left, this.top);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Rect src = Rect.fromLTWH(left, top, 30.w, 30.w);

    Rect targetRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(image, src, targetRect, paint);

    ///从iamge
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
