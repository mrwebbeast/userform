import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";

int defaultImageQuality = 50;

Future<File?> pickImage({
  required ImageSource source,
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
  CameraDevice preferredCameraDevice = CameraDevice.rear,
  bool requestFullMetadata = true,
}) async {
  try {
    final xFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: imageQuality ?? defaultImageQuality,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      preferredCameraDevice: preferredCameraDevice,
      requestFullMetadata: requestFullMetadata,
    );
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

class PickImageButton extends StatelessWidget {
  const PickImageButton(
      {super.key, required this.context, required this.text, required this.icon, this.onTap});

  final BuildContext context;
  final String text;
  final IconData icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 4, 16),
        child: Container(
          height: 45,
          constraints: const BoxConstraints(
            minWidth: 150.0,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
            border: Border.all(color: context.colorScheme.primary),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
