import 'dart:convert';
import 'package:http/http.dart' as http;

class esgapi{
  Future <EsgApiResponse> apiCallEsg(Map<String,dynamic>param) async{
    var url = Uri.parse('https://www.wenetwork.app/mobile_api_/CreateSubnetNetwork');
    var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(param));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return EsgApiResponse(usertoken: data["userToken"],
        subnetworkId: data["subnetworkId"],
        subnetworkName: data["subnetworkName"],
        status: Status.fromjson(data["status"]));
  }

}

class EsgApiResponse {
  final String? usertoken;
  final int?   subnetworkId;
  final String? subnetworkName;
  final String? lastName;
  final Status? status;
  EsgApiResponse({this.usertoken,this.subnetworkId,this.subnetworkName,this.lastName,this.status});
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