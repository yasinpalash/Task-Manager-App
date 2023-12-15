import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/Controller/Login_Controller.dart';
import 'package:taskmanager/ui/Screens/sign-up-screen.dart';
import 'package:taskmanager/ui/Screens/verify-with-email.dart';
import '../utils/text-styles.dart';
import '../widgets/app-elevated-button.dart';
import '../widgets/app-text-button.dart';
import '../widgets/app-text-form-field.dart';
import '../widgets/screen-Background-images.dart';
import 'main-bottom-navbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final LoginController _loginController = Get.find<LoginController>();

  Future<void> login() async {
    final result = await _loginController.login(
        emailTextController.text.trim(), passwordTextController.text.trim());
    if (result) {
      Get.offAll(const MainBottomNavBar());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get Started With',
                style: screenTitleTextStyle,
              ),
              const SizedBox(
                height: 24,
              ),
              AppTextFormFieldWidget(
                hintText: 'Email',
                controller: emailTextController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter your valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              AppTextFormFieldWidget(
                obscureText: true,
                hintText: 'Password',
                controller: passwordTextController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter your valid password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              if (_loginController.LoginInProgress)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<LoginController>(
                    builder: (loginController) {
                      return Visibility(
                        visible: loginController.LoginInProgress==false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: AppElevatedButton(
                          child: const Icon(Icons.arrow_forward_ios),
                          ontap: () async {
                            if (formKey.currentState!.validate()) {
                              login();
                            }
                          },
                        ),
                      );
                    }
                  ),
                ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifyWithEmail()));
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              AppTextButton(
                text1: "Don't Have an Account?",
                text2: 'Sign up',
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
