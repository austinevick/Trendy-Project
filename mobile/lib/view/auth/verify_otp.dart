import 'package:client/view/auth/header_text_widget.dart';
import 'package:client/view/auth/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../common/utils.dart';
import '../widget/custom_button.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({super.key});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const HeaderTextWidget(
                  title: 'OTP Verification',
                  desc:
                      'Enter the code sent to your email to reset your password',
                  icon: BackButton(color: Colors.white),
                ),
                const SizedBox(height: 25),
                Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Pinput(
                          onCompleted: (pin) => print(pin),
                          defaultPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        CustomButton(
                          radius: 12,
                          color: primaryLightColor,
                          onPressed: () {
                            push(const ResetPassword());
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
          const Spacer(),
          CustomButton(
            height: 40,
            onPressed: () => {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Didn\'t receive code', style: TextStyle()),
                SizedBox(width: 4),
                Text('Resend',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: primaryLightColor))
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
