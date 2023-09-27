import 'package:client/common/utils.dart';
import 'package:client/provider/auth_view_provider.dart';
import 'package:client/view/auth/forgot_password.dart';
import 'package:client/view/auth/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/auth/login_model.dart';
import '../widget/button_loader.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';
import '../widget/social_button.dart';
import 'header_text_widget.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool obscureText = true;
  void get onIconToggle => setState(() => obscureText = !obscureText);
  IconData get icon => !obscureText ? Icons.visibility : Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final isLoading = ref.watch(authViewModel);
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderTextWidget(
                    title: 'Welcome',
                    desc: 'Sign in to your account to continue',
                    icon: BackButton(color: Colors.white),
                  ),
                  const SizedBox(height: 25),
                  Padding(
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
                        const SizedBox(height: 16),
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
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () => push(const ForgotPassword()),
                                child: const Text('Forgot Password?'))),
                        const SizedBox(height: 30),
                        CustomButton(
                          radius: 12,
                          isLoading: isLoading,
                          color: primaryLightColor,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (formkey.currentState!.validate()) {
                              final model = LoginModel(
                                  password: password.text.trim(),
                                  email: email.text.trim());
                              ref.read(authViewModel.notifier).login(model);
                            }
                          },
                          child: ButtonLoader(
                            isLoading: isLoading,
                            text: 'Sign in',
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Or continue with',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SocialButton(
                                image: 'google',
                                text: 'Google',
                                onPressed: () {}),
                            const SizedBox(width: 10),
                            SocialButton(
                                image: 'facebook',
                                text: 'Facebook',
                                onPressed: () {})
                          ],
                        ),
                        const SizedBox(height: 50),
                        CustomButton(
                          height: 40,
                          onPressed: () => push(const SignupView()),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?',
                                  style: TextStyle()),
                              SizedBox(width: 4),
                              Text('Sign Up',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryLightColor))
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
