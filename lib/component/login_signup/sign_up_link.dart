import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpLink extends StatelessWidget {
  const SignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //do navigation to sign up session
        Navigator.pushNamed(context, "/signUpPage");
      },
      child: RichText(
        text:  TextSpan(
          text: "Don't have an Account? ",
          style: GoogleFonts.dmSerifText(
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          children: const [
            TextSpan(
              text: "Click here to Sign Up",
              style: TextStyle(
                color: Colors.blue,
              decoration: TextDecoration.underline,
              ),
            ),
          ]
        ),
      ),
    );
  }
}
