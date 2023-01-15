import 'MenuGoodsBean.dart';

/**
 * Created by Amuser
 * Date:2022/12/29.
 * Desc:订单Item
 */

class GoodsOrderBean{

  num? goodId;
  String? goodsName;
  String? goodsImage;
  num? categoryId;
  String? normsString;
  String? goodsPrice;
  int? goodsNum;
  List<ListAttribute>? list;

  GoodsOrderBean(this.goodId, this.goodsName, this.goodsImage, this.categoryId,this.normsString,
      this.goodsPrice,this.goodsNum, this.list);
}

