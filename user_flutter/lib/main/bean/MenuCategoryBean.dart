import 'MenuGoodsBean.dart';

/// code : 200
/// message : "请求成功"
/// data : [{"id":21,"categoryName":"绿茶","categoryPosition":1,"categoryDesc":"绿茶透心梅，还是头一回","businessLicense":"GY11156336987889"},{"id":2,"categoryName":"霸王奶茶","categoryPosition":2,"categoryDesc":"就要和喜欢的人一起喝","businessLicense":"GY11156336987889"},{"id":3,"categoryName":"霸气水果茶","categoryPosition":3,"categoryDesc":"怎么能没有水果茶尼","businessLicense":"GY11156336987889"},{"id":18,"categoryName":"其它","categoryPosition":4,"categoryDesc":"喝热的得得得","businessLicense":"GY11156336987889"},{"id":5,"categoryName":"宝藏鲜奶茶","categoryPosition":8,"categoryDesc":"不一样的味道哦","businessLicense":"GY11156336987889"},{"id":19,"categoryName":"开心宝贝","categoryPosition":11,"categoryDesc":"要开开心心的哦","businessLicense":"GY11156336987889"}]
/// id : 21
/// categoryName : "绿茶"
/// categoryPosition : 1
/// categoryDesc : "绿茶透心梅，还是头一回"
/// businessLicense : "GY11156336987889"
class MenuCategoryData {


  MenuCategoryData.fromJson(dynamic json) {
    id = json['id'];
    categoryName = json['categoryName'];
    categoryPosition = json['categoryPosition'];
    categoryDesc = json['categoryDesc'];
    businessLicense = json['businessLicense'];
    if (json['goodsList'] != null) {
      goodsList = [];
      json['goodsList'].forEach((v) {
        goodsList?.add(MenuGoodsBean.fromJson(v));
      });
    }
  }
  int? id;
  String? categoryName;
  int? categoryPosition;
  String? categoryDesc;
  String? businessLicense;
  List<MenuGoodsBean>? goodsList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['categoryName'] = categoryName;
    map['categoryPosition'] = categoryPosition;
    map['categoryDesc'] = categoryDesc;
    map['businessLicense'] = businessLicense;
    if (goodsList != null) {
      map['goodsList'] = goodsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  MenuCategoryData(this.id, this.categoryName, this.categoryPosition,
      this.categoryDesc, this.businessLicense,this.goodsList);
}