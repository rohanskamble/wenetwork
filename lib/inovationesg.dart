import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wenetwork/Esg_Api.dart';
import 'package:wenetwork/addanother_api.dart';
import 'package:wenetwork/contactadd.dart';
import 'package:wenetwork/innovation_esg_Api.dart';
import 'package:wenetwork/main.dart';
import 'package:wenetwork/scanner.dart';
import 'package:wenetwork/startuppage.dart';

class inovationesg extends StatefulWidget {

  String innovation;
  String fromscreen;
    inovationesg({
    required this.innovation,
      required this.fromscreen
});

  @override
  State<inovationesg> createState() => _inovationesgState();
}

class _inovationesgState extends State<inovationesg> {
  bool isLoading= false;
  TextEditingController campanyname=TextEditingController();
  TextEditingController campanyemail=TextEditingController();

  String token="";
  int Id=1;
  gettoken() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    setState((){
      token=pref.getString("UserToken")??"";
      print("usertoken"+token);
      Id = pref.getInt("UserId")??1;
      print("user id"+Id.toString());
    });

  }

callApi(){
  final service=  innovationesgapi();
  final esgservice= esgapi();
  final addanother= addanotherApi();


  print("token"+token);
  print("comapny"+campanyname.text);
  print("user id"+Id.toString());


if(widget.innovation =="innovationgo"){
  service.apiCallinnovation({
    "UserToken": token,
    "SubnetworkName": campanyname.text,
    // "email":campanyemail.text,
    "CategoryFor":1,

  }).then((value) async {
    if(value.status!.StatusCode==200){
      SharedPreferences prefr= await SharedPreferences.getInstance();
      prefr.setString("UserToken",value.usertoken??"");
      prefr.setInt("UserId",value.subnetworkId??1);
      prefr.setString("Username",value.subnetworkName??"");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd(fromscreen: widget.fromscreen, option: 'innovationgo',)));
/*      if(widget.innovation=="Investor\'s"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }else if(widget.innovation=="business"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }else if(widget.innovation=="signin"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }*/

      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>investor(fromScreen: 'fromScreen')));
    } else{
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
  });
}else if(widget.innovation=="esggo"){
  esgservice.apiCallEsg({

    "UserToken": token,
    "SubnetworkName": campanyname.text,
    // "email":campanyemail.text,
    "CategoryFor":1,

  }).then((value) async {
    if(value.status!.StatusCode==200){
      SharedPreferences prefr= await SharedPreferences.getInstance();
      prefr.setString("UserToken",value.usertoken??"");
      prefr.setInt("UserId",value.subnetworkId??1);
      prefr.setString("Username",value.subnetworkName??"");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd(fromscreen: widget.fromscreen, option: 'esggo',)));
     /* if(widget.innovation=="Investor\'s"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }else if(widget.innovation=="business"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }else if(widget.innovation=="signin"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }*/

      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>investor(fromScreen: 'fromScreen')));
    } else{
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
  });
}else if(widget.innovation=='contactadd'){
  addanother.apiCalladdanother({

    "UserToken": token,
    "SubnetworkId":1,
    "ContactEmail":campanyemail.text,
    "ContactUserName":campanyname.text,
    "SubnetworkFor":2,

  }).then((value) async {
    if(value.status!.StatusCode==200){
      SharedPreferences prefr= await SharedPreferences.getInstance();
      prefr.setString("UserToken",value.usertoken??"");
      prefr.setInt("UserId",value.contactId??1);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd(fromscreen: widget.fromscreen, option: 'contactadd')));
      /* if(widget.innovation=="Investor\'s"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }else if(widget.innovation=="business"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }else if(widget.innovation=="signin"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }*/

      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>investor(fromScreen: 'fromScreen')));
    } else{
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
  });
}else if(widget.innovation =="signuppagego"){
    service.apiCallinnovation({
      "UserToken": token,
      "SubnetworkName": campanyname.text,
      // "email":campanyemail.text,
      "CategoryFor":1,

    }).then((value) async {
      if(value.status!.StatusCode==200){
        SharedPreferences prefr= await SharedPreferences.getInstance();
        prefr.setString("UserToken",value.usertoken??"");
        prefr.setInt("UserId",value.subnetworkId??1);
        prefr.setString("Username",value.subnetworkName??"");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd(fromscreen: widget.fromscreen, option: 'innovator',)));
/*      if(widget.innovation=="Investor\'s"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }else if(widget.innovation=="business"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }else if(widget.innovation=="signin"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }*/

        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>investor(fromScreen: 'fromScreen')));
      } else{
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


    });
  }
else if(widget.innovation =="loginpage"){
  service.apiCallinnovation({
    "UserToken": token,
    "SubnetworkName": campanyname.text,
    // "email":campanyemail.text,
    "CategoryFor":1,

  }).then((value) async {
    if(value.status!.StatusCode==200){
      SharedPreferences prefr= await SharedPreferences.getInstance();
      prefr.setString("UserToken",value.usertoken??"");
      prefr.setInt("UserId",value.subnetworkId??1);
      prefr.setString("Username",value.subnetworkName??"");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd(fromscreen: widget.fromscreen, option: 'loginpage',)));
/*      if(widget.innovation=="Investor\'s"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }else if(widget.innovation=="business"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }else if(widget.innovation=="signin"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));
      }*/

      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>investor(fromScreen: 'fromScreen')));
    } else{
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

  @override
  Widget build(BuildContext context) {
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
            Padding(
                padding: EdgeInsets.only(left: 0.5,right:0.5),
/*
                child:  IconButton(
                  icon: Image.asset("asset/image/home.png",height: 20,width: 80,),
                  onPressed: () {
                    Navigator.pop(context);
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                       /* Navigator.push(context, MaterialPageRoute(builder: (context)=>startuppage()));*/
                      },
                      icon: Icon(Icons.arrow_back_ios,color: Colors.grey,),
                    )

                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30,right: 10),
                //  padding: EdgeInsets.only(left: 20,right:10),
                  child: Text('Create an innovation/ESG network',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                )

              ],

            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin:EdgeInsets.only(top: 30,left: 10,bottom: 10),
                    child:Text("Individual or Campany Name",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: TextFormField(

                    cursorColor: Colors.black,
                    style: TextStyle(color:Colors.grey,),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                      disabledBorder: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),

                    ),
                    controller: campanyname,

                  ),
                ),


              ],

            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin:EdgeInsets.only(top: 30,left: 10,bottom: 10),
                    child:Text("Email address",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 30),
                  child: TextFormField(

                    cursorColor: Colors.black,
                    style: TextStyle(color:Colors.grey,),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                      disabledBorder: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),

                    ),
                    controller: campanyemail,

                  ),
                ),


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
                          String firstname = prefr.getString("Username")??"";
                          print(firstname);
                          String text1= campanyname.text;
                          String text2=campanyemail.text;



                          if(campanyemail.text.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(campanyemail.text)) {
                            Fluttertoast.showToast(
                                msg: 'Email id should have @ and.',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.orange,
                                textColor: Colors.white,

                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                          } else if(campanyname.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please Enter Company Name.',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.orange,
                                textColor: Colors.white,

                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                          }else{
                            setState(() {
                              isLoading = true;
                            });
                            callApi();
                          }
                         /* callApi();
                          setState(() {
                            isLoading = true;
                          });
                          await Future.delayed(const Duration(seconds: 5));
                          setState(() {
                            isLoading = false;
                          });*/
                          /*Navigator.push(context, MaterialPageRoute(builder: (context)=>contactadd()));*/

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
                        const Text('Submit',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                       // child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      )




                  ),
                ],
              ),
            ),
            Center(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left:120,top: 20),
                    color:Colors.deepOrange,

                     // padding: EdgeInsets.only(left: 10,right: 5,top: 10,bottom:10),
                    child: FlatButton.icon(
                      color:Colors.deepOrange,// <-- ElevatedButton

                      icon: Image.asset(
                      "asset/image/scan.png",
                        width: 24.0,
                      ),
                      label: Text('Scan QR code',style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ScannerScreen()));
                      },

                    ),




                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    gettoken();
    super.initState();

  }
}
