import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:user_flutter/base/controller/HttpController.dart';
import 'package:user_flutter/account/bean/LoginData.dart';

import '../../ApiConfig.dart';
import '../../base/Common.dart';
import '../../main/bean/UserInfoBean.dart';

/**
 * Created by Amuser
 * Date:2022/11/21.
 * Desc:
 */
class LoginController extends HttpController {
  static LoginController get to => Get.find();

  LoginData? _loginData;

  LoginData? get loginData => _loginData;

  UserInfoBean? _userInfoBean;

  UserInfoBean? get userInfoBean => _userInfoBean;

  /**
   * 登录
   */
  getLoginData(String customerAccount, String customerPwd,
      String businessLicense) async {
    await postData<LoginData>(ApiConfig.HTTP_LOGIN, {
      "customerAccount": customerAccount,
      "customerPwd": customerPwd,
      "businessLicense": businessLicense,
    }, (data) {
      if (data != null) {
        print("到这里来了");
        _loginData = data;
        Common.APP_TOKEN=_loginData?.token??"";
        update();
        return data;
      } else {}
    });
    return null;
  }


  /**
   * 获取用户信息
   */
  getUserInfo() async {
    await post<UserInfoBean>(ApiConfig.HTTP_USER_INFO,(data) {
      if (data != null) {
        print("会走这里？？？===getUserInfo");
        _userInfoBean = data;
        update();
        return data;
      } else {}
    });
    return null;
  }


  /**
   * 注册
   */
  register(String customerAccount, String customerPwd,
      String businessLicense) async {
    await postData<LoginData>(ApiConfig.HTTP_REGISTER, {
      "customerAccount": customerAccount,
      "customerPwd": customerPwd,
      "businessLicense": businessLicense,
    }, (data) {
      if (data != null) {
        print("到这里来了注册");
        _loginData = data;
        Common.APP_TOKEN=_loginData?.token??"";
        update();
        return data;
      } else {}
    });
    return null;
  }


  /**
   * 清除缓存数据
   */
  clearData(){
    _userInfoBean=null;
    _loginData=null;
  }
}
