import 'dart:convert';
import 'package:http/http.dart' as http;

class loginapi{
  Future <loginapiresponse> apicallsignin(Map<String,dynamic>param) async{
    var url = Uri.parse('https://www.wenetwork.app/mobile_api_/Login');
    var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(param));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return loginapiresponse(usertoken: data["userToken"],
        userId: data["userId"],
        email:data["email"],
        firstName: data["firstName"],
        lastName: data["lastName"],
        status: Status.fromjson(data["status"]));
}


}

class loginapiresponse {
  final String? usertoken;
  final String? userId;
  final String? email;
  final String? firstName;
  final String? lastName;
  final Status? status;


  loginapiresponse({this.usertoken,this.userId,this.email,this.firstName,this.lastName,this.status});
}
class Status{
  final int StatusCode;
  final String? Message;

  Status({required this.StatusCode,this.Message});


  factory Status.fromjson(dynamic json){
    return Status(
        StatusCode: json["statusCode"],
        Message: json["message"]
    );
  }
}