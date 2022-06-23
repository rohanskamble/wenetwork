import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wenetwork/ApiServices.dart';
import 'package:wenetwork/companyinfo.dart';
import 'package:wenetwork/google_sign_in.dart';
import 'package:wenetwork/main.dart';
import 'package:wenetwork/signin.dart';
import 'package:wenetwork/signuppagetwo.dart';
import 'package:wenetwork/startuppage.dart';

class BusinessSignup extends StatefulWidget {
/*  String businesssignup;
  startup({
    required this.businesssignup
});*/

  @override
  State<BusinessSignup> createState() => _BusinessSignupState();
}

class _BusinessSignupState extends State<BusinessSignup> {

  FirebaseAuth _auth = FirebaseAuth.instance;


  bool _isObscure1 = true;
  bool isLoading = false;

  final MyController = TextEditingController();
  final MyController2 =TextEditingController();
  final MyController3 =TextEditingController();
  final MyController4 =TextEditingController();



  callbusinessApi() {
    final service = ApiServices();

    service.apiCallLogin({
      "Email": MyController.text,
      "Password": MyController2.text,
      "FirstName": MyController3.text,
      "LastName": "",
      "UserRole": "1",
      "DeviceInfo": "",

    }).then((value) async {
      if (value.status!.StatusCode == 200) {
        SharedPreferences prefr = await SharedPreferences.getInstance();
        prefr.setString("UserToken", value.usertoken ?? "");
        prefr.setString("UserId", value.userId ?? "");
        prefr.setString("FirstName", value.firstName ?? "");
        prefr.setString("LastName", value.lastName ?? "");
        prefr.setBool("isLoggedin", true);
        prefr.setString("UserType", "Bussiness"??"");
        Navigator.pushReplacement(
            context,MaterialPageRoute(builder: (context)=>companyinfo(campany: 'business',))
        ); /*if(widget.businesssignup=="Business\'s") {
          print("FromScreen : bussiness");
          prefr.setString("UserType", "bussiness"??"");
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => loginpage(loginname: 'FirstName',)));
        }*/


        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>investor(fromScreen: 'fromScreen')));
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
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
                  await SharedPreferences.getInstance();
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title:   Container(
            padding: EdgeInsets.only(right: 90,left:0.5),
            margin: EdgeInsets.only(left: 0.5),
            child:FlatButton(
              height: 5,
              minWidth: 15,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
              },
              child:Image.asset("asset/image/wenetworklogoo.png",),

            ),
          ),
          backgroundColor: Colors.black,

          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0.5,right:0.5),

         /*     child: IconButton(
                icon: Image.asset("asset/image/home.png",height: 20,width: 80,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'WeNetwork',)));
                },
              )*/
              ),
            Padding(
              padding:EdgeInsets.only(left: 0.5,right:0.5),
              child:IconButton(
                icon: Image.asset("asset/image/user.png",height: 20,width: 80,),
                onPressed: () {  },
              )
            ),
           /* Padding(
              padding: EdgeInsets.only(left: 0.5,right:0.5),

                child:  IconButton(
                  icon: Image.asset("asset/image/logoutt.png",height: 25,width: 40,),
                  onPressed: () {

                    logout();
                  },
                )
            ),*/
          ]
      ),
      body:SingleChildScrollView(
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
                  child: Text('Business\'s Sign up',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                )

              ],

            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left:10,top: 5,bottom: 2),
                  height: 50,
                  width: 50,
                  child:IconButton(
                    icon: Image.asset("asset/image/google.png",height: 40,width: 100,),
                    onPressed: () {
                     /* final provider =Provider.of<GoogleSignInProvider>(context,listen:false);
                      provider.googleLogin();*/
                    },
                  ),

                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      final provider =Provider.of<GoogleSignInProvider>(context,listen:false);
                      provider.googleLogin();

                    },
                    child: Text("Sign up using Google",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),),

                  ),
                 // child: Center(child: Text('Sign up using Google',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),)),
                )
              ],
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left:10,top:5,bottom: 4),
                  height: 50,
                  width: 50,
                    child:IconButton(
                      icon: Image.asset("asset/image/facebook.png",height: 40,width: 100,),
                      onPressed: () {  },
                    )

                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      signInWithFacebook(context);

                    },
                    child: Text('Sign up using Facebook',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),),

                  ),
                 // child: Text('Sign up using Facebook',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),),
                )
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
                          controller: MyController,
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
                          obscureText: _isObscure1,
                          style: TextStyle(color: Colors.grey),cursorColor: Colors.grey,
                          decoration: InputDecoration(
                              hintText: 'Enter password',
                              hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70),),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70),),
                              suffixIcon: IconButton(

                                icon: Icon(_isObscure1?Icons.visibility_off:Icons.visibility,color: Colors.white,),
                                onPressed: (){
                                  setState(() {
                                    _isObscure1=!_isObscure1;
                                  });
                                },
                              )
                          ),
                          controller: MyController2,
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
                                  controller: MyController3 ,
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
                                  controller: MyController4 ,
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
                          String text1= MyController.text;
                          String text2=MyController2.text;
                          String text3= MyController3.text;
                          String text4= MyController4.text;

                         /* if(text1==''||text2==''||text3==''||text4==''){
                            Fluttertoast.showToast(
                                msg: "Please Fill Correct Data",
                                toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          }else*/ if (MyController.text.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(MyController.text)) {
                            Fluttertoast.showToast(
                                msg: 'Email id should have @ and.',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.orange,
                                textColor: Colors.white,

                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                            //(?=.*?[!@#\$&*~])*
                          } else if (MyController2.text.isEmpty||!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(MyController2.text)) {
                            Fluttertoast.showToast(
                               // msg:'Please Enter Password.',
                                msg: 'Password should have one (Upper case, & Numeric Character)',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.orange,
                                textColor: Colors.white,

                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                          }else if (MyController3.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'PLease Enter First Name',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.orange,
                                textColor: Colors.white,

                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                          } else if (MyController4.text.isEmpty) {
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
                            callbusinessApi();
                          }


                      /*    callbusinessApi();
                          setState(() {
                            isLoading = true;
                          });
                          await Future.delayed(const Duration(seconds: 5));
                          setState(() {
                            isLoading = false;
                          });*/



                          /*Navigator.push(
                              context,MaterialPageRoute(builder: (context)=>companyinfo(campany: 'business',))
                          );*/
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
                        //child: Text('Proceed',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>signin(signn: 'Business\'s',)));
                  },
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
