import 'dart:convert';
import 'package:http/http.dart' as http;

class addanotherApi{
  Future <addanotherApiResponse> apiCalladdanother(Map<String,dynamic>param) async{
    var url = Uri.parse('https://www.wenetwork.app/mobile_api_/AddContactToSubNetwork');
    var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(param));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return addanotherApiResponse(usertoken: data["userToken"],
        contactId: data["contactId"],
        status: Status.fromjson(data["status"]));
  }

}

class addanotherApiResponse {
  final String? usertoken;
  final int?   contactId;
  final Status? status;

  addanotherApiResponse({this.usertoken,this.contactId,this.status});

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