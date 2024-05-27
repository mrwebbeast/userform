import "package:flutter/material.dart";

import "package:shimmer/shimmer.dart";

import "package:mrwebbeast/utils/theme/shadows.dart";

class ShimmerCard extends StatelessWidget {
  const ShimmerCard(
      {super.key,
      this.backgroundColor,
      this.highlightColor,
      this.height,
      this.width,
      this.borderRadius,
      this.margin,
      this.duration,
      this.direction,
      this.gradient});

  final Color? backgroundColor;
  final Color? highlightColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final EdgeInsets? margin;
  final Duration? duration;
  final ShimmerDirection? direction;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: backgroundColor ?? Colors.grey.shade200,
          highlightColor: highlightColor ?? Colors.white,
          direction: direction ?? ShimmerDirection.ltr,
          period: duration ?? const Duration(milliseconds: 1800),
          child: Container(
              margin: margin ?? const EdgeInsets.only(left: 16, top: 6),
              height: height ?? 16,
              width: width ?? 200,
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.grey.shade200,
                borderRadius: BorderRadius.circular(borderRadius ?? 4),
              )),
        )
      ],
    );
  }
}

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key, this.itemCount});

  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: itemCount ?? 3,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
          child: Container(
            width: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: primaryBoxShadow(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                      child: ShimmerCard(
                        height: 125,
                        width: 125,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ShimmerCard(
                            height: 12,
                            width: size.width * 0.3,
                            margin: const EdgeInsets.only(left: 3, top: 2),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
                          child: ShimmerCard(
                            height: 12,
                            width: size.width * 0.2,
                            margin: const EdgeInsets.only(left: 3, top: 2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ShimmerCard(
                  height: 16,
                  width: size.width * 0.34,
                  margin: const EdgeInsets.only(left: 8, top: 2, right: 4, bottom: 12),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class BannerCardSkeleton extends StatelessWidget {
  const BannerCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: primaryBoxShadow(context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [ShimmerCard(height: 14, width: size.width * 0.75)],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ShimmerCard(height: 14, width: size.width * 0.25),
          ),
          ShimmerCard(height: 14, width: size.width * 0.3),
        ],
      ),
    );
  }
}
