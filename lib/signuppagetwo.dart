import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wenetwork/main.dart';

class signuppaageuptwo extends StatefulWidget {
  String signinpagetwoo;
  signuppaageuptwo({
    required this.signinpagetwoo
  });

  @override
  State<signuppaageuptwo> createState() => _signuppaageuptwoState();
}

class _signuppaageuptwoState extends State<signuppaageuptwo> {
  String label="";

  getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState((){
      label=preferences.getString("FirstName")??"";
      print('label: '+label);
    });

  }


  @override
  void initState() {
    getUser();
    super.initState();
  }
  Future<bool> _onWillPop() async{
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:
      _onWillPop,
      child: Scaffold(
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
              Padding(
                  padding: EdgeInsets.only(left: 0.5,right:0.5),

                /*  child:  IconButton(
                    icon: Image.asset("asset/image/home.png",height: 20,width: 80,),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                    },
                  )*/
              ),
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
        body:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top:40,bottom: 40),


              child:getcontainer()
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10),
                    //padding: EdgeInsets.only(left:10,right: 10,top:10,bottom: 500),
                    child: FlatButton(
                      onPressed: () {
                        String ul= 'https://www.wenetwork.app/api-redirect-to/[UserToken]/9';
                        launch(ul);
                      },
                      color: Colors.lightBlue,
                      height: 50,
                      minWidth: 370.0,
                      child: Text('Explore the innovators',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    )

                ),
              ],
            ),



          ],

        ),
      ),
    );
  }

  Widget getcontainer(){
    if(widget.signinpagetwoo=="stackholder"){
      return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(

              children: [
                TextSpan(
                  text: 'Thanks for Signing up. ',style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "Welcome to our Community.",style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'We are happy to have you an board.'/*+widget.loginname*/,style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold),
                ),

              ]
          ));
    }else{
      return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(

              children: [
                TextSpan(
                  text: 'Welcome ',style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: label,style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' what would you to do?'/*+widget.loginname*/,style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold),
                ),

              ]
          ));
    }
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
                  SharedPreferences _prefs = await SharedPreferences.getInstance();
                  _prefs.setBool("isLoggedin", false);
                  //_prefs.clear();

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
}
