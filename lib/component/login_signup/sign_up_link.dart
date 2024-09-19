import 'package:flutter/material.dart';

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
        text: const TextSpan(
          text: "Don't have an Account? ",
          style: TextStyle(
            color: Colors.black,
          ),
          children: [
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
