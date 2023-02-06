import 'package:flutter/src/widgets/framework.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_flutter/account/bean/LoginData.dart';

import '../../ApiConfig.dart';
import '../../base/bloc/HttpBloc.dart';

/**
 * Created by Amuser
 * Date:2022/11/1.
 * Desc:
 */
class LoginBloc extends HttpBloc{
  BehaviorSubject<LoginData> _queryData = BehaviorSubject<LoginData>();
  Stream<LoginData> get queryStream => _queryData.stream;


  @override
  void dispose() {
    _queryData.close();
  }

  @override
  Future initData(BuildContext context) async{
     showDialogs(context);
     await getLoginData("13333333333","123456","GY11156336987889");
     closeDialog(context);
  }



  getLoginData(String customerAccount,String customerPwd,String businessLicense) async {

    await  postData<LoginData>(ApiConfig.HTTP_LOGIN, {
      "customerAccount": customerAccount,
      "customerPwd": customerPwd,
      "businessLicense": businessLicense,
    }, (data){
      if (data != null) {
        _queryData.add(data);
      } else {

      }
    });
    return;
  }

}