import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/models/category.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/other/slideshow.dart';
import 'package:got_food/features/home/home-view/homeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:got_food/features/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../common/providers/bottomNavigationProvider.dart';
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
    final viewModel = Provider.of<HomeViewModel>(context);
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);

    List<Category> categories = viewModel.categories;

    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Slideshow with categories
            CircularPageView(
              imageUrls: categories.map((category) => category.imageUrl).toList(),
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
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Email',
                            icon: const Icon(Icons.email),
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
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Password',
                            icon: const Icon(Icons.lock),
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
                            style: const TextStyle(color: ThemeColors.warningColor),
                          ),
                        // Login Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeColors.primaryColorDark,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                // Attempt Login
                                final res = await authService.signInWithPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                // Success
                                loginViewModel.toggleLoginFlag();
                                bottomNavigationProvider.navigateTo(context, 0);
                                print('Sign-In successful! User: ${res.user}');
                              } on AuthException catch (_) {
                                // Login Failed
                                setState(() {
                                  _errorMessage = 'Incorrect credentials';
                                });
                              }
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Sign-Up Link
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Don't have an account yet? ",
                              style: const TextStyle(color: Colors.black, fontSize: 18),
                              children: [
                                TextSpan(
                                  text: 'Sign up!',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: ThemeColors.primaryColorDark,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacementNamed(context, '/signup');
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
      title: 'Login to Your Account',
    );
  }
}
