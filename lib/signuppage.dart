import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wenetwork/inovationesg.dart';
import 'package:wenetwork/main.dart';


class signuppage extends StatefulWidget {
  const signuppage({Key? key}) : super(key: key);

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
 /* _launchurlnew()async{
    const url='https://www.wenetwork.app/';
    var uri= Uri.parse(url);
    if(await canLaunchUrl(uri)){
      await launchUrl(uri);
    }else
      {
        throw "could not launch $url";
      }
  }*//*_launchurl1()async{
    const url='https://www.wenetwork.app/esg/sign-up/1';
    if(await canLaunch(url)){
      await launch(url);
    }else
    {
      throw "could not launch $url";
    }
  }*/
  /*_launch()async{
    const url='https://google.com';
    var uri = Uri.parse(url);
    if(await canLaunchUrl(uri)){
      await _launch();
    }else{
      throw 'could not launch $uri';
    }


  }*/
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
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
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
                 Container(
                   margin: EdgeInsets.only(top:40,bottom: 40),


                    child:Text.rich(TextSpan(
                      text: 'Thanks for signing up.Welcome\nto our community. We are happy\nto have you an board.',style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold),
                    ),textAlign: TextAlign.center
                    ,)
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>inovationesg(innovation: 'signuppagego',fromscreen: "investor",)));
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
