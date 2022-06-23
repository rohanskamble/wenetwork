import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wenetwork/inovationesg.dart';
import 'package:wenetwork/main.dart';

class loginpage extends StatefulWidget {


  String loginname;
  loginpage({
    required this.loginname
});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {


  String label="";

  getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState((){
      label=preferences.getString("FirstName")??"";
    });

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
    getUser();
    getToken();
    super.initState();
  }
  Future<bool> _onWillPop() async{
    SystemNavigator.pop();
    return false;
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
                height: 205,
                minWidth: 20,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                },
                child:Image.asset("asset/image/wenetworklogoo.png",),

              ),
            ),

            automaticallyImplyLeading: false,
            actions: <Widget>[
             /* Padding(
                  padding: EdgeInsets.only(left: 0.5,right:0.5),

                  child:  IconButton(
                    icon: Image.asset("asset/image/home.png",height: 20,width: 80,),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'WeNetwork',)));
                    },
                  )
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top:40,bottom: 40),


                child:RichText(
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
                        text: ', what would you like to do?'/*+widget.loginname*/,style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold),
                      ),

                    ]
                  )),
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10,bottom: 20),
                    //  padding: EdgeInsets.only(left:10,right: 10,top:10,bottom: 500),
                    child: FlatButton(
                      onPressed: () {
                        /*String ul= 'https://www.wenetwork.app/';
                                        launch(ul);*/
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>inovationesg(innovation: 'loginpage',fromscreen: "business",)));
                      },
                      color: Colors.deepOrange,
                      height: 50,
                      minWidth: 370.0,
                      child: Text('Create a Subnetwork',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    )

                ),

              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10),
                    //padding: EdgeInsets.only(left:10,right: 10,top:10,bottom: 500),
                    child: FlatButton(
                      onPressed: () {
                        String ul= 'https://www.wenetwork.app/api-redirect-to/'+token+'/9';
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
}
