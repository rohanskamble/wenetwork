import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wenetwork/google_sign_in.dart';
import 'package:wenetwork/investor.dart';
import 'package:wenetwork/signin.dart';
import 'package:wenetwork/signuppagetwo.dart';
import 'package:wenetwork/business_signup.dart';
import 'package:wenetwork/startuppage.dart';

import 'loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
enum LoginType { facebook, google, apple }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>GoogleSignInProvider(),
    child: MaterialApp(
      title: 'WeNetwork',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const splash(),
    ),
    );
  }
}

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
 void _nextscreen(BuildContext context){

   Timer(
     Duration(seconds: 5),
       ()=>checkUserLoggedin());
           //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'WeNetwork',))));
 }

  checkUserLoggedin()async{
    SharedPreferences prefr= await SharedPreferences.getInstance();
    var isLoggedin = prefr.getBool("isLoggedin")??false;
    if(isLoggedin){
      var userType = prefr.getString("UserType")??"";
      if(userType=="Bussiness"){
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => loginpage(loginname: 'FirstName',)));
      }else if(userType=="Investor"){
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => signuppaageuptwo(signinpagetwoo: 'Investor',)));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => startuppage(fromscreen: "stackholder",)));
      }
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'WeNetwork',)));
    }
 }

  @override
  Widget build(BuildContext context) {

   _nextscreen(context);
    return SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('asset/image/template.png'), fit:BoxFit.cover
              )
          ),
          child: Container(
            margin: EdgeInsets.all(30),
            child: Image(

              image:AssetImage("asset/image/wenetworklogoo.png",),

            ),
          ),
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*Future<bool>? _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => exit(0),
            *//*Navigator.of(context).pop(true)*//*
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('asset/image/template.png'), fit:BoxFit.cover
              )
          ),
          child: Column(

            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left:10,top: 50),
                    child: Image(
                      height: 40,
                      image:AssetImage("asset/image/wenetworklogoo.png",),

                    ),
                  ),
                  Container(
                    //padding: EdgeInsets.only(right: 50,left:0.5),
                    margin: EdgeInsets.only(left: 200,top: 50),
                     child:  IconButton(
                       icon: Image.asset("asset/image/forwardimg.png",height: 30,width: 80,),
                       onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>signin(signn: 'Business\'s',)));
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>startup()));
                        // logout();
                       },

                     )
                  ),

                ],
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Container(
                    padding: EdgeInsets.only(left:5,right:240,top: 150),
                      child:Text('Welcome to',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)

                ),

                ],
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left:10,right:110,top: 10),
                      child:Text('WeNetwork.app',style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),)

                  ),

                ],
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                     // padding: EdgeInsets.only(left:10,right:150,top: 20),
                    margin: EdgeInsets.only(top: 20,left: 10,bottom: 80),

                      child:Text('Join our Innovation\nand ESG network. ',style: TextStyle(color: Colors.white38,fontSize: 25),)

                  ),

                ],
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                         // padding: EdgeInsets.only(left: 10,right: 10,top: 100),
                          margin: EdgeInsets.only(bottom: 20),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,MaterialPageRoute(builder: (context)=>BusinessSignup())
                              );
                            },
                            color: Colors.purple,
                            height: 50,
                            minWidth: 350.0,
                            child: Text('Join as Business',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          )
                      ),
                    ],
                  ),

                ],
              ),

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    //padding: EdgeInsets.only(left: 10,right: 10,top: 80),
                      margin: EdgeInsets.only(bottom: 20),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,MaterialPageRoute(builder: (context)=>investor(fromScreen: "Investor\'s",)),
                        );

                      },
                      color: Colors.orange,
                      height: 50,
                      minWidth: 350.0,
                      child: Text('Join as Investor',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                    )




                  ),

                ],
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    //  padding: EdgeInsets.only(left: 10,right: 10,top: 80),

                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,MaterialPageRoute(builder: (context)=>investor(fromScreen: "Stakeholder\'s",)),
                          );

                        },
                        color: Colors.green,
                        height: 50,
                        minWidth: 350.0,
                        child: Text('Join as Stakeholder',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      )




                  ),

                ],
              ),

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left:0,right:0,top: 100),

                      child:Text.rich(TextSpan(
                        text: 'By using WeNetwork\'s app, you accept the',style: TextStyle(fontSize: 16,color: Colors.white38),
                      ))

                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding:EdgeInsets.only(left: 80,right: 40) ,
                      child:Text.rich(TextSpan(
                          text: 'Term of Service',style: TextStyle(color: Colors.white,fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(text: "\ and ",style: TextStyle(color: Colors.white38)),
                          TextSpan(text: "\ Privacy policy",style: TextStyle(color: Colors.white))

                        ]
                      ),

                  ),
                  ),

                ],
              )
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      );
  }
}
