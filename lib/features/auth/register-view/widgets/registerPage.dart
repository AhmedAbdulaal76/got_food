import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/common/widgets/buttons/customButton.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/features/auth/auth_service.dart';
import 'package:got_food/features/auth/register-view/register_viewModel.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final BottomNavigationProvider bottomNavigationProvider =
    //     Provider.of<BottomNavigationProvider>(context);
    // final LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    final RegisterViewModel registerViewModel =
        Provider.of<RegisterViewModel>(context);

    registerViewModel.context = context;

    return CustomScaffold(
      title: 'Sign Up to Got Food?',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.primaryColorDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        labelText: 'Username',
                        hintText: 'Need_Grades321',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your username';
                        } else if (value.length < 8) {
                          return 'Username length must be at least 8';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        labelText: 'Email',
                        hintText: 'Team9@Fullmark.com',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your email';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                            .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        labelText: 'Password',
                        hintText: '**********',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        } else if (value.length < 8) {
                          return 'Password length must be at least 8';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordConfirmController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        labelText: 'Confirm Password',
                        hintText: '**********',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          registerViewModel.signUp(
                              email: _emailController.text,
                              password: _passwordConfirmController.text,
                              username: _usernameController.text);
                        }
                      },
                      isLoading: registerViewModel.isLoading,
                      label: 'Register',
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(
                              text: 'Log in.',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: ThemeColors.primaryColorDark,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/login');
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
      ),
    );
  }
}
