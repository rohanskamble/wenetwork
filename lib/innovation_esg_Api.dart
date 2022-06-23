import 'dart:convert';
import 'package:http/http.dart' as http;


class innovationesgapi{
  Future <InnovationApiResponse> apiCallinnovation(Map<String,dynamic>param) async{
    var url = Uri.parse('https://www.wenetwork.app/mobile_api_/CreateSubnetNetwork');
    var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(param));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return InnovationApiResponse(usertoken: data["userToken"],
        subnetworkId: data["subnetworkId"],
        subnetworkName: data["subnetworkName"],
        status: Status.fromjson(data["status"]));
  }

}

class InnovationApiResponse {
  final String? usertoken;
  final int?   subnetworkId;
  final String? subnetworkName;
  final Status? status;

  InnovationApiResponse({this.usertoken,this.subnetworkId,this.subnetworkName,this.status});
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