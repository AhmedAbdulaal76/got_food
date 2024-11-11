import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(

      title: 'Sign Up to Got Food?',
      body: Container(color: ThemeColors.primaryColorBright,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Create an Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ThemeColors.primaryColorDark),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                labelText: 'Username',
                hintText: 'Need_Grades321',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                labelText: 'Email',
                hintText: 'Team9@Fullmark.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                labelText: 'Password',
                hintText: '**********',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                labelText: 'Confirm Password',
                hintText: '**********',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: ThemeColors.primaryColorDark),
              onPressed: () {},
              child: Text('Register'),
            ),
            SizedBox(height: 10),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  children: [
                    TextSpan(
                      text: 'Log in.',
                      style: TextStyle(
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
    );
  }
}
