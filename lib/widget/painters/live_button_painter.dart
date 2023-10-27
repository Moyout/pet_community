import 'package:flutter/material.dart';
import 'package:pet_community/util/screen_util.dart';

class LiveButtonPainter extends CustomPainter {
  final Color primaryColor;

  LiveButtonPainter({super.repaint, required this.primaryColor});

  @override
  void paint(Canvas canvas, Size size) {
    // debugPrint("size-------------------->${size}");

    Paint paint = Paint()
      ..color = primaryColor
      ..isAntiAlias = true
      ..strokeWidth = 2;

    Paint circlePaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..isAntiAlias = true
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double bezierRegionHeight = 25.w;
    Path path = Path();

    ///画笔开始位置
    path.moveTo(0, size.height / 2 - bezierRegionHeight);

    ///左上边四分之一贝塞尔曲线
    path.cubicTo(
      size.width / 4,
      size.height / 2 - bezierRegionHeight,
      size.width / 4,
      size.height / 4 - bezierRegionHeight,
      size.width / 2,
      size.height / 4 - bezierRegionHeight,
    );

    ///右上边四分之一贝塞尔曲线
    path.cubicTo(
      size.width * (3 / 4),
      size.height / 4 - bezierRegionHeight,
      size.width * (3 / 4),
      size.height / 2 - bezierRegionHeight,
      size.width,
      size.height / 2 - bezierRegionHeight,
    );

    ///右边竖线
    path.lineTo(size.width, size.height / 2 + bezierRegionHeight);

    ///右下边四分之一贝塞尔曲线
    path.cubicTo(
      size.width * (3 / 4),
      size.height / 2 + bezierRegionHeight,
      size.width * (3 / 4),
      size.height * (3 / 4) + bezierRegionHeight,
      size.width / 2,
      size.height * (3 / 4) + bezierRegionHeight,
    );

    ///左下边四分之一贝塞尔曲线
    path.cubicTo(
      size.width / 4,
      size.height * (3 / 4) + bezierRegionHeight,
      size.width / 4,
      size.height / 2 + bezierRegionHeight,
      0,
      size.height / 2 + bezierRegionHeight,
    );

    ///首尾相连
    path.lineTo(0, size.height / 2 - bezierRegionHeight);
    // path.close();

    ///画布绘制路径
    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2 - 5.w, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
