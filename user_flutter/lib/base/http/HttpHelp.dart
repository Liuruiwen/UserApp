

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

import '../Common.dart';
import 'GlobalConfig.dart';
import 'bean/BaseBean.dart';
/**
 * Created by Amuser
 * Date:2019/12/6.
 * Desc:
 */
class HttpHelp {

  static HttpHelp? _instance;

  static HttpHelp? getInstance() {
    if (_instance == null) {
      _instance = HttpHelp();
    }
    return _instance;
  }
  Dio dio = new Dio();
  HttpHelp() {
    // Set default configs
    dio.options.headers = {
      "version":'2.0.9',
      "Authorization":'_token',
      "Accept":"application/json"
    };
    dio.options.baseUrl = Common.BASE_URL;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.interceptors.add(LogInterceptor(responseBody: GlobalConfig.isDebug)); //是否开启请求日志
    dio.interceptors.add(CookieManager(CookieJar()));//缓存相关类，具体设置见https://github.com/flutterchina/cookie_jar

  }

  //get请求
  get<T>(String url,Map<String, dynamic>? queryParameters ,Function successCallBack,Function errorCallBack,[bool? isToast]) async {
   return await _requestHttp<T>(url,null, successCallBack,queryParameters, 'get', null, errorCallBack,isToast??false);
  }

  //get请求
  getHeader<T>(String url,Map<String, dynamic>? header,Map<String, dynamic>? queryParameters ,Function successCallBack,Function errorCallBack,[bool? isToast]) async {
    return await _requestHttp<T>(url,header, successCallBack,queryParameters, 'get', null, errorCallBack,isToast??false);
  }

  //post请求
  post<T>(String url,Map<String, dynamic>? params,Function successCallBack,Function errorCallBack,[bool? isToast]) async {
    return await  _requestHttp<T>(url,null, successCallBack, null,"post", params, errorCallBack,isToast??false);
  }

  //post请求
  postHeader<T>(String url, Map<String, dynamic>? header,params,Function successCallBack,Function errorCallBack,[bool? isToast]) async {
  return await  _requestHttp<T>(url,header, successCallBack, null,"post", params, errorCallBack,isToast??false);
  }

  Future<bool?> _requestHttp<T>(String url,Map<String, dynamic>? header, Function successCallBack,Map<String, dynamic>? queryData,
      [String? method, Map<String, dynamic>?  params, Function? errorCallBack,bool? isToast]) async {
    Response? response;
    try {
      dio.options.headers.addAll({ "token":Common.APP_TOKEN});
      if(header!=null){
        ///显示指定Map的限定类型 动态添加headers
        dio.options.headers.addAll(new Map<String,String>.from(header));
      }
      switch (method) {
        case 'get':
          if(queryData!=null && queryData.isNotEmpty){
            response = await dio.get(url,queryParameters: queryData);
          }else{
            response = await dio.get(url);
          }
          break;
        case 'post':
          if (params != null && params.isNotEmpty) {
            response = await dio.post(url, data:  params);
          }else{
            response = await dio.post(url);
          }
          break;
      }

    }on DioError catch(error) {
      // Response? errorResponse;
      // if (error.response != null) {
      //   errorResponse = error.response;
      // } else {
      //
      //   errorResponse = new Response(statusCode: 1002, new RequestOptions());
      // }
      // if (error.type == DioErrorType.connectTimeout) {
      //   errorResponse?.statusCode = ResultCode.CONNECT_TIMEOUT;
      // }
      // else if (error.type == DioErrorType.receiveTimeout) {
      //   errorResponse?.statusCode = ResultCode.RECEIVE_TIMEOUT;
      // }
      if (GlobalConfig.isDebug) {
        print('请求异常: ' + error.toString());
        print('请求异常url: ' + url);
        print('请求头: ${dio.options.headers}');
      }
      showToast( error.message);
      _error(errorCallBack, error.message);
      return false;
    }
    if (GlobalConfig.isDebug) {
      print('请求url: ' + url);
      print('请求头: ' + dio.options.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
    }
    Map<String, dynamic> dataMap = jsonDecode(response.toString());
    if (dataMap == null || dataMap['state'] == 0) {
      showToast((response?.data??"").toString());
      _error(errorCallBack, '错误码：' + dataMap['errorCode'].toString() + '，' +(response?.data??"").toString());
      return false;
    }else if (successCallBack != null) {

      BaseBean<T> bean=BaseBean.fromJson(dataMap);
      if(bean.code==200){
        successCallBack(bean.data??null);
        return true;
      }else{
        if(isToast==true){
          return false;
        }
        showToast(bean.message??"");
        return false;
      }



    }
  }
  _error(Function? errorCallBack, String error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }

  void showToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white);
  }

}