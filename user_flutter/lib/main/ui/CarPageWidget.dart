import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:user_flutter/base/widget/BaseStateWidget.dart';

import '../../base/widget/BaseFulWidget.dart';
import '../../res/Colours.dart';
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
    return   GetBuilder<MenuPageController>(
        init: MenuPageController(),
        builder: (_)=>Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getHeader(),
              Expanded(child: _getBody(MenuPageController.to.goodsOrderList)),
              DecoratedBox(
                decoration:BoxDecoration(
                    border:Border.all(color: Colours.grey_bg_f2,width: 1.0)
                ),
              ),
              _bottomMenu()
            ],
          ),
        )
    );
  }



  Widget getHeader(){
     return Container(
           padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
           color: Colours.blue_bg,
           width: MediaQuery.of(context).size.width,
           height: ScreenUtil().setHeight(45),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Center(child: Text("购物车",style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(24),color: Colors.black),),),
               Expanded(child: Align(
                   alignment: Alignment.topRight,
                   child: GestureDetector(
                     child: Container(
                       padding: EdgeInsets.fromLTRB(0,0,16,0),
                       height:ScreenUtil().setHeight(45),
                       child: Center(child: Text("管理",style: TextStyle(fontSize: ScreenUtil().setSp(14),color: Colours.text_dark),),
                       ),
                     ),
                     onTap: (){

                     },
                   )))
             ],
           ),
     );
  }

  Widget _getBody(List<GoodsOrderBean>? list){
    return list==null?Container():ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,position){
         return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _imageWrapper(list[position].goodsImage??""),
                  Container(
                    margin:EdgeInsets.fromLTRB(8, 0, 0, 16),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                           Text(list[position].goodsName??"",style: TextStyle(fontSize: ScreenUtil().setSp(14),color: Colours.text_dark),),
                           Container(
                             margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                             child: Text("规格:${list[position].normsString??""}",style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colours.text_gray),),),
                           Container(
                             margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                  Text("￥",style: TextStyle(fontSize: ScreenUtil().setSp(10),color: Colours.text_red_EF5350),),
                                  Text("${list[position].goodsPrice??""}",style: TextStyle(fontWeight:FontWeight.bold,fontSize: ScreenUtil().setSp(18),color: Colours.text_red_EF5350),)
                                  
                               ],
                             ),
                           )
                    ],
                  ),)
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
        placeholder: (context, url) => Image.asset('images/drawable-xxhdpi/gift_bill_list_empty.png'),
        errorWidget: (context, url, error) =>
            Image.asset('images/drawable-xhdpi/loading_error.jpg'),
      ),
    );
  }

  Widget _bottomMenu(){
    return Container(
      padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("合计：",style: TextStyle(color: Colours.text_dark,fontSize: ScreenUtil().setSp(14)),),
          Text("￥",style: TextStyle(color: Colours.text_red_EF5350,fontSize: ScreenUtil().setSp(12),),textAlign: TextAlign.end,),
          Text("${MenuPageController.to.countPrice}",style: TextStyle(color: Colours.text_red_EF5350,fontSize: ScreenUtil().setSp(18)),),
          Expanded(child: Align(
            alignment: Alignment.topRight,
            child:GestureDetector(
              child:  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(colors: [
                    Color(0xFF42A5F5),
                  ]),
                ),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Text("去结算",style: TextStyle(fontSize: ScreenUtil().setSp(14),color: Colors.white,),),
              ),
              onTap: (){

              },
            ),
          ))
        ],
      ),
    );
  }

}
