import "dart:math";

import "package:flutter/material.dart";
import "package:flutter/services.dart";

class MonthYearInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newText = StringBuffer();
    int selectionIndex = newValue.selection.end;

    // Remove any non-digits from the input
    String cleanedText = newValue.text.replaceAll(RegExp(r"[^0-9]"), "");

    // Handle MM
    if (cleanedText.length >= 2) {
      newText.write(cleanedText.substring(0, 2));
      if (selectionIndex >= 2) selectionIndex -= 1; // Adjust for removed characters
    } else {
      newText.write(cleanedText);
    }

    // Add separator
    if (cleanedText.length >= 2) {
      newText.write("/");
      selectionIndex += 1; // Move cursor after the slash
    }

    // Handle YYYY
    if (cleanedText.length > 2) {
      newText.write(cleanedText.substring(2, min(6, cleanedText.length)));
      if (selectionIndex >= 3) {
        selectionIndex += 1;
      }
    }

    final TextSelection newSelection = TextSelection.fromPosition(
      TextPosition(offset: selectionIndex),
    );

    return TextEditingValue(
      text: newText.toString(),
      selection: newSelection,
    );
  }
}

class CardExpiry {
  int month;
  int year;

  CardExpiry(this.month, this.year);

  static CardExpiry? fromFormattedString(String? formattedString) {
    try {
      if (formattedString?.isEmpty == true) {
        return null;
      }

      List<String> parts = formattedString!.split("/");

      if (parts.length != 2) {
        return null;
      }

      int month = int.parse(parts[0]);
      int year = int.parse(parts[1]);

      return CardExpiry(month, year);
    } catch (e) {
      // Handle parsing errors or invalid format
      debugPrint("$e");
      return null;
    }
  }
}
