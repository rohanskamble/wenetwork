import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn =GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

   Future googleLogin() async{
     final googleUser= await googleSignIn.signIn();
     if(googleUser ==null) return;
     _user = googleUser;

     final googleAuth =await googleUser.authentication;

     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken,
     );

     await FirebaseAuth.instance.signInWithCredential(credential);

     notifyListeners();


   }
 Future facebooklogin() async {
    var result = await FacebookAuth.i.login(
        permissions: ["public_profile", "email"]
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email,name,picture",
      );
      _user = requestData as GoogleSignInAccount?;
      notifyListeners();
     /*this._user = new User(
        displayName: requestData["name"],
      )*/
    }
  }





     /* final facebookUser= await FacebookAuth.i.login();
    if(facebookUser ==null) return;
    _user = facebookUser;

    final googleAuth =await facebookUser.authentication;

    final credential = FacebookAuthProvider.credential(
      accessToken: FacebookAuth.accessToken,
      idToken: FacebookAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();*/


  }
