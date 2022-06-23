import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class logoutapi{
  Future <Logoutresponce> apiCallLogout(Map<String,dynamic>param) async{
    var url = Uri.parse('https://www.wenetwork.app/mobile_api_/LogOut');
    var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(param));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return Logoutresponce(
        status: Status.fromjson(data["status"]));
  }

}

class Logoutresponce {
  final Status? status;


  Logoutresponce({this.status});
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
