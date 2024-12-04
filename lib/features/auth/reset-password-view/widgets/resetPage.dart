import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/common/widgets/buttons/customButton.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/features/auth/auth_service.dart';
import 'package:got_food/features/auth/login-view/login_viewModel.dart';
import 'package:got_food/features/auth/reset-password-view/reset_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:got_food/common/widgets/other/slideshow.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  bool _isOtpSent = false;
  bool _isOtpVerified = false;

  @override
  Widget build(BuildContext context) {
    final resetViewModel = Provider.of<ResetViewModel>(context);
    final loginViewModel = Provider.of<LoginViewModel>(context);

    resetViewModel.context = context;
    loginViewModel.context = context;

    return CustomScaffold(
      title: 'Reset your password',
      showBottomNav: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircularPageView(
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (!_isOtpSent) ...[
                          // Email Input
                          TextFormField(
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
                          const SizedBox(height: 18),
                          // Error Message
                          if (_errorMessage != null)
                            Text(
                              _errorMessage!,
                              style: TextStyle(color: ThemeColors.warningColor),
                            ),
                          const SizedBox(height: 16),
                          CustomButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                authService
                                    .sendOtp(email: _emailController.text)
                                    .then((_) {
                                  setState(() {
                                    _isOtpSent =
                                        true; // OTP sent, show OTP form
                                  });
                                }).catchError((e) {
                                  setState(() {
                                    _errorMessage = e.toString();
                                  });
                                });
                              }
                            },
                            isLoading: resetViewModel.isLoading,
                            label: 'Send Otp',
                          ),
                          const SizedBox(height: 12),
                        ],
                        if (_isOtpSent && !_isOtpVerified) ...[
                          // OTP Input
                          TextFormField(
                            controller: _otpController,
                            decoration: const InputDecoration(
                              labelText: 'Otp',
                              hintText:
                                  'Otp has been sent to email if the email is valid',
                              icon: Icon(Icons.message),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the otp';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          // Error Message
                          if (_errorMessage != null)
                            Text(
                              _errorMessage!,
                              style: TextStyle(color: ThemeColors.warningColor),
                            ),
                          const SizedBox(height: 16),
                          CustomButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                loginViewModel
                                    .signInWithOtp(
                                        email: _emailController.text,
                                        otp: _otpController.text)
                                    .then((result) {
                                  setState(() {
                                    if (result) {
                                      _isOtpVerified =
                                          true; // OTP verified, show password reset form
                                    }
                                  });
                                }).catchError((e) {
                                  setState(() {
                                    _errorMessage = e.toString();
                                  });
                                });
                              }
                            },
                            isLoading: resetViewModel.isLoading,
                            label: 'Verify Otp',
                          ),
                          const SizedBox(height: 12),
                        ],
                        if (_isOtpVerified) ...[
                          // New Password Input
                          TextFormField(
                            controller: _newPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'New Password',
                              hintText: 'Enter new password',
                              icon: Icon(Icons.lock),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a new password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _confirmNewPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Confirm New Password',
                              hintText: 'Confirm New password',
                              icon: Icon(Icons.lock),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a new password';
                              } else if (value != _newPasswordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          // Error Message
                          if (_errorMessage != null)
                            Text(
                              _errorMessage!,
                              style: TextStyle(color: ThemeColors.warningColor),
                            ),
                          const SizedBox(height: 16),
                          CustomButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                resetViewModel
                                    .resetPassword(
                                        password: _newPasswordController.text)
                                    .catchError((e) {
                                  setState(() {
                                    _errorMessage = e.toString();
                                  });
                                });
                              }
                            },
                            isLoading: resetViewModel.isLoading,
                            label: 'Reset Password',
                          ),
                          const SizedBox(height: 12),
                        ],
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
