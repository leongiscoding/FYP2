import 'package:flutter/material.dart';
import 'package:fyp2/page/loginPage.dart';
import 'package:fyp2/page/mainPage.dart';
import 'package:fyp2/page/profilePage.dart';
import 'package:fyp2/page/signUpPage.dart';

void main() async{
  runApp(
     const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/loginPage" : (context) =>  LoginPage(),
        "/signUpPage" : (context) => SignUpPage(),
        "/mainPage" : (context) => MainPage(),
        "/profilePage" : (context) => ProfilePage(),
      },
    );
  }
}





