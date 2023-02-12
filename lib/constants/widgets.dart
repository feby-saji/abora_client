import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphismContainer extends StatelessWidget {
  final double blur;
  final double opacity;

  const GlassMorphismContainer({
    super.key,
    required this.blur,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.black54.withOpacity(opacity),
            )));
  }
}
