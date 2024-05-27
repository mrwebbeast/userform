import "package:flutter/material.dart";
import "package:mrwebbeast/utils/functions/app_functions.dart";


Future<void> showBanner({
  required String text,
  Color? color,
  Color? textColor,
  IconData? icon,
  Duration? duration,
}) async {
  BuildContext? context = getContext();
  if (context != null) {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentMaterialBanner();
    scaffoldMessenger.showMaterialBanner(
      MaterialBanner(
        backgroundColor: color,
        leading: const Icon(Icons.error, color: Colors.white),
        content: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          ElevatedButton(
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white)),
              onPressed: () {
                scaffoldMessenger.hideCurrentMaterialBanner();
              },
              child: const Text(
                "Ok",
                style: TextStyle(
                  color: Colors.blue,
                ),
              )),
        ],
      ),
    );
    Future.delayed(const Duration(milliseconds: 2000)).then(
      (value) => scaffoldMessenger.hideCurrentMaterialBanner(),
    );
  }
}
