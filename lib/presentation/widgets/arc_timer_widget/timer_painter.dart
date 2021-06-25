import 'package:intellimath_replica/presentation/core_flutter_packages.dart';
import 'dart:math' as math;

class TimerPainter extends CustomPainter {
  TimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
        Offset.zero & size, math.pi * 1.25, -math.pi * 1.5, false, paint);
    paint.color = color;
    final progress = (1 - animation.value) * math.pi * 1.5;
    canvas.drawArc(Offset.zero & size, math.pi * 1.25, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
