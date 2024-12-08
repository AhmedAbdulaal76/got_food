import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/common/widgets/buttons/customButton.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/other/slideshow.dart';
import 'package:got_food/features/auth/auth_service.dart';
import 'package:provider/provider.dart';

import '../login_viewModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    loginViewModel.context = context;

    return CustomScaffold(
      title: 'Login to Your Account',
      showBottomNav: false,
      actionIcon: const Icon(
        Icons.next_plan_rounded,
        size: 36,
        color: Colors.white,
      ),
      actionFunc: () => Navigator.pushReplacementNamed(context, '/home'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CircularPageView(
              imageUrls: [
                'lib/common/assets/slideshow_images/breakfast.jpg',
                'lib/common/assets/slideshow_images/dessert.jpg',
                'lib/common/assets/slideshow_images/dinner.jpg',
                'lib/common/assets/slideshow_images/lunch.jpg'
              ],
              size: 350,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  const Text(
                    "Get Cookin'",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: ThemeColors.primaryColorDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email Input
                        TextFormField(
                          onTapOutside: (e) {
                            FocusScope.of(context).unfocus();
                          },
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email',
                            icon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        // Password Input
                        TextFormField(
                          onTapOutside: (e) {
                            FocusScope.of(context).unfocus();
                          },
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: 'Password',
                            icon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        // Error Message
                        if (_errorMessage != null)
                          Text(
                            _errorMessage!,
                            style: const TextStyle(
                                color: ThemeColors.warningColor),
                          ),
                        const SizedBox(height: 16),
                        // Login Button
                        CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Attempt Login
                              loginViewModel.signInWithPaswsword(
                                _emailController.text,
                                _passwordController.text,
                              );
                            }
                          },
                          isLoading: loginViewModel.isLoading,
                          label: 'Login',
                        ),
                        const SizedBox(height: 18),
                        // Sign-Up Link
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Don't have an account yet? ",
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: [
                                TextSpan(
                                  text: 'Sign up!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacementNamed(
                                          context, '/signup');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Forgot your password? ",
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: [
                                TextSpan(
                                  text: 'Click here!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacementNamed(
                                          context, '/forgot');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
