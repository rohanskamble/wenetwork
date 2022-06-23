import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wenetwork/inovationesg.dart';
import 'package:wenetwork/loginpage.dart';
import 'package:wenetwork/main.dart';
import 'package:wenetwork/signuppage.dart';
import 'package:wenetwork/startuppage.dart';

class contactadd extends StatefulWidget {
 String fromscreen;
 String option;
 contactadd({
   required this.fromscreen,
   required this.option
});

  @override
  State<contactadd> createState() => _contactaddState();
}

class _contactaddState extends State<contactadd> {
  Future<bool> _onWillPop() async{
    if(widget.fromscreen=="business"){
      if(widget.option=="loginpage"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage(loginname: "loginpage")));
      }else if(widget.option=="innovationgo"||widget.option=="contactadd"||widget.option=="esggo"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>startuppage(fromscreen: widget.fromscreen)));
      }
    }else if(widget.fromscreen=="investor"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signuppage()));

    }else if(widget.fromscreen=="stackholder"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>startuppage(fromscreen: widget.fromscreen)));

    }
    /*if(widget.fromscreen=="loginpage"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage(loginname: "loginpage")));
    }else if(widget.fromscreen=="contactadd"){
      if(widget.option=="contactadd"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>startuppage(fromscreen: widget.fromscreen,)));}
      else if (widget.option=="i"){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage(loginname: "loginpage")));}}

    else if(widget.fromscreen=="innovationgo"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>startuppage(fromscreen: widget.fromscreen,)));
    }else if(widget.fromscreen=="esggo"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>startuppage(fromscreen: widget.fromscreen,)));
    }*/
    //SystemNavigator.pop();
    return true;
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

               /* child:  IconButton(
                  icon: Image.asset("asset/image/home.png",height: 20,width: 80,),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'WeNetwork',)));
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
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 50,bottom: 40),

              child: Text('Contact added to your\nSubnetwork successfully',style: TextStyle(color: Colors.green,fontSize: 22,fontWeight: FontWeight.bold),),
            ),

          ),
          Center(
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10,right: 5,top: 10,bottom:10),
                    child: FlatButton(
                      onPressed: () {
                        print("fromscreen : "+widget.fromscreen);
                        print("option : "+widget.option);
                        if(widget.fromscreen=="business"&&widget.option=="innovationgo"){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>inovationesg(innovation: 'contactadd', fromscreen: widget.fromscreen,)));
                        }else if(widget.fromscreen=="business"&&widget.option=="loginpage"){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>inovationesg(innovation: 'contactadd', fromscreen: widget.fromscreen,)));

                        }else if(widget.fromscreen=="business"&&widget.option=="contactadd"){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>inovationesg(innovation: 'contactadd', fromscreen: widget.fromscreen,)));

                        }else if(widget.fromscreen=="business"&&widget.option=="esggo"){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>inovationesg(innovation: 'contactadd', fromscreen: widget.fromscreen,)));

                        }else if(widget.fromscreen=="investor"&&widget.option=="innovator"){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>inovationesg(innovation: 'contactadd', fromscreen: widget.fromscreen,)));

                        }else if(widget.fromscreen=="investor"&&widget.option=="contactadd"){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>inovationesg(innovation: 'contactadd', fromscreen: widget.fromscreen,)));

                        }else if(widget.fromscreen=="stackholder"&&widget.option=="innovationgo"){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>inovationesg(innovation: 'contactadd', fromscreen: widget.fromscreen,)));

                        }else if(widget.fromscreen=="stackholder"&&widget.option=="esggo"){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>inovationesg(innovation: 'contactadd', fromscreen: widget.fromscreen,)));

                        }

                      },
                      color: Colors.lightBlue,
                      height: 50,
                      minWidth: 370.0,
                      child: Text('Add another contact',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    )
                ),
              ],
            ),
          ),
        ],
      ),
        ),
        );

  }
}
