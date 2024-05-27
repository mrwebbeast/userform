import "package:flutter/material.dart";
import "package:mrwebbeast/utils/theme/colors.dart";

///Gradient

Gradient primaryGradient =  const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    primaryColor,
    secondaryColor,
  ],
  stops: [0.13, 0.76],
);

Gradient inActiveGradient = LinearGradient(
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
  colors: [
    Colors.black,
    const Color(0xff000000),
    Colors.grey.shade600,
  ],
  stops: const [0, 0.42, 1],
);

Gradient blankGradient = const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
  Colors.grey,
  Colors.grey,
], stops: [
  0,
  0.100
]);

Gradient textFieldGradient =  const LinearGradient(
  begin: Alignment.centerRight,
  end: Alignment.centerLeft,
  colors: [
    primaryColor,
    secondaryColor,
  ],
);
