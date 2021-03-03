import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/src/target/target_position.dart';

class LightPaintRect extends CustomPainter {
  final double progress;
  final TargetPosition target;
  final Color colorShadow;
  final double opacityShadow;
  final double offset;
  final double radius;
  final Rect bounds;

  Paint _paintFocus;

  LightPaintRect({
    this.progress,
    this.target,
    this.colorShadow = Colors.black,
    this.opacityShadow = 0.8,
    this.offset = 10,
    this.radius = 10,
    this.bounds,
  }) : assert(opacityShadow >= 0 && opacityShadow <= 1) {
    _paintFocus = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.clear;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawColor(colorShadow.withOpacity(opacityShadow), BlendMode.dstATop);
    var maxSize = size.width > size.height ? size.width : size.height;

    RRect rrect;
    if (bounds == null) {

      double x = -maxSize / 2 * (1 - progress) + target.offset.dx - offset / 2;
      double y = -maxSize / 2 * (1 - progress) + target.offset.dy - offset / 2;
      double w = maxSize * (1 - progress) + target.size.width + offset;
      double h = maxSize * (1 - progress) + target.size.height + offset;
      rrect = RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(radius));

    } else {
      double x = -maxSize / 2 * (1 - progress) + bounds.left - offset / 2;
      double y = -maxSize / 2 * (1 - progress) + bounds.top - offset / 2;
      double w = maxSize * (1 - progress) + bounds.width + offset;
      double h = maxSize * (1 - progress) + bounds.height + offset;
      rrect = RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(radius));
    }

    canvas.drawRRect(rrect, _paintFocus);
    canvas.restore();
  }

  @override
  bool shouldRepaint(LightPaintRect oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
