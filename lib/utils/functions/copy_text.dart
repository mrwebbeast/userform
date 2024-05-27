import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:mrwebbeast/utils/functions/show_snack_bar.dart";
import "package:mrwebbeast/utils/theme/colors.dart";

Future<void> copyText({
  required BuildContext context,
  required String textToCopy,
  required String message,
  Color? color,
  Color? textColor,
}) async {
  Clipboard.setData(ClipboardData(text: textToCopy));
  showSnackBar( text: message, color: color ?? primaryColor);
}