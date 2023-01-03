
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
/**
 * Created by Amuser
 * Date:2023/1/3.
 * Desc:
 */
class ToastUntil{
  static void showToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white);
  }
}
