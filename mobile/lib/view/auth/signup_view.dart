import 'package:client/common/utils.dart';
import 'package:client/provider/auth_view_provider.dart';
import 'package:client/view/auth/form_validation.dart';
import 'package:client/view/auth/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/auth/register_model.dart';
import '../widget/button_loader.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';
import '../widget/social_button.dart';
import 'header_text_widget.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final formKey = GlobalKey<FormState>();
  final fname = TextEditingController();
  final lname = TextEditingController();
  final email = TextEditingController();
  final profession = TextEditingController();
  final password = TextEditingController();
  final confirmPass = TextEditingController();

  bool obscureText = true;
  void get onIconToggle => setState(() => obscureText = !obscureText);
  IconData get icon => !obscureText ? Icons.visibility : Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final isLoading = ref.watch(authViewModel);
      return LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              width: constraints.maxWidth > kTabletDimension ? 500 : null,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const HeaderTextWidget(
                      title: 'Create Account',
                      desc:
                          'Create account today and join our amazing community',
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          CustomTextfield(
                            controller: fname,
                            hintText: 'First name',
                            validator: (value) =>
                                value!.isEmpty ? 'Field is required' : null,
                          ),
                          const SizedBox(height: 16),
                          CustomTextfield(
                            controller: lname,
                            hintText: 'Last name',
                            validator: (value) =>
                                value!.isEmpty ? 'Field is required' : null,
                          ),
                          const SizedBox(height: 16),
                          CustomTextfield(
                            controller: email,
                            textCapitalization: TextCapitalization.none,
                            hintText: 'Email',
                            validator: (value) => validateEmail(value!),
                          ),
                          const SizedBox(height: 16),
                          CustomTextfield(
                            controller: profession,
                            textCapitalization: TextCapitalization.none,
                            hintText: 'Profession',
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
                          const SizedBox(height: 16),
                          CustomTextfield(
                              controller: confirmPass,
                              hintText: 'Confirm Password',
                              validator: (value) =>
                                  !value!.contains(password.text)
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
                            isLoading: isLoading,
                            color: primaryLightColor,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                final model = RegisterModel(
                                    firstName: fname.text.trim(),
                                    lastName: lname.text.trim(),
                                    email: email.text.trim(),
                                    password: password.text.trim(),
                                    about: '',
                                    imageUrl: '',
                                    followers: [],
                                    following: [],
                                    profession: profession.text.trim());
                                ref
                                    .read(authViewModel.notifier)
                                    .register(model);
                              }
                            },
                            child: ButtonLoader(
                              isLoading: isLoading,
                              text: 'Create Account',
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
                            onPressed: () => push(const SigninView()),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Have an account?', style: TextStyle()),
                                SizedBox(width: 4),
                                Text('Sign In',
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
    });
  }
}
