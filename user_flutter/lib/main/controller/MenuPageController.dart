import 'package:get/get.dart';
import 'package:user_flutter/base/controller/HttpController.dart';

import '../../ApiConfig.dart';
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

  List<MenuGoodsBean>? _goodsList;

  List<MenuGoodsBean>? get goodsList=>_goodsList;

  /**
   * 获取商品品类
   */
  getCategoryData(String businessLicense) async {

    await  postHeaderData<List<MenuCategoryData>>(ApiConfig.HTTP_MENU_CATEGORY, {
      "businessLicense": businessLicense
    },null, (data){
      if (data != null) {
        _categoryList=data;
        print("是否进来？？？？${_categoryList?[0].categoryName}");
        update();
        return data;
      } else {

      }
    });
    return null;
  }
  /**
   * 获取商品数据
   */
  getShoppingData(String customerAccount,String customerPwd,String businessLicense) async {

    await  postData<List<MenuGoodsBean>>(ApiConfig.HTTP_MENU_GOODS, {
      "businessLicense": businessLicense
    }, (data){
      if (data != null) {
        _goodsList=data;
        update();
        return data;
      } else {

      }
    });
    return null;
  }
}