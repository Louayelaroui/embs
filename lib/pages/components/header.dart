import 'package:flutter/material.dart';
import '../../reposetories/constants.dart';

class Header extends StatelessWidget{
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child:ClipRect(
        child: CustomPaint(
          painter: _HeaderWavesPainter(),
        ),
      ),
    );
  }
}
class _HeaderWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = WelcomeColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    final path = Path();

    path.lineTo(0, size.height * 0.2);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.25, size.width * 0.5, size.height * 0.15);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.10, size.width, size.height * 0.2); // Adjusted here
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
