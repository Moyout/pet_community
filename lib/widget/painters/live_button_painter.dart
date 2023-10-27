import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pet_community/util/screen_util.dart';

class LiveButtonPainter extends CustomPainter {
  final Color primaryColor;
  final double paddingHeight;
  final bool leftSemicircle;
  final bool rightSemicircle;

  LiveButtonPainter({
    super.repaint,
    required this.primaryColor,
    required this.paddingHeight,
    this.leftSemicircle = false,
    this.rightSemicircle = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    debugPrint("size-------------------->${size}");

    Paint paint = Paint()
      ..color = primaryColor
      ..isAntiAlias = true
      ..strokeWidth = 2;

    Paint circlePaint = Paint()
          ..color = Colors.grey
          ..isAntiAlias = true
          ..strokeWidth = 2
        // ..style = PaintingStyle.stroke
        ;

    Rect rect =
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2 - paddingHeight / 2);
    Path semicirclePath = Path();
    Path path = Path();

    if (leftSemicircle) {
      semicirclePath.addArc(rect, 90 * (pi / 180), 180 * (pi / 180));
      canvas.drawPath(semicirclePath, circlePaint);
    } else {
      path.moveTo(size.width / 2, size.height + size.height / 4 + paddingHeight);
      //左贝塞尔曲线
      path.cubicTo(
        size.width / 4,
        size.height + size.height / 4 + paddingHeight,
        size.width / 4,
        size.height + paddingHeight,
        0,
        size.height + paddingHeight,
      );
      path.lineTo(0, -paddingHeight);
      path.cubicTo(
        size.width / 4,
        -paddingHeight,
        size.width / 4,
        -size.height / 4 - paddingHeight,
        size.width / 2,
        -size.height / 4 - paddingHeight,
      );
    }

    if (rightSemicircle) {
      semicirclePath.addArc(rect, 270 * (pi / 180), 180 * (pi / 180));
      canvas.drawPath(semicirclePath, circlePaint);
    } else {
      //右贝塞尔曲线
      path.moveTo(size.width / 2, -size.height / 4 - paddingHeight);
      // path.lineTo(200, 300);
      path.cubicTo(
        size.width * (3 / 4),
        -size.height / 4 - paddingHeight,
        size.width * (3 / 4),
        -paddingHeight,
        size.width,
        -paddingHeight,
      );
      path.lineTo(size.width, size.height + paddingHeight);
      path.cubicTo(
        size.width * (3 / 4),
        size.height + paddingHeight,
        size.width * (3 / 4),
        size.height + size.height / 4 + paddingHeight,
        size.width / 2,
        size.height + size.height / 4 + paddingHeight,
      );

      path.cubicTo(
        size.width * (3 / 4),
        size.height + paddingHeight,
        size.width * (3 / 4),
        size.height + size.height / 4 + paddingHeight,
        size.width / 2,
        size.height + size.height / 4 + paddingHeight,
      );
    }

    canvas.drawPath(path, paint);
    // ///左上边四分之一贝塞尔曲线
    // ///画笔开始位置
    // path.moveTo(0, -paddingHeight);
    // path.cubicTo(
    //   size.width / 4,
    //   -paddingHeight,
    //   size.width / 4,
    //   -size.height / 4 - paddingHeight,
    //   size.width / 2,
    //   -size.height / 4 - paddingHeight,
    // );
    //
    // ///右上边四分之一贝塞尔曲线
    // path.cubicTo(
    //   size.width * (3 / 4),
    //   -size.height / 4 - paddingHeight,
    //   size.width * (3 / 4),
    //   -paddingHeight,
    //   size.width,
    //   -paddingHeight,
    // );
    //
    // ///右边竖线
    // path.lineTo(size.width, size.height + paddingHeight);
    //
    // ///右下边四分之一贝塞尔曲线
    // path.cubicTo(
    //   size.width * (3 / 4),
    //   size.height + paddingHeight,
    //   size.width * (3 / 4),
    //   size.height + size.height / 4 + paddingHeight,
    //   size.width / 2,
    //   size.height + size.height / 4 + paddingHeight,
    // );
    //
    // ///左下边四分之一贝塞尔曲线
    // path.cubicTo(
    //   size.width / 4,
    //   size.height + size.height / 4 + paddingHeight,
    //   size.width / 4,
    //   size.height + paddingHeight,
    //   0,
    //   size.height + paddingHeight,
    // );

    ///首尾相连
    // path.lineTo(0, size.height / 2);
    // path.close();

    ///画布绘制路径
    // canvas.drawPath(path, paint);
    // canvas.drawArc(rect, 90 * (pi / 180), 180 * (pi / 180), false, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
