import 'package:flutter/material.dart';

import '../main/bean/UserInfoBean.dart';

/**
 * Created by Amuser
 * Date:2023/2/4.
 * Desc:
 */
class AppProvider extends ChangeNotifier {

  String _token="";


   String getToken(){
     return _token;
   }

   void setToken(String token){
     _token=token;
   }

  UserInfoBean? _userInfoBean;

  UserInfoBean? getUserInfo(){
    return _userInfoBean;
  }

  void setUserInfo(UserInfoBean? bean){

    this._userInfoBean=bean;
    notifyListeners();
  }





}