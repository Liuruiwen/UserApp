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

  getHeaderData<T>(String url, Map<String, dynamic> header, callBack(t),[bool isToast=false]) async {
    return await HttpHelp.getInstance()?.getHeader<T>(url,header, null, (t) {
      callBack(t);
    }, (e) {
      callBack(null);
    },isToast);
  }


  post<T>(String url,  callBack(t),[bool isToast=false]) async {
    return await HttpHelp.getInstance()?.post<T>(url, {}, (t) {
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

  postDatas<T>(String url, Map<String, dynamic> params, callBack(t),errorBack(e),[bool isToast=false]) async {
    return await HttpHelp.getInstance()?.post<T>(url, params, (t) {
      callBack(t);
    }, (e) {
      errorBack(e);
    },isToast);
  }

  postHeaderData<T>(String url,Map<String, dynamic> header, Map<String, dynamic>? params, callBack(t),[bool isToast=false]) async {
    return await HttpHelp.getInstance()?.postHeader<T>(url,header, params, (t) {
      callBack(t);
    }, (e) {
      callBack(null);
    },isToast);
  }


}

