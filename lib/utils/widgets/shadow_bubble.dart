import "package:flutter/material.dart";

import "package:mrwebbeast/utils/theme/shadows.dart";

class ShadowBubble extends StatelessWidget {
  const ShadowBubble({super.key, required this.radius});
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: primaryBubbleShadow(radius: radius),
      ),
    );
  }
}
