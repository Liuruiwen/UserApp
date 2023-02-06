import 'package:get/get.dart';

import '../../ApiConfig.dart';
import '../../base/controller/HttpController.dart';
import '../bean/UserInfoBean.dart';

/**
 * Created by Amuser
 * Date:2023/2/6.
 * Desc:
 */
class MinePageController extends HttpController{

  static MinePageController get to => Get.find();

  UserInfoBean? _userInfoBean;

  UserInfoBean? get userInfoBean => _userInfoBean;

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