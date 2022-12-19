


import '../../../bean/LoginData.dart';
import '../../../main/bean/MenuCategoryBean.dart';
import '../../../main/bean/MenuGoodsBean.dart';

/**
 * Created by Amuser
 * Date:2019/12/10.
 * Desc:
 */
 class DataJson{
  static T? getDataJson<T>(data){
    switch(T.toString()){
      case "LoginData":
        return LoginData.fromJson(data) as T;
      case "List<MenuCategoryData>":
           List<MenuCategoryData> list=[];
           data.forEach((v){
             list.add(MenuCategoryData.fromJson(v));
           });
        return list as T;
      case "List<MenuGoodsBean>":
        List<MenuGoodsBean> list=[];
        data.forEach((v){
          list.add(MenuGoodsBean.fromJson(v));
        });
        return list as T;
      default:

        return null;
    }
  }
 }