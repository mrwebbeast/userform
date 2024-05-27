import "package:flutter/material.dart";
import "package:mrwebbeast/core/config/app_assets.dart";
import "package:mrwebbeast/utils/theme/colors.dart";

class NoDataFound extends StatefulWidget {
  const NoDataFound({super.key, this.message, this.heightFactor, this.widthFactor, this.title, this.onTap});

  final String? title;
  final String? message;
  final double? heightFactor;
  final double? widthFactor;
  final GestureTapCallback? onTap;

  @override
  State<NoDataFound> createState() => _NoDataFoundState();
}

class _NoDataFoundState extends State<NoDataFound> {
  late String? title = widget.title;
  late String? message = widget.message;
  late double? heightFactor = widget.heightFactor;
  late double? widthFactor = widget.widthFactor;
  late GestureTapCallback? onTap = widget.onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: heightFactor != null ? size.height * heightFactor! : null,
      width: widthFactor != null ? size.width * widthFactor! : size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.noImage,
              width: 200,
            ),
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  title ?? "Not Found",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            Text(
              message ?? "No Data Found",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.2,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
