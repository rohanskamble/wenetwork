import 'dart:convert';
import 'package:http/http.dart' as http;


class CompanyInformation{
  Future <CompanyinfoApiResponse> apiCallcompany(Map<String,dynamic>param) async{
    var url = Uri.parse('https://www.wenetwork.app/mobile_api_/UpdateCompanyInformation');
    var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(param));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return CompanyinfoApiResponse(usertoken: data["userToken"],
        companyId: data["companyId"],
        status: Status.fromjson(data["status"]));
  }

}

class CompanyinfoApiResponse {
  final String? usertoken;
  final int? companyId;
  final Status? status;

  CompanyinfoApiResponse({this.usertoken,this.companyId,this.status});

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