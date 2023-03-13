import 'package:get/get.dart';

import '../../ApiConfig.dart';
import '../../base/controller/HttpController.dart';
import '../bean/UserOrderBean.dart';

/**
 * Created by Amuser
 * Date:2023/3/6.
 * Desc:
 */
class UserOrderController  extends HttpController{

static UserOrderController get to => Get.find();

UserOrderBean? _userOrderBean;

UserOrderBean? get userInfoBean => _userOrderBean;

 getOrderList(int pageNum,int pageSize,String customerAccount,int orderState ) async {
   await  postData<UserOrderBean>(ApiConfig.HTTP_USER_ORDER_LIST, {
    "pageNum": pageNum,
    "pageSize": pageSize,
    "customerAccount": customerAccount,
    "orderState": orderState,
  }, (data){
    print("无语==========");
    if (data != null) {
      _userOrderBean=data;
      print("oopoppppppppppppppp==========${_userOrderBean?.list?.length??0}");
      update();
      return data;
    } else {
         print("让我说点少时诵诗书所所所所所所==========");
    }
  });
  return null;
}


}