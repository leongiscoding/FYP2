import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp2/component/login_signup/logo_widget.dart';
import 'package:fyp2/component/login_signup/email_field.dart';
import 'package:fyp2/component/login_signup/password_field.dart';
import 'package:fyp2/component/login_signup/username_field.dart';
import 'package:fyp2/firebase/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();


// VALIDATE ACTION, SEARCHING FROM FIREBASE AUTH
  void _signUp() async{
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    if(email.isEmpty || password.isEmpty || username.isEmpty){
      String message = 'Invalid blank';
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0
      );
    }else{
      // CHECK THAT WHETHER USER INPUT IS VALID TO CREATE
      await AuthService().signUp(username: _usernameController.text, email: _emailController.text, password: _passwordController.text, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //LOGO
            const LogoWidget(),
            SizedBox(height: 40,),

            //TITLE
             Text(
              "Create Account for EzScan",
              style: GoogleFonts.dmSerifText(
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 23,
                ),
              ),
            ),
            SizedBox(height: 40,),

            //USERNAME INPUT
            UsernameField(controller: _usernameController),
            SizedBox(height: 20,),

            //EMAIL INPUT
            EmailField(controller: _emailController),
            SizedBox(height: 20,),

            //PASSWORD INPUT
            PasswordField(controller: _passwordController),
            SizedBox(height: 40,),

            //SIGNUP BUTTON
            ElevatedButton(
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 32.0),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                    "Create Account",
                    style: GoogleFonts.dmSerifText(
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 17,
                      ),
                    ),
                ),
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
