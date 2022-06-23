import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wenetwork/company_info_Api.dart';
import 'package:wenetwork/main.dart';
import 'package:wenetwork/signuppage.dart';
import 'package:wenetwork/startuppage.dart';

class companyinfo extends StatefulWidget {

  String campany;
  companyinfo({
    required this.campany
});



  @override
  State<companyinfo> createState() => _companyinfoState();
}

class _companyinfoState extends State<companyinfo> {
  bool isLoading= false;
  TextEditingController companyname=TextEditingController();
  TextEditingController introbusiness=TextEditingController();
  TextEditingController challenges=TextEditingController();



  String token ="";
  callcompanyApi(){
    final service= CompanyInformation();







    service.apiCallcompany({
      "UserToken": token,
      "CompanyName": companyname.text,
      "CompanyDescription":introbusiness.text,
      "CoreChallenge":challenges.text,

    }).then((value) async {
      if(value.status!.StatusCode==200){
        SharedPreferences prefr= await SharedPreferences.getInstance();
        prefr.setString("UserToken",value.usertoken??"");
        prefr.setInt("UserId",value.companyId??1);
        prefr.setString("CompanyName", companyname.text??"");
        prefr.setString("CompanyDescription", introbusiness.text??"");
        prefr.setString("CoreChallenge", challenges.text??"");



        if(widget.campany=="business") {
            Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => startuppage(fromscreen: "business",))

            );
          }else
          {
            Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => signuppage()));
          }





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
  getToken() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    setState((){
      token=pref.getString("UserToken")??"";

    });
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
      body: SingleChildScrollView(
        child: Column(
          children:[
            Row(
              children: [
                Container(

                padding: EdgeInsets.only(top: 30),
                  margin: EdgeInsets.only(top: 20,left:10),
                  child: Text('Company Information',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                )
              ],
            ),
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Container(
                      margin:EdgeInsets.only(top: 30,left: 10,bottom: 10),
                        child:Text("Organization or Individual Name",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(

                        cursorColor: Colors.black,
                        style: TextStyle(color:Colors.grey,),
                        decoration: InputDecoration(
                          hintText: "e.g. The people\'s bakery inc.",
                         hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                            fillColor: Colors.white,
                          filled: true,
                          disabledBorder: InputBorder.none,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),

                        ),
                        controller: companyname,

                      ),
                    ),


                  ],

                ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30,left: 10,bottom: 10),
                  child:Text("Introduce your business(Optional)",
                    style: TextStyle(color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),)
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: TextFormField(

                    minLines: 1,
                    maxLines: 5,
                    keyboardType:TextInputType.multiline,

                    cursorColor: Colors.black,
                    style: TextStyle(color:Colors.grey,),
                    decoration: InputDecoration(
                        hintText: "  Tell us about your business. This helps our network\n  members to discover and  learn more about your\n  projects.",
                        hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey,),
                        fillColor: Colors.white,
                        filled: true,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 40,top: 10,left: 10),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),


                    ),

                    controller: introbusiness,

                  ),
                ),

              ],

            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:EdgeInsets.only(top: 30,left: 10,bottom: 10),
                    child:Text("What are your core challenges? (Optional)",
                      style: TextStyle(color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),)
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 30),
                  child: TextFormField(

                    minLines: 1,
                    maxLines: 5,
                    keyboardType:TextInputType.multiline,

                    cursorColor: Colors.black,
                    style: TextStyle(color:Colors.grey,),
                    decoration: InputDecoration(


                      hintText: " e.g. scaling, technology, marketing",
                      hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 40,top: 10,left: 10),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),


                    ),

                    controller: challenges,

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
                          String firstname = prefr.getString("CompanyName")??"";
                          print(firstname);
                          String text1= companyname.text;
                          String text2=introbusiness.text;
                          String text3= challenges.text;


                          if(text1==''||text2==''||text3==''){
                            Fluttertoast.showToast(
                                msg: "Please Fill Correct Data",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          }else{
                            setState(() {
                              isLoading = true;
                            });
                            callcompanyApi();
                          }




                     /*     callcompanyApi();
                          setState(() {
                            isLoading = true;
                          });
                          await Future.delayed(const Duration(seconds: 3));
                          setState(() {
                            isLoading = false;
                          });*/
                        /*if(widget.campany=="business") {
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => startuppage())

                          );
                        }else
                          {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => signuppage()));
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
                        const Text('Next',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                       // child: Text('Next',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      )




                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      color: Colors.black,
                      margin: EdgeInsets.only(left: 140),
                          child: FlatButton(
                            color: Colors.black,
                            onPressed: () {
                            if(widget.campany=="business") {
                            Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) => startuppage(fromscreen: "business",))

                            );
                            }else
                            {
                            Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) => signuppage()));
                            }
                            },
                          child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          Text('Skip this step',style: TextStyle(color: Colors.white),), // <-- Text
                          SizedBox(
                          width: 5,
                          ),
                          Icon( // <-- Icon
                          Icons.arrow_right_alt_sharp,color: Colors.white,
                          size: 24.0,
                          ),
                          ],
                          ),
                          ),

                      ),

                  ],
                )
              ],
            )


              ],
            ),
      )
      

    );
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }
}
