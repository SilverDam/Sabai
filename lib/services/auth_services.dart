// ignore_for_file: use_build_context_synchronously

import'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/showsnackbar.dart';



class FirebaseAuthMethods {

  final FirebaseAuth _auth;
FirebaseAuthMethods(this._auth);

//Email signUp

Future<void> signUpwithEmail({
  required String email,
  required String password,
  required BuildContext context,
}) async {

   try {

       await _auth.createUserWithEmailAndPassword(email: email, password: password);
    
       await sendEmailVerification(context);
   } on FirebaseAuthException catch(error){
          showSnackBar(context, error.message!);

   }


}

//memail login

Future <void> loginWithEmaiAndPassword ({

  required String email,
  required String password,
  required BuildContext context,

}) async {
 
  try {
     await _auth.signInWithEmailAndPassword(email: email, password: password);
     if (!_auth.currentUser!.emailVerified){

       await sendEmailVerification(context);
     } else {


      Navigator.of(context).pushNamed('/basescreen');

     }
  } on FirebaseAuthException catch (error){
        showSnackBar(context, error.message!);
  }


}



//send email verification

Future<void> sendEmailVerification (BuildContext context) async{

  try {
 _auth.currentUser!.sendEmailVerification();
    showSnackBar(context, "Verify your email by clicking on link sent to your mail");

  } on FirebaseAuthException catch (error) {

    showSnackBar(context, error.message!);
  }

}

}