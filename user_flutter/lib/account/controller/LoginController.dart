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

  getLoginData(String customerAccount, String customerPwd,
      String businessLicense) async {
    await postData<LoginData>(ApiConfig.HTTP_LOGIN, {
      "customerAccount": customerAccount,
      "customerPwd": customerPwd,
      "businessLicense": businessLicense,
    }, (data) {
      if (data != null) {
        _loginData = data;
        Common.APP_TOKEN=_loginData?.token??"";
        update();
        return data;
      } else {}
    });
    return null;
  }


  getUserInfo() async {
    await post<UserInfoBean>(ApiConfig.HTTP_USER_INFO,(data) {
      if (data != null) {
        _userInfoBean = data;
        update();
        return data;
      } else {}
    });
    return null;
  }
}
