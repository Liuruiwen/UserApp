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

  List<MenuCategoryData>? _categoryList;//获取品类列表

  List<MenuCategoryData>? get categoryList=>_categoryList;

  var _goodsList=<MenuGoodsBean>[];//获取商品列表

  List<MenuGoodsBean>? get goodsList=>_goodsList;


  var _goodsOrderList=<GoodsOrderBean>[];//获取订单列表

  List<GoodsOrderBean>? get goodsOrderList=>_goodsOrderList;


  int _categorySelectPosition=0;

  int get selectPosition=>_categorySelectPosition;


  var _categoryPosition=Map();
  Map? get categoryPosition=>_categoryPosition;

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
        var dataLength=_categoryList?.length??1;
        for(var i = 0;i < dataLength;i++){
          var element=_categoryList?[i];
          _categoryPosition[element?.id]=i;
          if( element?.goodsList!=null){
            var list=element?.goodsList??[];
            _goodsList.addAll(list);
          }
        }
        update();
        return data;
      } else {

      }
    });
    return null;
  }


  /**
   * 品类选中处理
   */
  updateGoods(int position){
    // _goodsList=list;
    _categorySelectPosition=position;
    update();
  }

  /**
   * 加入购物车处理
   */
  addGoodsOrderBean(GoodsOrderBean? bean){
    if(bean!=null){
      _goodsOrderList.add(bean);
      double count=0.0;
      _goodsOrderList.forEach((element) {
        double goodsPrice=double.parse(element.goodsPrice??"0")*(element.goodsNum??1);
         count=count+goodsPrice;
      });
      _countPrice=count.toString();
      update();
    }

  }

  /**
   * 增加商品数量
   */
  addGoodsNum(int position,int count){
    if(goodsOrderList!=null&&goodsOrderList!.length>0){
      int goodsNum=goodsOrderList?[position].goodsNum??1;
      goodsOrderList?[position].goodsNum=goodsNum + count;
      double price=double.parse(_countPrice??"0.0")+double.parse(goodsOrderList?[position].goodsPrice??"0");
      _countPrice=price.toString();
      update();
    }else{
      print("他们就是空啊===");
    }

  }

  /**
   * 减少商品数量
   */
  cutGoodsNum(int position,int count){

    if(goodsOrderList!=null&&goodsOrderList!.length>0){
      int goodsNum=goodsOrderList?[position].goodsNum??1;
      if(goodsNum==1){
        return;
      }
      goodsOrderList?[position].goodsNum=goodsNum - count;
      double price=double.parse(_countPrice??"0.0")-double.parse(goodsOrderList?[position].goodsPrice??"0");
      _countPrice=price.toString();
      update();
    }else{
      print("他们就是空啊===");
    }

    update();
  }


}