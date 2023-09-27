import 'package:client/view/auth/header_text_widget.dart';
import 'package:flutter/material.dart';

import '../../common/utils.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formkey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirmPass = TextEditingController();

  bool obscureText = true;
  void get onIconToggle => setState(() => obscureText = !obscureText);
  IconData get icon => !obscureText ? Icons.visibility : Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderTextWidget(
              title: 'Reset Password',
              desc: 'Enter your new password',
              icon: BackButton(color: Colors.white),
            ),
            const SizedBox(height: 25),
            Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    CustomTextfield(
                        controller: password,
                        hintText: 'Password',
                        validator: (value) =>
                            value!.isEmpty ? 'Field is required' : null,
                        obscureText: obscureText,
                        suffixIcon: IconButton(
                          onPressed: () => onIconToggle,
                          icon: Icon(icon, color: primaryLightColor),
                        )),
                    const SizedBox(height: 16),
                    CustomTextfield(
                        controller: confirmPass,
                        hintText: 'Confirm Password',
                        validator: (value) => !value!.contains(password.text)
                            ? 'Password does not match'
                            : null,
                        obscureText: obscureText,
                        suffixIcon: IconButton(
                          onPressed: () => onIconToggle,
                          icon: Icon(icon, color: primaryLightColor),
                        )),
                    const SizedBox(height: 50),
                    CustomButton(
                      radius: 12,
                      color: primaryLightColor,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (formkey.currentState!.validate()) {
                          ////
                        }
                      },
                      text: 'Reset Password',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
