import 'package:user_flutter/base/controller/BaseController.dart';

import '../http/HttpHelp.dart';

/**
 * Created by Amuser
 * Date:2022/11/21.
 * Desc:
 */
class HttpController extends BaseController{
  getData<T>(String url, callBack(t),[bool isToast=false]) async {
    return await HttpHelp.getInstance()?.get<T>(url, null, (t) {
      callBack(t);
    }, (e) {
      callBack(null);
    },isToast);
  }

  postData<T>(String url, Map<String, dynamic> params, callBack(t),[bool isToast=false]) async {
    return await HttpHelp.getInstance()?.post<T>(url, params, (t) {
      callBack(t);
    }, (e) {
      callBack(null);
    },isToast);
  }
}