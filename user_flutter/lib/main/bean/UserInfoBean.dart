/// id : 5
/// name : "小兔兔"
/// age : "18"
/// sex : "-1"
/// phone : "13333333333"
/// userId : 8
/// headerImage : ""
/// level : 1
/// businessLicense : "GY11156336987889"

class UserInfoBean {


  UserInfoBean(this.id, this.name, this.age, this.sex, this.phone, this.userId,
      this.headerImage, this.level, this.businessLicense);
  UserInfoBean.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    sex = json['sex'];
    phone = json['phone'];
    userId = json['userId'];
    headerImage = json['headerImage'];
    level = json['level'];
    businessLicense = json['businessLicense'];
  }
  num? id;
  String? name;
  String? age;
  String? sex;
  String? phone;
  num? userId;
  String? headerImage;
  num? level;
  String? businessLicense;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['age'] = age;
    map['sex'] = sex;
    map['phone'] = phone;
    map['userId'] = userId;
    map['headerImage'] = headerImage;
    map['level'] = level;
    map['businessLicense'] = businessLicense;
    return map;
  }


}




