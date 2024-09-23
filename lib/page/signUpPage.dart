import 'package:flutter/material.dart';
import 'package:fyp2/component/login_signup/logo_widget.dart';
import 'package:fyp2/component/login_signup/name_field.dart';
import 'package:fyp2/component/login_signup/password_field.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  //PERFORM FIREBASE AUTH, CREATE AND SAVE ACCOUNT
  void _signUp() async{}

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

            //NAME INPUT
            NameField(controller: _emailController),
            SizedBox(height: 20,),

            //PASSWORD INPUT
            PasswordField(controller: _passwordController),
            SizedBox(height: 40,),

            //SIGNUP BUTTON
            ElevatedButton(
                onPressed:_signUp,
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
