import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:user_flutter/base/widget/BaseStateWidget.dart';

import '../../base/Common.dart';
import '../../base/widget/BaseFulWidget.dart';
import '../../res/Colours.dart';
import '../bean/CarOrderBean.dart';
import '../bean/GoodsOrderBean.dart';
import '../controller/MenuPageController.dart';

/**
 * Created by Amuser
 * Date:2022/12/10.
 * Desc:菜单页
 */
class CarPageWidget extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CarPageWidget();
  }
}

class _CarPageWidget extends BaseStateWidget<CarPageWidget> {
  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return GetBuilder<MenuPageController>(
        init: MenuPageController(),
        builder: (_) => Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  getHeader(),
                  Expanded(
                      child: Container(
                    color: Colors.white,
                    child: _getBody(MenuPageController.to.goodsOrderList),
                  )),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colours.grey_bg_f2, width: 1.0)),
                  ),
                  Divider(height: 1.5, indent: 0, color: Colours.grey_bg_f2),
                  _bottomMenu()
                ],
              ),
            ));
  }

  Widget getHeader() {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQueryData.fromWindow(window)
              .padding
              .top), //如果需要获取window,需要导入import 'dart:ui';
      color: Colours.blue_bg,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(45),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Center(
                child: Text(
                  "购物车",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(24),
                      color: Colors.white),
                ),
              ),
            )),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                height: ScreenUtil().setHeight(45),
                child: Center(
                  child: Text(
                    "管理",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: Colours.text_E5E5E5),
                  ),
                ),
              ),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _getBody(List<GoodsOrderBean>? list) {
    return list == null
        ? Container()
        : ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, position) {
              final counter = Get.put(MenuPageController());
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _imageWrapper(list[position].goodsImage ?? ""),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.fromLTRB(8, 0, 0, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[position].goodsName ?? "",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: Colours.text_dark),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                            child: Text(
                              "规格:${list[position].normsString ?? ""}",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12),
                                  color: Colours.text_gray),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "￥",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(10),
                                      color: Colours.text_red_EF5350),
                                ),
                               Expanded(child:  Text(
                                 "${list[position].goodsPrice ?? ""}",
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: ScreenUtil().setSp(18),
                                     color: Colours.text_red_EF5350),
                               )),
                                Container(
                                  height: ScreenUtil().setHeight(30),
                                  width: ScreenUtil().setWidth(110),
                                  margin: EdgeInsets.only(right: 16),
                                  alignment: Alignment.topRight,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    border: Border.all(
                                        width: 1, color: Colours.divider),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                        width: ScreenUtil().setWidth(30),
                                        alignment: Alignment.center,
                                        child: Text("—",
                                            style: TextStyle(color: list[position].goodsNum==1?Colours.text_gray:Colours.text_dark,fontSize:ScreenUtil().setSp(14))),
                                      ),
                                        onTap: (){
                                          counter.cutGoodsNum(position,1);
                                        },
                                      ),
                                      VerticalDivider(
                                        color: Colours.divider,
                                        width: 1,
                                      ),
                                      Expanded(child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${list[position].goodsNum ?? "1"}",
                                          style: TextStyle(color: Colours.text_dark,fontSize:ScreenUtil().setSp(14) ),),
                                      )),
                                      VerticalDivider(
                                        color: Colours.divider,
                                        width: 1,
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: ScreenUtil().setWidth(30),
                                          child: Text("+",
                                            style: TextStyle(color: Colours.text_dark,fontSize:ScreenUtil().setSp(14))),
                                        ),
                                        onTap: () {
                                          counter.addGoodsNum(position,1);
                                          
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Divider(
                                height: 2.5,
                                indent: 0,
                                color: Colours.divider),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              );
            });
  }

  Widget _imageWrapper(String imageUrl) {
    return SizedBox(
      width: ScreenUtil().setWidth(100),
      height: ScreenUtil().setHeight(100),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) =>
            Image.asset('images/drawable-xxhdpi/gift_bill_list_empty.png'),
        errorWidget: (context, url, error) =>
            Image.asset('images/drawable-xhdpi/loading_error.jpg'),
      ),
    );
  }

  Widget _bottomMenu() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Baseline(
            baseline: 40,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              "合计：",
              style: TextStyle(
                  color: Colours.text_dark, fontSize: ScreenUtil().setSp(14)),
            ),
          ),
          Baseline(
            baseline: 40,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              "￥",
              style: TextStyle(
                color: Colours.text_red_EF5350,
                height: 1.1,
                fontSize: ScreenUtil().setSp(8),
              ),
              textAlign: TextAlign.end,
            ),
          ),
          Baseline(
            baseline: 40,
            baselineType: TextBaseline.alphabetic,
            child: Text("${MenuPageController.to.countPrice}",
                style: TextStyle(
                    color: Colours.text_red_EF5350,
                    height: 1.1,
                    fontSize: ScreenUtil().setSp(18)),
                textAlign: TextAlign.end),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colours.blue_bg,
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  //设置四周边框
                  border: new Border.all(width: 1, color: Colours.blue_bg),
                ),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Text(
                  "去结算",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () async{
                DateTime today = new DateTime.now();
                String orderTime ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
                // CarOrderBean
                final carController = Get.put(MenuPageController());
               if( carController.goodsOrderList?.isNotEmpty==true){
                 var list=<CarOrderBean>[];
                 carController.goodsOrderList?.forEach((v){

                      var normList=<OrderAttributeBean>[];
                          v.list?.forEach((element) {
                               normList.add(OrderAttributeBean(element.normsId?.toInt(),element.id?.toInt()));
                          });
                      list.add(CarOrderBean(v.goodId?.toInt(), v.categoryId?.toInt(), v.goodsNum, normList));
                 });
                 String dataList = json.encode(list);
                 print("当前时间：$dataList");
              await   MenuPageController.to.userPlaceOrder(orderTime, MenuPageController.to.orderNum,MenuPageController.to.countPrice.toString(),Common.SHOP_TOKEN,dataList);

                if(MenuPageController.to.orderState){
                  showToast("下单成功！");
                }
               }

              },
            ),
          ))
        ],
      ),
    );
  }
}
