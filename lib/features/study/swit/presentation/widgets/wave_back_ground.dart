import 'dart:math' as math;
import 'package:flutter/material.dart';

class WaveBackground extends StatelessWidget {
  final String? topImagePath; // 상단 이미지 경로 (옵션)
  final Color? topColor; // 상단 배경색
  final Color bottomColor; // 하단 배경색
  final double waveHeight; // 물결의 높낮이
  final double frequency; // 물결의 빈도
  final double dividerPosition; // 앱에서의 높이

  const WaveBackground({
    super.key,
    this.topImagePath,
    this.topColor,
    this.bottomColor = Colors.transparent,
    this.waveHeight = 20.0,
    this.frequency = 0.5,
    this.dividerPosition = 0.6,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 하단 배경
        Container(
          color: bottomColor,
        ),
        // 상단 물결 배경
        ClipPath(
          clipper: WaveClipper(
            waveHeight: waveHeight,
            frequency: frequency,
            dividerPosition: dividerPosition,
          ),
          child: Container(
            decoration: BoxDecoration(
              // color: topColor,
              image: topImagePath != null
                  ? DecorationImage(
                image: AssetImage(topImagePath!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double waveHeight;
  final double frequency;
  final double dividerPosition;

  WaveClipper({
    required this.waveHeight,
    required this.frequency,
    required this.dividerPosition,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final dividingHeight = size.height * dividerPosition; // 위치 계산

    // 시작점은 좌측 상단
    path.lineTo(0, 0);
    path.lineTo(0, dividingHeight - waveHeight);

    // 물결 그리기
    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
          i,
          dividingHeight - waveHeight +
              math.sin((i * frequency) * math.pi / 180) * waveHeight
      );
    }

    // 나머지 영역을 닫아줌
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}