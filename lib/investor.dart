
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';









import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wenetwork/ApiServices.dart';
import 'package:wenetwork/companyinfo.dart';
import 'package:wenetwork/facebook_sign.dart';
import 'package:wenetwork/google_sign_in.dart';
import 'package:wenetwork/signin.dart';
import 'package:wenetwork/signuppage.dart';
import 'package:wenetwork/signuppagetwo.dart';
import 'main.dart';

class investor extends StatefulWidget {

  String fromScreen;
  investor({
    required this.fromScreen
});

  @override
  State<investor> createState() => _investorState();
}

class _investorState extends State<investor> {

  bool _isLoggin=false;
  Map _userobj= {};


  final _formKey = GlobalKey<FormState>();


  bool isLoading = false;
  bool _isObscure = true;

  final myController = TextEditingController();
  final myController2 =TextEditingController();
  final myController3 =TextEditingController();
  final myController4 =TextEditingController();

  callsignupApi(){
    final service= ApiServices();

    service.apiCallLogin({
      "Email": myController.text,
      "Password":myController2.text,
      "FirstName":myController3.text,
      "LastName":myController4.text,
      "UserRole":"1",
      "DeviceInfo":"",

    }).then((value) async {
      print("from:"+widget.fromScreen);
      if(value.status!.StatusCode==200){
        SharedPreferences prefr= await SharedPreferences.getInstance();
        prefr.setString("UserToken",value.usertoken??"");
        prefr.setString("UserId",value.userId??"");
        prefr.setString("FirstName",value.firstName??"");
        prefr.setString("LastName", value.lastName??"");
        prefr.setBool("isLoggedin", true);
        prefr.setString("UserType", widget.fromScreen);

        if(widget.fromScreen== "Investor\'s") {
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) =>
                  companyinfo(campany: 'investor',))
          );
        }else
        {
          Navigator.push(
              context, MaterialPageRoute(
            builder: (context) =>
                signuppaageuptwo( signinpagetwoo: 'stackholder',),));
        }




        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>investor(fromScreen: 'fromScreen')));
      } else{
        Fluttertoast.showToast(
            msg: "Please Enter Valid Information",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      setState(() {
        isLoading = false;
      });
    });
  }
  logout(){
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Are You Want To Logout?'),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context, false), // passing false
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () async {
                  SharedPreferences _prefs =
                  await SharedPreferences
                      .getInstance();
                  _prefs.clear();
                  Route newRoute = MaterialPageRoute(
                      builder: (context) =>
                      const MyHomePage(title: 'WeNetwork',));
                  Navigator.pushAndRemoveUntil(
                      context,
                      newRoute, (route) => false);
                } ,// passing true
                child: Text('Yes'),
              ),
            ],
          );
        }).then((exit) {
      if (exit == null) return;

      if (exit) {
        // user pressed Yes button
      } else {
        // user pressed No button
      }
    });
  }
  bool _isLoggedIn = false;
  Map _userObj = {};






  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _fetching = true;
  User? get _currentUser => _auth.currentUser;

  @override
/*  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(Duration(seconds: 1));
    _fetching = false;
    setState(() {});
  }

  void _login(LoginType type) async {
    setState(() {
      _fetching = true;
    });
    OAuthCredential? credential;
    if (type == LoginType.facebook) {
      credential = await _loginWithFacebook();
    } else{
      Fluttertoast.showToast(
          msg: "error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    if (credential != null) {
      await _auth.signInWithCredential(credential);
    }

    setState(() {
      _fetching = false;
    });
  }

  Future _loginWithFacebook() async {
    try {
      final AccessToken accessToken = (await FacebookAuth.i.login()) as AccessToken;
      return FacebookAuthProvider.credential(
        accessToken.token,
      );
    }  catch (FacebookAuthException) {
      print(FacebookAuthException);
      Fluttertoast.showToast(
          msg: "No data found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      return null;
    }
  }*/
  Future<void>signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult= await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential= FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _auth.signInWithCredential(facebookAuthCredential);
    }on FirebaseAuthException catch(e){
      //SnackBar(context,e.message);
      print(e.message);
    }
  }


  @override
  Widget build(BuildContext context) {
    var model;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
            title:   Container(
              padding: EdgeInsets.only(right: 90,left:0.5),
              margin: EdgeInsets.only(left: 0.5),
              child:FlatButton(
                height: 20,
                minWidth: 20,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                },
                child:Image.asset("asset/image/wenetworklogoo.png",),

              ),
            ),

            automaticallyImplyLeading: false,
            actions: <Widget>[
        /*Padding(
        padding: EdgeInsets.only(left: 0.5,right:0.5),
           child: _isLoggedIn ? Column(
              children: [
                Image.network(_userObj["picture"]["data"]["url"]),
                Text(_userObj["name"]),
                Text(_userObj["email"]),

                TextButton(onPressed:(){
                  FacebookAuth.instance.logOut().then((value){
                    setState((){
                      _isLoggedIn=false;
                      _userObj={};
                    });
                  });

                }, child: Text("Logout"))
              ],
            ) :Center(
              child: ElevatedButton(onPressed: () {
                FacebookAuth.instance.login(
                    permissions: ["public_profile","email"]
                ).then((value){
                  FacebookAuth.instance.getUserData().then((userData){
                    setState((){
                      _isLoggedIn=true;
                      _userObj=userData;
                    });
                  });
                });

              },
                child: Text("Login With FaceBook"),
              ),
            ),

   *//*     child:  IconButton(
          icon: Image.asset("asset/image/home.png",height: 20,width: 80,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'WeNetwork',)));
          },
        )*//*
      ),*/
              Padding(
                padding:EdgeInsets.only(left: 0.5,right:0.5),
                child:  IconButton(
                  icon: Image.asset("asset/image/user.png",height: 20,width: 80,),
                  onPressed: () {  },
                )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 0.5,right:0.5),

                  child:  IconButton(
                    icon: Image.asset("asset/image/logoutt.png",height: 25,width: 40,),
                    onPressed: () {

                      logout();
                    },
                  )
              ),
      ]
        ),
         body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                   children: [
                      Container(
                        child: IconButton(
                          onPressed: () {
                          Navigator.pop(context);
                        },
                          icon: Icon(Icons.arrow_back_ios,color: Colors.grey,),
                        )

                      ),
                    ],

                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20,right:10),
                        child: Text(widget.fromScreen+' sign up',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                      )

                    ],

                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left:10,top: 5,bottom: 2),
                        height: 50,
                         width: 50,
                        child:  IconButton(
                            icon: Image.asset('asset/image/google.png'),
                            onPressed: () {  },
                          )

                      ),
                      Container(
                        child: TextButton(
                          onPressed: () {
                            final provider =Provider.of<GoogleSignInProvider>(context,listen:false);
                            provider.googleLogin();

                          },
                          child: Text("Sign up using Google",style: TextStyle(color:Colors.white70,fontWeight: FontWeight.bold),),

                        ),
                            //child: Center(child: Text('Sign up using Google',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      //if (!_fetching && _currentUser == null)
                      Container(
                        height: 35,
                        width: 50,
                          child:IconButton(
                            padding: EdgeInsets.only(left:10,top:8,bottom: 4),
                            icon: Image.asset("asset/image/facebook.png"),
                            onPressed: () {
                           /*   FirebaseAuthMethods(FirebaseAuth.instance).*/
                              //signInWithFacebook(context);

                              //_login(LoginType.facebook);
                             // _loginWithFacebook();
                          /*   child: _isLoggedIn ? Column(
                                children: [
                                  Image.network(_userObj["picture"]["data"]["url"]),
                                  Text(_userObj["name"]),
                                  Text(_userObj["email"]),

                                  TextButton(onPressed:(){
                                    FacebookAuth.instance.logOut().then((value){
                                      setState((){
                                        _isLoggedIn=false;
                                        _userObj={};
                                      });
                                    });

                                  }, child: Text("Logout"))
                                ],
                              ) :Center(
                                child: ElevatedButton(onPressed: () {
                                  FacebookAuth.instance.login(
                                    permissions: ["public_profile","email"]
                                  ).then((value){
                                    FacebookAuth.instance.getUserData().then((userData){
                                      setState((){
                                        _isLoggedIn=true;
                                        _userObj=userData;
                                      });
                                    });
                                  });

                                },
                                child: Text("Login With FaceBook"),
                             ),
                              );*/

                            },
                          )

                      ),
                      Container(
                        child: TextButton(
                          onPressed: () async{
                            signInWithFacebook(context);
                        /*  FacebookAuth.instance.login(
                              permissions: ["public-profile","email"]
                          ).then((value) {
                            FacebookAuth.instance.getUserData().then((userData){
                              setState((){
                                _isLoggin=true;
                                _userobj=userData;
                              }
                              );
                            });
                          });*/
                          /*  FacebookAuth.instance.login(
                                permissions: ["public_profile", "email"]).then((value) {
                              FacebookAuth.instance.getUserData().then((userData) {
                                setState(() {
                                  _isLoggedIn = true;
                                  _userObj = userData;
                                });
                              });
                            });*/
                            //final provider =Provider.of<GoogleSignInProvider>(context,listen:false);
                           // provider.facebooklogin();

                        },
                        child:Text('Sign up using Facebook',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),),

                        ),
                       // child: Center(child: Text('Sign up using Facebook',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),)),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10,right: 15),
                            child: Divider(
                              color: Colors.white38,
                              height: 50,
                            ),
                          )
                      ),
                      Text('OR',style:TextStyle(color: Colors.grey)),
                      Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10,right: 15),
                            child: Divider(
                              color: Colors.white38,
                              height: 50,
                            ),
                          )
                      ),

                    ],
                  ),
                  Column(
                    children:[
                       Container(

                         decoration: BoxDecoration(color:Colors.black),
                        child: Padding(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom:10),
                           child: Center(
                             child: TextFormField(

                               style: TextStyle(color: Colors.grey),cursorColor: Colors.grey,
                          decoration: InputDecoration(
                       hintText: 'Enter email address',
                            hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70),),
                          ),
                         controller: myController,
                               validator: (value) {
                                 // Check if this field is empty
                                 if (value == null || value.isEmpty) {
                                   return 'This field is required';
                                 }

                                 // using regular expression
                                 if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                   return "Please enter a valid email address";
                                 }

                                 // the email is valid
                                 return null;
                               },
                     ),

                   )
      ),
                       ),
                      Container(

                       // decoration: BoxDecoration(color:Colors.black),
                        child: Padding(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom:10),

                            child: Center(
                              child: TextFormField(
                                obscureText: _isObscure,
                                style: TextStyle(color: Colors.grey),cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  hintText: 'Enter password',
                                  hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white70),),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70),),
                                  suffixIcon: IconButton(

                                    icon: Icon(_isObscure?Icons.visibility_off:Icons.visibility,color: Colors.white,),
                                    onPressed: (){
                                      setState(() {
                                        _isObscure=!_isObscure;
                                      });
                                    },
                                  )
                                ),
                                controller: myController2,
                              ),

                            )
                        ),
                      ),
                          Container(

                            decoration: BoxDecoration(color:Colors.black),
                            child: Padding(
                                padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom:10),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: SizedBox(
                                          width:170,
                                          child: TextFormField(
                                            style: TextStyle(color: Colors.grey),cursorColor: Colors.grey,
                                            decoration: InputDecoration(
                                              hintText: 'First name',
                                              hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white70)),
                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70),),
                                            ),
                                            controller: myController3,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: SizedBox(
                                          width:170,
                                          child: TextFormField(
                                            style: TextStyle(color: Colors.grey),cursorColor: Colors.grey,
                                            decoration: InputDecoration(
                                              hintText: 'Last name',
                                              hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white70)),
                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70),),
                                            ),
                                            controller: myController4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),


                                )
                            ),),




      ],
                  ),

                      Center(
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 10,right: 5,top: 10,bottom:10),
                                child: FlatButton(
                                  onPressed: () async {
                                    SharedPreferences prefr = await SharedPreferences.getInstance();
                                    String firstname = prefr.getString("FirstName")??"";
                                    print(firstname);
                                    String text1= myController.text;
                                    String text2=myController2.text;
                                    String text3= myController3.text;
                                    String text4= myController4.text;

                                    /*if(text1==''||text2==''||text3==''||text4==''){
                                      Fluttertoast.showToast(
                                          msg: "Please Fill Correct Data",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          fontSize: 16.0
                                      );
                                    }else*/ if (myController.text.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(myController.text)) {
                                      Fluttertoast.showToast(
                                          msg: 'Email id should have @ and.',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.orange,
                                          textColor: Colors.white,

                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    }else if (myController2.text.isEmpty||!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(myController2.text)) {
                                      Fluttertoast.showToast(
                                       // msg:'Please Enter Password.',
                                          msg: 'Password should have one (Upper case,& Numeric Character)',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.orange,
                                          textColor: Colors.white,

                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    }else if (myController3.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: 'PLease Enter First Name',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.orange,
                                          textColor: Colors.white,

                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    } else if (myController4.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: 'PLease Enter Last Name',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.orange,
                                          textColor: Colors.white,

                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    } else{
                                      setState(() {
                                        isLoading = true;
                                      });
                                      callsignupApi();
                                    }




                                    //await Future.delayed(const Duration(seconds: 5));

                                  /*  if(widget.fromScreen== "Investor\'s") {
                                      Navigator.push(
                                          context, MaterialPageRoute(
                                          builder: (context) =>
                                              companyinfo(campany: 'investor',))

                                    }else
                                      {
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) =>
                                            signuppaageuptwo(),));
                                      }*/
                                  },

                                  color: Colors.green,
                                  height: 50,
                                  minWidth: 370.0,
                                  child: (isLoading)
                                  ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth:2.5,
                                  )):
                                  const Text('Proceed',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                )




                            ),
                          ],
                        ),
                      ),
                  Row(
                    children: <Widget>[
                      const Text('Already have an account?',style: TextStyle(color: Colors.white70),),
                      TextButton(
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 15,color: Colors.deepOrange),
                        ),
                        onPressed: () {
                          if (widget.fromScreen == "Investor\'s") {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => signin(
                                  signn: 'Investor\'s',)));
                          }

                          else{
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => signin(
                                  signn: "Stakeholder\'s",)));

                          }
                        }
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),

                ],
            ),
         ),
        );


  }

}
