import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:user_flutter/base/controller/HttpController.dart';
import 'package:user_flutter/bean/LoginData.dart';

import '../../ApiConfig.dart';

/**
 * Created by Amuser
 * Date:2022/11/21.
 * Desc:
 */
class LoginController extends HttpController{

  static LoginController get to => Get.find();

   LoginData? _loginData;

  LoginData? get loginData=>_loginData;

     getLoginData(String customerAccount,String customerPwd,String businessLicense) async {

    await  postData<LoginData>(ApiConfig.HTTP_LOGIN, {
      "customerAccount": customerAccount,
      "customerPwd": customerPwd,
      "businessLicense": businessLicense,
    }, (data){
      if (data != null) {
        _loginData=data;
        update();
        return data;
      } else {

      }
    });
    return null;
  }
}