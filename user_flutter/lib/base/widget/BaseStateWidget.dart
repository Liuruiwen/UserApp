import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../res/Dimens.dart';
import 'BaseFulWidget.dart';
import 'dart:convert' as convert;

/**
 * Created by Amuser
 * Date:2019/12/12.
 * Desc:
 */
 class BaseStateWidget<T extends BaseFulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    screen(context);
    return getBuildWidget(context);
  }

  void screen(BuildContext buildContext) {
    initLis(buildContext);
  }


  void initLis(BuildContext buildContext) {

  }

  Color setThemeColor() {
    return Colors.red;
  }


  Widget getBuildWidget(BuildContext buildContext) {
    return new Center(child: new Text("请重新编写widget"),);
  }


  void showToast(String msg) {
    widget.showToast(msg);
  }


  void pushWidget(BuildContext buildContext
      , Widget widget,{bool isClose=false}) {
    if (isClose) {
      Navigator.pushAndRemoveUntil(
          buildContext, new MaterialPageRoute(builder: (BuildContext context) {
        return widget;
      }), (route) => route == null);
    } else {
      Navigator.push(
          buildContext,
          MaterialPageRoute(builder: (context) => widget));
    }
  }

  pushForWidget(BuildContext buildContext
      , Widget widget) async {

    return await Navigator.push( //等待
        buildContext,
        MaterialPageRoute(builder: (context) => widget));
  }


  void closeWidget() {
   Future.delayed(Duration.zero,(){
      Navigator.of(this.context, rootNavigator: true).pop();
      // Navigator.of(context).pop();
    });
  }





  void closePageForWidget(BuildContext buildContext, Widget widget) {
    Navigator.pushAndRemoveUntil(
        buildContext, new MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }), (route) => route == null);
  }

  /**
   * 空状态页
   */
  Widget getEmptyPage() {
    return new Center(
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Image(
                image: new AssetImage('drawable/image/loading_error.jpg'),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: getHeight(Dimens.dp300),
                fit: BoxFit.cover,
              ),
              margin: EdgeInsets.only(left: 80, right: 80, bottom: 30),
            ),
            new Expanded(child:   new Text("亲，系统开小差哦！",style: TextStyle(fontSize: getSp(Dimens.sp30))),)

          ],
        ),
        height:getHeight(Dimens.dp400),
      ),
    );
  }

     getWidth(int width){
    return ScreenUtil().setWidth(width);
    }
   double  getHeight(int height){
     return ScreenUtil().setHeight(height);
   }

    getSp(int sp){
     return  ScreenUtil().setSp(sp);
   }

   getStateWidget(){
    return Container(height: MediaQueryData.fromWindow(window).padding.top,
      color: Colors.blue[500],
    );
   }

   bool isEmpty(String? input){
    return input?.isNotEmpty??false;
   }
 }
