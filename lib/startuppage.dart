import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wenetwork/inovationesg.dart';
import 'package:wenetwork/main.dart';

class startuppage extends StatefulWidget {

 String fromscreen;
 startuppage({
   required this.fromscreen
});

  @override
  State<startuppage> createState() => _startuppageState();
}

class _startuppageState extends State<startuppage> {
String name="";
getname() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  setState((){
    name=preferences.getString("FirstName")??"";
  });
}
Future<bool> _onWillPop() async{
 // Navigator.of(context).popUntil((route) => false);
  SystemNavigator.pop();
  return false;
}
String token="";
getToken() async {
  SharedPreferences pref=await SharedPreferences.getInstance();
  setState((){
    token=pref.getString("UserToken")??"";

  });
}

@override
void initState() {
  getToken();
  getname();
  super.initState();
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
/*
                  child:  IconButton(
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                        padding:EdgeInsets.only(top: 0.5,bottom:20),
                        margin: EdgeInsets.only(top:0.5,bottom: 0.5),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Congratulations ",style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold)
                            ),
                            TextSpan(
                                text: name+".",style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold)
                            ),
                            TextSpan(
                                text: " We are glad that you have joined Wenetwork.",style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold)
                            ),
                          ]
                        ),

                      ),

                      /*  child:Text.rich(TextSpan(
                          text: 'Congratulations We are \nglad that you have joined\nWenetwork.',style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold),
                        ),textAlign: TextAlign.center
                          ,)*/
                    ),
                    Container(

                        padding:EdgeInsets.only(top: 20),
                        margin: EdgeInsets.only(top:0.5,bottom:0.5),
                        child:Text.rich(TextSpan(
                          text: 'What would you like to do?',style: TextStyle(fontSize: 20,color: Colors.white),
                        ),textAlign: TextAlign.center
                          ,)
                    ),
                  /*  Container(
                        margin: EdgeInsets.only(top: 40),
                        padding:EdgeInsets.only(top: 0.5),
                        child:Text.rich(TextSpan(
                          text: 'Helps to align your environmental,governance and\nsocial goals with your employees and customers.',style: TextStyle(fontSize: 15,color: Colors.white),
                        ),textAlign: TextAlign.center
                          ,)
                    ),*/
                    Container(
                        margin: EdgeInsets.only(top: 40),
                        padding:EdgeInsets.only(top: 0.5),
                        //margin: EdgeInsets.only(top:10,),
                        child: FlatButton(
                          onPressed: () {
                          /*  String urlin='https://www.wenetwork.app/esg/sign-up/1';
                            launch(urlin);*/
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>inovationesg(innovation: 'innovationgo',fromscreen: widget.fromscreen,)));

                          },
                          color: Colors.green,
                          height: 50,
                          minWidth: 360.0,
                          child: Text('Create an Innovation network',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        )

                    ),
                  /*  Container(
                        padding:EdgeInsets.only(top:40,bottom:10),
                        margin: EdgeInsets.only(top:0.5,),
                        child:Text.rich(TextSpan(
                          text: 'Helps to align your environmental,governance and\nsocial goals with your employees and customers.',style: TextStyle(fontSize: 15,color: Colors.white),
                        ),textAlign: TextAlign.center
                          ,)
                    ),*/
                    Container(
                        //margin: EdgeInsets.only(top:0.5,bottom: 0.5),
                        margin: EdgeInsets.only(top: 40),
                        padding:EdgeInsets.only(top: 0.5),

                        child: FlatButton(
                          onPressed: () {
                           /* String urlin='https://www.wenetwork.app/esg/sign-up/1';
                            launch(urlin);*/
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>inovationesg(innovation: 'esggo', fromscreen: widget.fromscreen,)));

                          },
                          color: Colors.deepOrange,
                          height: 50,
                          minWidth: 360.0,
                          child: Text('Create an ESG network',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        )

                    ),
                /*    Container (
                        margin: EdgeInsets.only(top:40),


                        child:Text.rich(TextSpan(
                          text: 'For inviting existing user or wenetwork members to\n crowdsource new ideas or market new products.',style: TextStyle(fontSize: 15,color: Colors.white),
                        ),textAlign: TextAlign.center
                          ,)
                    ),*/
                    Container(
                       // margin: EdgeInsets.only(top:10,),
                        margin: EdgeInsets.only(top: 40),
                        padding:EdgeInsets.only(top: 0.5),

                        child: FlatButton(
                          onPressed: () {
                            String urlcon='https://www.wenetwork.app/api-redirect-to/'+token+'/1';
                            launch(urlcon);

                          },
                          color: Colors.lightBlue,
                          height: 50,
                          minWidth: 360.0,
                          child: Text('Start an innovation contest',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        )

                    ),
                    Container(
                        padding:EdgeInsets.only(top:40,bottom:10),
                        margin: EdgeInsets.only(top:0.5,),

                        child: FlatButton(
                          onPressed: () {
                            String urlcon='https://www.wenetwork.app/api-redirect-to/'+token+'/3';
                            launch(urlcon);

                          },
                          color: Colors.purple,
                          height: 50,
                          minWidth: 360.0,
                          child: Text('Start an ESG challenge',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        )

                    ),
                  ],
                ),




              ],

            ),
          ),
        ),
      )
    );

  }


logout(){
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Are you sure to logout ?'),
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
