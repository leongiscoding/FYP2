import 'package:flutter/material.dart';
import 'package:fyp2/component/login_signup/logo_widget.dart';
import 'package:fyp2/component/login_signup/name_field.dart';
import 'package:fyp2/component/login_signup/password_field.dart';
import 'package:fyp2/component/login_signup/sign_up_link.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      //Do action that save to database

      //then navigate to next page
      Navigator.pushNamed(context, "/mainPage");
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //LOGO
            LogoWidget(),
            SizedBox(height: 40,),

            //TITLE
            Text(
                "EzScan",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
            ),
            SizedBox(height: 40,),

            //NAME INPUT
           NameField(controller: _nameController),
            SizedBox(height: 20,),

            //PASSWORD FIELD
            PasswordField(
                controller: _passwordController
            ),
            SizedBox(height: 40,),

            //SIGN IN BUTTON
            ElevatedButton(
                onPressed: _signIn,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 32.0),
                  textStyle: TextStyle(fontSize: 18)
                ),
                child: Text("Sign In"),
            ),
            SizedBox(height: 30,),

            //Sign up link
            SignUpLink(),
          ],
        ),
      ),
    );
  }
}
