import 'package:flutter/material.dart';
import 'package:fyp2/component/login_signup/logo_widget.dart';
import 'package:fyp2/component/login_signup/name_field.dart';
import 'package:fyp2/component/login_signup/password_field.dart';
import 'package:fyp2/component/login_signup/sign_up_link.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  //VALIDATE ACTION, SEARCHING FROM FIREBASE AUTH
  void _signIn() async{
    String name = _nameController.text;
    String password = _passwordController.text;
    if(name.isEmpty || password.isEmpty){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please fill in both name and password"),
              actions: [
                TextButton(
                    onPressed: ()=> Navigator.of(context).pop(),
                    child: Text("OK"),
                )
              ],
            );
          }
      );
    }else{
      //CHECK THAT WHETHER USER INPUT HAS FOUNDED IN DATABASE

      //then navigate to next page
      Navigator.pushNamed(context, "/mainPage");
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
           NameField(controller: _nameController),
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
