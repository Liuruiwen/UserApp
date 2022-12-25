/// code : 200
/// message : "????"
/// data : [{"id":40,"goodsName":"???","goodsImage":"http://192.168.1.4:8080/image/48d00ddc-5ef9-420f-9560-42bf15e89d3b.png","categoryId":21,"goodsDesc":"??","goodsPrice":"33.00","monthSales":0,"annualSales":0,"listNorms":[{"id":35,"normsName":"??","businessLicense":"GY11156336987889","categoryId":21,"listAttribute":[{"id":120,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":121,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":123,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":124,"normsAttributeName":"??????","normsId":35,"attributeTime":0,"businessLicense":null}]},{"id":34,"normsName":"??","businessLicense":"GY11156336987889","categoryId":21,"listAttribute":[{"id":115,"normsAttributeName":"q","normsId":34,"attributeTime":0,"businessLicense":null},{"id":116,"normsAttributeName":"g","normsId":34,"attributeTime":0,"businessLicense":null},{"id":119,"normsAttributeName":"k","normsId":34,"attributeTime":0,"businessLicense":null}]}],"shelvesType":1,"goodsPosition":0,"normsList":"[{\"list\":[124,123,121,120],\"normsId\":35},{\"list\":[119,116,115],\"normsId\":34}]"},{"id":42,"goodsName":"???","goodsImage":"http://192.168.1.4:8080/image/44366976-f1db-4eac-b33a-05279bfdb6a5.png","categoryId":21,"goodsDesc":"????????","goodsPrice":"22.00","monthSales":0,"annualSales":0,"listNorms":[{"id":35,"normsName":"??","businessLicense":"GY11156336987889","categoryId":21,"listAttribute":[{"id":120,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":121,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":122,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":123,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":124,"normsAttributeName":"??????","normsId":35,"attributeTime":0,"businessLicense":null}]},{"id":34,"normsName":"??","businessLicense":"GY11156336987889","categoryId":21,"listAttribute":[{"id":115,"normsAttributeName":"q","normsId":34,"attributeTime":0,"businessLicense":null},{"id":116,"normsAttributeName":"g","normsId":34,"attributeTime":0,"businessLicense":null},{"id":117,"normsAttributeName":"l","normsId":34,"attributeTime":0,"businessLicense":null},{"id":119,"normsAttributeName":"k","normsId":34,"attributeTime":0,"businessLicense":null}]}],"shelvesType":1,"goodsPosition":0,"normsList":"[{\"list\":[124,123,122,121,120],\"normsId\":35},{\"list\":[119,117,116,115],\"normsId\":34}]"},{"id":43,"goodsName":"??????","goodsImage":"http://192.168.1.4:8080/image/b6d74a34-92c0-419a-a773-96de97175a8b.png","categoryId":21,"goodsDesc":"????????","goodsPrice":"33.00","monthSales":0,"annualSales":0,"listNorms":[{"id":35,"normsName":"??","businessLicense":"GY11156336987889","categoryId":21,"listAttribute":[{"id":120,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":123,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":124,"normsAttributeName":"??????","normsId":35,"attributeTime":0,"businessLicense":null}]},{"id":34,"normsName":"??","businessLicense":"GY11156336987889","categoryId":21,"listAttribute":[{"id":115,"normsAttributeName":"q","normsId":34,"attributeTime":0,"businessLicense":null},{"id":116,"normsAttributeName":"g","normsId":34,"attributeTime":0,"businessLicense":null},{"id":117,"normsAttributeName":"l","normsId":34,"attributeTime":0,"businessLicense":null},{"id":119,"normsAttributeName":"k","normsId":34,"attributeTime":0,"businessLicense":null}]}],"shelvesType":1,"goodsPosition":0,"normsList":"[{\"list\":[124,123,120],\"normsId\":35},{\"list\":[119,117,116,115],\"normsId\":34}]"}]


/// id : 40
/// goodsName : "???"
/// goodsImage : "http://192.168.1.4:8080/image/48d00ddc-5ef9-420f-9560-42bf15e89d3b.png"
/// categoryId : 21
/// goodsDesc : "??"
/// goodsPrice : "33.00"
/// monthSales : 0
/// annualSales : 0
/// listNorms : [{"id":35,"normsName":"??","businessLicense":"GY11156336987889","categoryId":21,"listAttribute":[{"id":120,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":121,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":123,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":124,"normsAttributeName":"??????","normsId":35,"attributeTime":0,"businessLicense":null}]},{"id":34,"normsName":"??","businessLicense":"GY11156336987889","categoryId":21,"listAttribute":[{"id":115,"normsAttributeName":"q","normsId":34,"attributeTime":0,"businessLicense":null},{"id":116,"normsAttributeName":"g","normsId":34,"attributeTime":0,"businessLicense":null},{"id":119,"normsAttributeName":"k","normsId":34,"attributeTime":0,"businessLicense":null}]}]
/// shelvesType : 1
/// goodsPosition : 0
/// normsList : "[{\"list\":[124,123,121,120],\"normsId\":35},{\"list\":[119,116,115],\"normsId\":34}]"

class MenuGoodsBean {
  MenuGoodsBean(
      this.id,
      this.goodsName,
      this.goodsImage,
      this.categoryId,
      this.goodsDesc,
      this.goodsPrice,
      this.monthSales,
      this.annualSales,
      this.listNorms,
      this.shelvesType,
      this.goodsPosition,
      this.normsList);

  MenuGoodsBean.fromJson(dynamic json) {
    id = json['id'];
    goodsName = json['goodsName'];
    goodsImage = json['goodsImage'];
    categoryId = json['categoryId'];
    goodsDesc = json['goodsDesc'];
    goodsPrice = json['goodsPrice'];
    monthSales = json['monthSales'];
    annualSales = json['annualSales'];
    if (json['listNorms'] != null) {
      listNorms = [];
      json['listNorms'].forEach((v) {
        listNorms?.add(ListNorms.fromJson(v));
      });
    }
    shelvesType = json['shelvesType'];
    goodsPosition = json['goodsPosition'];
    normsList = json['normsList'];
  }
  num? id;
  String? goodsName;
  String? goodsImage;
  num? categoryId;
  String? goodsDesc;
  String? goodsPrice;
  num? monthSales;
  num? annualSales;
  List<ListNorms>? listNorms;
  num? shelvesType;
  num? goodsPosition;
  String? normsList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['goodsName'] = goodsName;
    map['goodsImage'] = goodsImage;
    map['categoryId'] = categoryId;
    map['goodsDesc'] = goodsDesc;
    map['goodsPrice'] = goodsPrice;
    map['monthSales'] = monthSales;
    map['annualSales'] = annualSales;
    if (listNorms != null) {
      map['listNorms'] = listNorms?.map((v) => v.toJson()).toList();
    }
    map['shelvesType'] = shelvesType;
    map['goodsPosition'] = goodsPosition;
    map['normsList'] = normsList;
    return map;
  }


}

/// id : 35
/// normsName : "??"
/// businessLicense : "GY11156336987889"
/// categoryId : 21
/// listAttribute : [{"id":120,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":121,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":123,"normsAttributeName":"??","normsId":35,"attributeTime":0,"businessLicense":null},{"id":124,"normsAttributeName":"??????","normsId":35,"attributeTime":0,"businessLicense":null}]

class ListNorms {
  ListNorms(this.id, this.normsName, this.businessLicense, this.categoryId,
      this.listAttribute);

  ListNorms.fromJson(dynamic json) {
    id = json['id'];
    normsName = json['normsName'];
    businessLicense = json['businessLicense'];
    categoryId = json['categoryId'];
    if (json['listAttribute'] != null) {
      listAttribute = [];
      json['listAttribute'].forEach((v) {
        listAttribute?.add(ListAttribute.fromJson(v));
      });
    }
  }
  num? id;
  String? normsName;
  String? businessLicense;
  num? categoryId;
  List<ListAttribute>? listAttribute;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['normsName'] = normsName;
    map['businessLicense'] = businessLicense;
    map['categoryId'] = categoryId;
    if (listAttribute != null) {
      map['listAttribute'] = listAttribute?.map((v) => v.toJson()).toList();
    }
    return map;
  }


}

/// id : 120
/// normsAttributeName : "??"
/// normsId : 35
/// attributeTime : 0
/// businessLicense : null

class ListAttribute {
  ListAttribute(this.id, this.normsAttributeName, this.normsId,
      this.attributeTime, this.businessLicense,this.isSelect);

  ListAttribute.fromJson(dynamic json) {
    id = json['id'];
    normsAttributeName = json['normsAttributeName'];
    normsId = json['normsId'];
    attributeTime = json['attributeTime'];
    businessLicense = json['businessLicense'];
  }
  num? id;
  String? normsAttributeName;
  num? normsId;
  num? attributeTime;
  dynamic? businessLicense;
  num isSelect=0;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['normsAttributeName'] = normsAttributeName;
    map['normsId'] = normsId;
    map['attributeTime'] = attributeTime;
    map['businessLicense'] = businessLicense;
    return map;
  }


}