import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class GradientButton extends StatelessWidget {
  final GradientBorderPainter? _painter;
  final Widget child;
  final VoidCallback? onTap;
  final double? radius;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderWidth;
  final BoxDecoration? decoration;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final List<BoxShadow>? boxShadow;

  GradientButton({
    super.key,
    required this.child,
    this.onTap,
    Gradient? gradient,
    this.borderWidth,
    this.radius,
    this.padding,
    this.margin,
    this.decoration,
    this.backgroundColor,
    this.backgroundGradient,
    this.boxShadow,
    this.height,
    this.width,
  }) : _painter = gradient != null
            ? GradientBorderPainter(
                strokeWidth: borderWidth ?? 1,
                radius: radius ?? 12,
                gradient: gradient,
              )
            : null;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      borderRadius: buildBorderRadius(),
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Container(
        margin: margin ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          color: backgroundGradient == null ? (backgroundColor ?? Colors.transparent) : null,
          gradient: backgroundGradient,
          borderRadius: buildBorderRadius(),
          boxShadow: boxShadow,
        ),
        child: CustomPaint(
          painter: _painter,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            child: Container(
              height: height,
              width: width,
              decoration: decoration,
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius buildBorderRadius() => BorderRadius.circular(radius ?? 12);
}

class DemoBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

class GradientBorderPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  GradientBorderPainter({required this.strokeWidth, required this.radius, required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect =
        Rect.fromLTWH(strokeWidth, strokeWidth, size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
