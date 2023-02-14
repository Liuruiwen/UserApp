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

  var _orderState=false;//用户下单是否成功

  bool get orderState=>_orderState;


  int _categorySelectPosition=0;

  int get selectPosition=>_categorySelectPosition;


  var _categoryPosition=Map();
  Map? get categoryPosition=>_categoryPosition;

  String? _countPrice="0.0";

  String? get countPrice=>_countPrice;

  int _orderNum=0;

  int get orderNum=>_orderNum;


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
   * 用户下单
   */
  userPlaceOrder(String orderTime,int  goodsNum,String goodsPrice,String businessLicense,String goodGroup) async {

    await  postDatas<List<MenuCategoryData>>(ApiConfig.HTTP_PLACE_ORDER, {
      "orderTime": orderTime,
      "goodsNum": goodsNum,
      "goodsPrice": goodsPrice,
      "businessLicense": businessLicense,
      "goodGroup": goodGroup,
    }, (data){
      _orderState=true;
      clearCarData();
      update();
      return data;
    },(e){
      _orderState=false;
      update();
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
      double price=0.0;
      double goodsPrice=double.parse(bean.goodsPrice??"0")*(bean.goodsNum??1);
      var num=bean.goodsNum??1;
      _orderNum=_orderNum+num;
      price=price+goodsPrice;
      _goodsOrderList.add(bean);
      _countPrice=price.toString();
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
      _orderNum=_orderNum+1;
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
      _orderNum=_orderNum-1;
      update();
    }else{
      print("他们就是空啊===");
    }

    update();
  }

  /**
   * 清空购物车数据
   */
  clearCarData(){
      _goodsOrderList.clear();
      _countPrice="0.0";
      _orderNum=0;
  }


}