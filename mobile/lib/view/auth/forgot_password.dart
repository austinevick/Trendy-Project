import 'package:client/view/auth/header_text_widget.dart';
import 'package:client/view/auth/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../common/utils.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderTextWidget(
              title: 'Forgot Password',
              desc: 'Enter your email to reset your password',
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
                      controller: email,
                      textCapitalization: TextCapitalization.none,
                      hintText: 'Email',
                      validator: (value) =>
                          value!.isEmpty ? 'Field is required' : null,
                    ),
                    const SizedBox(height: 50),
                    CustomButton(
                      radius: 12,
                      color: primaryLightColor,
                      onPressed: () {
                        showMaterialModalBottomSheet(
                            context: context,
                            builder: (ctx) =>
                                const ForgotPasswordBottomSheet());
                        FocusScope.of(context).unfocus();
                        if (formkey.currentState!.validate()) {
                          ////
                        }
                      },
                      text: 'Continue',
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

class ForgotPasswordBottomSheet extends StatelessWidget {
  const ForgotPasswordBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Check your email',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 25),
          const Text(
            'We have sent an instruction to your email to reset your password',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          CustomButton(
            radius: 12,
            text: 'Done',
            color: darkBlueColor,
            onPressed: () => push(const VerifyOTP()),
          )
        ],
      ),
    );
  }
}
