import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService{

  //SIGN UP/ CREATE ACCOUNT
  Future <void> signUp({
    required String username,
    required String email,
    required String password,
    required BuildContext context,
})async{

    try{
     UserCredential userCredential =  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

     //allow to add username
     await userCredential.user?.updateDisplayName(username);

     //reload the user to ensure updates are applied
     await userCredential.user?.reload();

      // When created, navigate user to login page to sign in
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushNamed(context, "/loginPage");

    } on FirebaseAuthException catch(e){
      String message = '';
      // password minimum length: 6
      if(e.code == 'weak-password'){
        message = 'The password is too weak';
      }else if(e.code == 'email-already-in-use'){
        message = 'An account is already exists with that email';
      }
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0
      );
    }
    catch(e){}
  }
  
  //SIGN IN
  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
})async{
    
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      // Success to sign in
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushNamed(context, "/mainPage");

    }on FirebaseAuthException catch(e){
      String message = '';
      // invalid email format
      if(e.code == 'invalid-email'){
        message = 'No user found for that email';
      }else if(e.code == 'invalid-credential'){
        message = 'Wrong password provided for that user';
      }
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0
      );
    }
    catch(e){}
  }

  //SIGN OUT
  Future<void> signOut({
    required BuildContext context,
})async{
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushNamed(context, "/loginPage");
  }
}