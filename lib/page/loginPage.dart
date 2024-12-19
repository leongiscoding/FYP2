import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp2/component/login_signup/logo_widget.dart';
import 'package:fyp2/component/login_signup/email_field.dart';
import 'package:fyp2/component/login_signup/password_field.dart';
import 'package:fyp2/component/login_signup/sign_up_link.dart';
import 'package:fyp2/firebase/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  // VALIDATE ACTION, SEARCHING FROM FIREBASE AUTH
  void _signIn() async{
    String name = _emailController.text;
    String password = _passwordController.text;
    if(name.isEmpty || password.isEmpty){
      String message = 'Invalid blank email or password';
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0
      );
    }else{
      // CHECK THAT WHETHER USER INPUT HAS FOUNDED IN DATABASE
      await AuthService().signIn(email: _emailController.text, password: _passwordController.text, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //LOGO
            const LogoWidget(),
            SizedBox(height: 40,),

            //TITLE
             Text(
                "Welcome to EzScan",
                style: GoogleFonts.dmSerifText(
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 23,
                  ),
                ),
            ),
            SizedBox(height: 40,),

            //NAME INPUT
           EmailField(controller: _emailController),
            SizedBox(height: 20,),

            //PASSWORD INPUT
            PasswordField(
                controller: _passwordController
            ),
            SizedBox(height: 40,),

            //SIGN IN BUTTON
            ElevatedButton(
                onPressed: _signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 32.0),
                ),
                child: Text(
                  "Sign In",
                  style: GoogleFonts.dmSerifText(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 17,
                    ),
                  ),
                ),
            ),
            SizedBox(height: 30,),

            //Sign up link
            const SignUpLink(),
          ],
        ),
      ),
    );
  }
}
