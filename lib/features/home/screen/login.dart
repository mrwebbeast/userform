import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";

import "package:mrwebbeast/core/routes/route_configs.dart";
import "package:mrwebbeast/utils/formatters/validators.dart";

import "package:mrwebbeast/utils/functions/show_snack_bar.dart";
import "package:mrwebbeast/utils/widgets/button/app_button.dart";
import "package:mrwebbeast/utils/widgets/common/app_text_field.dart";
import "package:mrwebbeast/utils/widgets/shadow_bubble.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Form(
            key: signInFormKey,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24, size.height * 0.14, 24, 8),
                  child: const Text(
                    "Welcome to Flutter",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 0, 36, 12),
                  child: Text(
                    "Enter you details to sign up and use our app",
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                AppTextField(
                  controller: nameCtrl,
                  autofocus: true,
                  prefixIcon: prefixIcon(icon: Icons.person_outline_rounded),
                  validator: (val) {
                    return Validator.fullNameValidator(val);
                  },
                  labelText: "Name",
                  hintText: "Name",
                  autofillHints: const [AutofillHints.name],
                  margin: const EdgeInsets.only(left: 24, right: 24, top: 24),
                ),
                AppTextField(
                  controller: userNameCtrl,
                  autofocus: true,
                  prefixIcon: prefixIcon(icon: CupertinoIcons.perspective),
                  validator: (val) {
                    return Validator.userNameValidator(val);
                  },
                  labelText: "username",
                  hintText: "username",
                  autofillHints: const [AutofillHints.username],
                  margin: const EdgeInsets.only(left: 24, right: 24, top: 24),
                ),
                AppTextField(
                  controller: emailCtrl,
                  autofocus: true,
                  prefixIcon: prefixIcon(icon: Icons.email_outlined),
                  validator: (val) {
                    return Validator.emailValidator(val);
                  },
                  labelText: "Email",
                  hintText: "Enter Email",
                  autofillHints: const [AutofillHints.email],
                  margin: const EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 14),
                ),
                AppTextField(
                  controller: phoneCtrl,
                  autofocus: true,
                  labelText: "Phone Number",
                  keyboardType: TextInputType.phone,
                  prefixIcon: prefixIcon(icon: Icons.call),
                  limit: 10,
                  validator: (val) {
                    return Validator.numberValidator(val);
                  },
                  hintText: "Enter Phone Number",
                  autofillHints: const [AutofillHints.telephoneNumberNational],
                  margin: const EdgeInsets.only(left: 24, right: 24, bottom: 14),
                ),
                AppTextField(
                  controller: passwordCtrl,
                  autofocus: true,
                  labelText: "Password",
                  keyboardType: TextInputType.text,
                  prefixIcon: prefixIcon(icon: Icons.lock_open),
                  validator: (val) {
                    return Validator.passwordValidator(val);
                  },
                  hintText: "Enter Password",
                  autofillHints: const [AutofillHints.password],
                  margin: const EdgeInsets.only(left: 24, right: 24, bottom: 14),
                ),
                AppButton(
                  text: "Skip",
                  backgroundColor: Colors.transparent,
                  borderColor: context.colorScheme.primary,
                  splashEffect: true,
                  mainAxisAlignment: MainAxisAlignment.center,
                  onPressed: () {
                    context.pushReplacement(Routes.homeScreen);
                  },
                  margin: const EdgeInsets.fromLTRB(36, 36, 36, 8),
                ),
                AppButton(
                  text: "Register",
                  backgroundColor: context.colorScheme.primary,
                  borderColor: context.colorScheme.primary,
                  mainAxisAlignment: MainAxisAlignment.center,
                  onPressed: () {
                    if (signInFormKey.currentState!.validate()) {
                      showSnackBar(text: "This is Just a Demo");
                    }
                  },
                  margin: const EdgeInsets.fromLTRB(36, 8, 36, 8),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.1,
            left: -30,
            child: const ShadowBubble(radius: 80),
          ),
          Positioned(
            bottom: size.height * 0.1,
            right: -10,
            child: const ShadowBubble(radius: 60),
          ),
        ],
      ),
    );
  }

  Padding prefixIcon({required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          const SizedBox(
            height: 20,
            child: VerticalDivider(
              width: 1,
              thickness: 1.1,
            ),
          )
        ],
      ),
    );
  }
}
