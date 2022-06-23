import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wenetwork/investor.dart';
import 'package:wenetwork/login_api.dart';

import 'package:wenetwork/loginpage.dart';
import 'package:wenetwork/main.dart';
import 'package:wenetwork/signuppagetwo.dart';
import 'package:wenetwork/business_signup.dart';
import 'package:wenetwork/startuppage.dart';

class signin extends StatefulWidget {
  String signn;
  signin({
    required this.signn
});


  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {

  final _mysignin1=TextEditingController();
  final _mysignin2=TextEditingController();
  bool _obsecure=true;
  bool isLoading=false;




  callsignin(){
    final service= loginapi();

    service.apicallsignin({
      "Email": _mysignin1.text,
      "Password":_mysignin2.text,
      "DeviceInfo":"",

    }).then((value)async{
      if(value.status!.StatusCode==200){
        print(value.status!.StatusCode.toString());
        SharedPreferences prefr= await SharedPreferences.getInstance();
        prefr.setString("UserToken",value.usertoken??"");
        prefr.setString("UserId",value.userId??"");
        prefr.setString("FirstName",value.firstName??"");
        prefr.setString("LastName", value.lastName??"");
        prefr.setBool("isLoggedin", true);

        print(prefr.getString("FirstName")??"");
        if(widget.signn=="Business\'s") {
          print("FromScreen : Bussiness");
          prefr.setString("UserType", "Bussiness"??"");
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => loginpage(loginname: 'business',)));
        } else if(widget.signn=="Investor\'s"){
          print("FromScreen : Investor");
          prefr.setString("UserType", "Investor"??"");
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => signuppaageuptwo(signinpagetwoo: 'investor',)));
        }else if(widget.signn=="Stakeholder\'s"){
          print("FromScreen :  Stackhoder");
          prefr.setString("UserType", "Stakeholder"??"");
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => startuppage(fromscreen: "stackholder",)));
        }

      }else if(value.status!.StatusCode==1){
        Fluttertoast.showToast(
            msg: "The email or password you have entered is Invalid.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }
      else{
        print(value.status!.StatusCode.toString());
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
          backgroundColor: Colors.black,

          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0.5,right:0.5),

            /*  child: IconButton(
                icon: Image.asset("asset/image/home.png",height: 20,width: 80,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'WeNetwork',)));
                },
              )*/
              ),

            Padding(
              padding:EdgeInsets.only(left: 0.5,right:0.5),
              child: IconButton(
                icon: Image.asset("asset/image/user.png",height: 20,width: 80,),
                onPressed: () {  },
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.5,right:0.5),

              child: IconButton(
                icon: Image.asset("asset/image/align.png",height: 20,width: 80,),
                onPressed: () {  },
              )
            ),
          ]
      ),
      body: Column(

            children: [
              Row(
                children: [
                  Container(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        /*  Navigator.push(
                            context,MaterialPageRoute(builder: (context)=> MyApp()),
                          );*/
                        },
                        icon: Icon(Icons.arrow_back_ios,color: Colors.grey,),
                      )

                  ),
                ],

              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(widget.signn+ ' Sign in',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        cursorColor: Colors.grey, style: TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          hintText:'Enter email address',
                          hintStyle: TextStyle(color: Colors.white70),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70))
                        ),
                        controller: _mysignin1,
                      ),
                    ) ,
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: _obsecure,
                        style: TextStyle(color: Colors.grey),cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            hintText:'Enter password',
                          hintStyle: TextStyle(color: Colors.white70,),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70),),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                          suffixIcon: IconButton(
                            icon: Icon(_obsecure?Icons.visibility_off:Icons.visibility,color: Colors.white,),
                            onPressed: () {
                              setState(() {
                                _obsecure=!_obsecure;
                              });
                            },
                          )
                        ),
                        controller: _mysignin2,
                      ),
                    ) ,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left:10,right: 10,top: 10),
                        child: FlatButton(
                          color: Colors.green,
                          height: 50,
                          minWidth: 370,
                          child: (isLoading)
                              ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth:2.5,
                              )):
                          const Text('Sign in',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                         // child: Text('Sign in',style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold),),
                          onPressed: () async {
                            SharedPreferences prefr = await SharedPreferences.getInstance();
                            String firstname = prefr.getString("FirstName")??"";
                            print(firstname);
                           String  text1=_mysignin1.text;
                           String text2 =_mysignin2.text;

                            /*if(text1=='' || text2==""){
                              Fluttertoast.showToast(msg: 'Please Enter Correct data');
                            }*/if (_mysignin1.text.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(_mysignin1.text)) {
                              Fluttertoast.showToast(
                                  msg: 'Email id should have @ and.',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.orange,
                                  textColor: Colors.white,

                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);
                            } /*else if (_mysignin2.text.isEmpty||!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(_mysignin2.text)) {
                              Fluttertoast.showToast(
                                  msg: 'Password should have one (Upper case, Special & Numeric Character)',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.orange,
                                  textColor: Colors.white,

                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);
                            }*/else{
                              setState(() {
                                isLoading = true;
                              });
                              callsignin();

                              //await Future.delayed(const Duration(seconds: 5));

                            }


                            /*callsignin();
                            setState(() {
                              isLoading = true;
                            });
                            await Future.delayed(const Duration(seconds: 5));
                            setState(() {
                              isLoading = false;
                            });*/
                            //Navigator.push(context,MaterialPageRoute(builder: (context)=>loginpage()));

                          },

                        ),
                      )
                    ],
                  ),Row(
                    children: <Widget>[
                      const Text('Don\'t have an account?',style: TextStyle(color: Colors.white70),),
                      TextButton(

                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 15,color: Colors.deepOrange),
                        ),
                        onPressed: () {
                          if(widget.signn=="Business\'s") {
                            //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => startup()));
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'WeNetwork',)), (route) => false);
                          }else if(widget.signn=="Investor\'s") {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => investor(fromScreen: 'Investor\'s"',)));
                          }else if(widget.signn=="Stakeholder\'s") {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => investor(fromScreen: 'Stakeholder\'s"',)));
                          }
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),


                ],
              )
            ],
          )

    );
  }
}
