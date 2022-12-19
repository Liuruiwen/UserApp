class LoginData {
  LoginData({
      this.customerAccount, 
      this.token,});

  LoginData.fromJson(dynamic json) {
    customerAccount = json['customerAccount'];
    token = json['token'];
  }
  String? customerAccount;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customerAccount'] = customerAccount;
    map['token'] = token;
    return map;
  }

}