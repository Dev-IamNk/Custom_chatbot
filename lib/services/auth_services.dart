

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth_service{
  FirebaseAuth auth=FirebaseAuth.instance;
  Future<User?> Register(String email,String pass,BuildContext context )async{
    try{
      UserCredential user= await auth.createUserWithEmailAndPassword(email: email, password: pass);
      return user.user;
    }
    on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
    catch(e){
      print(e);
    }

  }
  Future<User?> Login(String email,String pass,BuildContext context)async{
    try{
      UserCredential user =await auth.signInWithEmailAndPassword(email: email, password: pass);
      return user.user;
    }
    on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
    catch(e){
      print(e);
    }

  }

  Future<User?> signInWithGoogle()async{
    try{
      final googleaccount =await GoogleSignIn().signIn();
      if(googleaccount!=null){
        final GoogleSignInAuthentication Gauth =await googleaccount.authentication;
        final credential =GoogleAuthProvider.credential(
            accessToken: Gauth.accessToken,
            idToken: Gauth.idToken
        );
        UserCredential userCredential= await auth.signInWithCredential(credential);
        return userCredential.user;
      }
    }
    catch(e){
      print(e);
    }
  }
  Future<User?> signOut()async{
    await GoogleSignIn().signOut();
    await auth.signOut();
}
}