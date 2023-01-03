import 'package:get/get.dart';
import 'package:user_flutter/base/controller/HttpController.dart';

import '../../ApiConfig.dart';
import '../bean/GoodsOrderBean.dart';
import '../bean/MenuCategoryBean.dart';
import '../bean/MenuGoodsBean.dart';

/**
 * Created by Amuser
 * Date:2022/12/14.
 * Desc:
 */
class MenuPageController extends HttpController{
  static MenuPageController get to => Get.find();

  List<MenuCategoryData>? _categoryList;

  List<MenuCategoryData>? get categoryList=>_categoryList;

  var _goodsList=<MenuGoodsBean>[];

  List<MenuGoodsBean>? get goodsList=>_goodsList;


  var _goodsOrderList=<GoodsOrderBean>[];

  List<GoodsOrderBean>? get goodsOrderList=>_goodsOrderList;

  String? _countPrice="0.0";

  String? get countPrice=>_countPrice;


  /**
   * 获取商品数据
   */
  getGoodsData(String businessLicense) async {

    await  postData<List<MenuCategoryData>>(ApiConfig.HTTP_MENU_GOODS, {
      "businessLicense": businessLicense
    }, (data){
      if (data != null) {
        _categoryList=data;
        _categoryList?.forEach((element) {
           if( element.goodsList!=null){
             _goodsList..addAll(element.goodsList!);
           }
        });
        update();
        return data;
      } else {

      }
    });
    return null;
  }

  addGoodsOrderBean(GoodsOrderBean? bean){
    if(bean!=null){
      _goodsOrderList.add(bean);
      double count=0.0;
      _goodsList.forEach((element) {
         count=count+double.parse(element.goodsPrice??"0");
      });
      _countPrice=count.toString();
      update();
    }

  }
}