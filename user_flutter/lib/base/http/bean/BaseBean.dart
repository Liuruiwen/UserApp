import 'DataJson.dart';
/**
 * Created by Amuser
 * Date:2019/12/10.
 * Desc:
 */
class BaseBean<T> {
  int? code;
  String? message;
  T? data;

  BaseBean(this.code, this.message, this.data);

  BaseBean.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    data = json['data']==null?null:DataJson.getDataJson(json['data']);
  }
}