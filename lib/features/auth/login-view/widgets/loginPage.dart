import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/other/slideshow.dart';
import 'package:got_food/features/home/home-view/homeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:got_food/common/models/category.dart';
import 'package:got_food/common/style/themes/themeColors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    List<Category> categories = viewModel.categories;

    return CustomScaffold(
      body: Container(color: ThemeColors.primaryColorBright,
          child:SingleChildScrollView(
        child: Column(
          children: [
            CircularPageView(imageUrls: categories.map((category) => category.imageUrl).toList(), size: 350),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Get Cookin'",
                    style: TextStyle(fontSize: 22, color: ThemeColors.primaryColorDark, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: ThemeColors.primaryColorDark, width: 2) ),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        labelText: 'Username',
                        hintText: 'Username',
                        icon: Icon(Icons.account_circle_outlined),
                      filled: false,


                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        labelText: 'Password',
                        hintText: 'Password',
                        icon: Icon(Icons.key),
                        filled: false),
                  ),
                  SizedBox(height: 18),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.primaryColorDark
                    ),
                    onPressed: () {

                    },
                    child: Text('Login', style: TextStyle(color: Colors.white),),
                  ),
                  SizedBox(height: 8),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Don't have an account yet? ",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    children: [
                      TextSpan(
                        text: 'Sign up!',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: ThemeColors.primaryColorDark, decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                        ..onTap= () {
                            Navigator.pushNamed(context, '/signup');
                          },
                      ),
                      TextSpan(
                        text: '.',
                      ),
                    ],
                  ),
                ),
              )],
              ),
            ),
          ],
        ),
      )),
      title: 'Login to Your Account',
    );
  }
}
