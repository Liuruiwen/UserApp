import 'Data.dart';

class UserLogin {
  UserLogin({
      this.code, 
      this.message, 
      this.data,});

  UserLogin.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }
  int? code;
  String? message;
  LoginData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}