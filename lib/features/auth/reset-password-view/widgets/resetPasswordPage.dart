import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/common/widgets/buttons/customButton.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/features/auth/auth_service.dart';
import 'package:got_food/features/auth/login-view/login_viewModel.dart';
import 'package:got_food/features/auth/reset-password-view/reset_viewModel.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final resetViewModel = Provider.of<ResetViewModel>(context);
    final loginViewModel = Provider.of<LoginViewModel>(context);

    resetViewModel.context = context;
    loginViewModel.context = context;

    return CustomScaffold(
      title: "Reset Password",
      showBottomNav: false,
      showBackButton: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // New Password Input
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter your new password',
                  icon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Confirm Password Input
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter your new password',
                  icon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: ThemeColors.warningColor),
                ),
              const SizedBox(height: 16),
              CustomButton(
                onPressed: () async {
                  // Validate the form
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      await resetViewModel.resetPassword(
                          password: _newPasswordController.text);
                      Navigator.pushReplacementNamed(context, "/home");
                    } catch (e) {
                      setState(() {
                        _errorMessage = e.toString();
                      });
                    }
                  }
                },
                label: 'Reset Password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
