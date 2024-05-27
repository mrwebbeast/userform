import "package:flutter/gestures.dart";
import "package:flutter/material.dart";

class TermsAndConditionsLabel extends StatelessWidget {
  const TermsAndConditionsLabel({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle =
        TextStyle(fontSize: 10, color: Colors.grey.shade400, fontWeight: FontWeight.w500);
    TextStyle linkStyle = TextStyle(
        fontSize: 10,
        color: Colors.grey.shade400,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline);
    return RichText(
      maxLines: 4,
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          const TextSpan(text: "I agree to accept your "),
          TextSpan(
              text: "Privacy Policy ",
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint("Privacy Policy");
                }),
          const TextSpan(text: "and  "),
          TextSpan(
              text: "Terms of Service ",
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint("Terms of Service");
                }),
        ],
      ),
    );
  }
}
