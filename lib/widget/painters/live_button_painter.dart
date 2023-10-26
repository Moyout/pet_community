import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:pet_community/util/screen_util.dart';

class LiveButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 2;
    // debugPrint("size-------------------->${size}");
    // Path path = Path();
    // path.moveTo(-size.width / 2, -20);
    // path.conicTo(-size.width / 2, -2 * size.height, size.width, -20, 0.3);
    // canvas.drawPath(path, paint);
    // canvas.drawPath(path, paint);
    // canvas.drawCircle(Offset(size.width / 2, size.height / 2), 30.w, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
