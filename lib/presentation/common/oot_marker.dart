import 'package:flutter/material.dart';

class OOTMarker extends CustomPainter {
  final Color borderColor;
  final Color backgroundColor;
  final double strokeWidth;

  OOTMarker({
    this.borderColor = const Color(0xffFDBC46),
    this.backgroundColor = const Color(0xffFDBC46),
    this.strokeWidth = 2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = getTrianglePath(size.width, size.height);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  Path getTrianglePath(double x, double y) {
    final triangleHeight = y * 0.1;
    return Path()
      ..moveTo(5, 0)
      ..lineTo(x - 5, 0)
      ..cubicTo(x - 5, 0, x, 0, x, 5)
      ..lineTo(x, y - 5)
      ..cubicTo(x, y - 5, x, y, x - 5, y)
      ..lineTo((x / 2) + triangleHeight, y)
      ..lineTo(x / 2, y + (triangleHeight * 2))
      ..lineTo((x / 2) - triangleHeight, y)
      ..lineTo(5, y)
      ..cubicTo(5, y, 0, y, 0, y - 5)
      ..lineTo(0, 5)
      ..cubicTo(0, 5, 0, 0, 5, 0);
  }

  @override
  bool shouldRepaint(OOTMarker oldDelegate) {
    return false;
  }
}
