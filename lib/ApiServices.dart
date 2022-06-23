import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices{
  Future <LoginApiResponse> apiCallLogin(Map<String,dynamic>param) async{
    var url = Uri.parse('https://www.wenetwork.app/mobile_api_/SignupUsingUserRole_Step1');
    var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(param));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return LoginApiResponse(usertoken: data["userToken"],
        userId: data["userId"],
        firstName: data["firstName"],
        lastName: data["lastName"],
        status: Status.fromjson(data["status"]));
  }

  }

class LoginApiResponse {
  final String? usertoken;
  final String? userId;
  final String? firstName;
  final String? lastName;
  final Status? status;


  LoginApiResponse({this.usertoken,this.userId,this.firstName,this.lastName,this.status});
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
