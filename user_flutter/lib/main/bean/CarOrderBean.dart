

/**
 * Created by Amuser
 * Date:2023/2/14.
 * Desc:
 */
class CarOrderBean{
  int? goodId;
  int? categoryId;
  int? num;
  List<OrderAttributeBean>? normsList;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['goodId'] = goodId;
    map['categoryId'] = categoryId;
    map['num'] = num;
    if (normsList != null) {
      map['normsList'] = normsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  CarOrderBean(this.goodId, this.categoryId, this.num, this.normsList);

}

class OrderAttributeBean{

  int? normsId;
  int? attributeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['normsId'] = normsId;
    map['attributeId'] = attributeId;

    return map;
  }
  OrderAttributeBean(this.normsId, this.attributeId);
}