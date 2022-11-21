


import '../../../bean/Data.dart';

/**
 * Created by Amuser
 * Date:2019/12/10.
 * Desc:
 */
 class DataJson{
  static T? getDataJson<T>(data){
    switch(T.toString()){
      // case "List<BannerBean>":
      //   List<BannerBean> list=new List();
      //   data.forEach((v){
      //     list.add(BannerBean.fromJson(v));
      //   });
      //  return   list as T;

      case "LoginData":
        return LoginData.fromJson(data) as T;
      default:

        return null;
    }
  }
 }