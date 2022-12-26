import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:user_flutter/base/widget/BaseStateWidget.dart';

import '../../base/widget/BaseFulWidget.dart';
import '../bean/MenuCategoryBean.dart';
import '../controller/MenuPageController.dart';
import '../dialog/NormsDialog.dart';

/**
 * Created by Amuser
 * Date:2022/12/10.
 * Desc:菜单页
 */
class MenuPageWidget extends BaseFulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MenuPageWidget();
  }

}

class _MenuPageWidget extends BaseStateWidget<MenuPageWidget>{
  List<MenuCategoryData> _listCategory=[];
  List<String> list=["fdgdfgd","125454","2332233232","eiiiiiii","125454","2332233232","eiiiiiii","125454","2332233232","eiiiiiii","125454","2332233232","eiiiiiii"];
  int selectPosition=0;
  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return GetBuilder<MenuPageController>(
        init: MenuPageController(),
        builder: (_)=>_getBody()
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _loadingData());

  }

  void _loadingData()async{
   await MenuPageController.to.getCategoryData("GY11156336987889");
   await MenuPageController.to.getShoppingData("GY11156336987889");
  }

  /**
   * 主体
   */
  Widget _getBody(){
    return Scaffold(
      body: Container(
        child: Row(
            children: [
              Container(child: _getLeftMenu(),
              color: Colors.white,
              width: 100,
                height: ScreenUtil().screenHeight,
              ),
              Expanded(child:_getRightGoods())

              // Expanded(
              //     child: Container(
              //       color: Colors.red,
              //       child: Row(
              //         children: [
              //           _getLeftMenu(),
              //           // Text("I am Jack "),
              //         ],
              //       ),
              //     )
              // ),
            ],
        ),
      ),
    );
  }

  Widget _Test(){
    return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: list.length,
        itemBuilder: (context,position){
          return Container(
            width: 100,
            height: 100,
            child: Center(child:Text(list[position])),
          );
        });
  }

  /**
   * 左边menu菜单
   */
  Widget  _getLeftMenu(){
    return MenuPageController.to.categoryList==null?Container(): ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: MenuPageController.to.categoryList?.length,
          itemBuilder: (context, position) {
            return GestureDetector(
              child: Container(
                     width:  ScreenUtil().setWidth(100),
                    height: ScreenUtil().setHeight(60),
                    color: selectPosition==position?Colors.grey[300]:Colors.white,
                    child: Center(child: Text(
                      MenuPageController.to.categoryList?[position].categoryName??"",
                      style: TextStyle(color: selectPosition==position?Colors.black87:Colors.black45,
                          fontWeight:selectPosition==position?FontWeight.bold:FontWeight.normal),
                    ),),

              ),
              onTap: (){
                 setState(() {
                    selectPosition=position;
                 });
              },
            );
        },
        );
  }


  Widget _getRightGoods(){
    return Container(
      color: Colors.white,
       child:MenuPageController.to.goodsList==null?Container(): ListView.builder(
           padding: EdgeInsets.all(0),
           itemCount: MenuPageController.to.goodsList?.length,
           itemBuilder: (context,position){
         return GestureDetector(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   _imageWrapper(MenuPageController.to.goodsList?[position].goodsImage??""),
                   Expanded(child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(MenuPageController.to.goodsList?[position].goodsName??"",
                         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(16)),
                         textAlign:TextAlign.start,
                       ),
                       Container(
                         child: Text(MenuPageController.to.goodsList?[position].goodsDesc??"",
                           style: TextStyle(color: Colors.grey[600],fontSize: ScreenUtil().setSp(12)),
                           textAlign:TextAlign.left ,),
                         margin: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(6), 0, 0),
                       ),
                       Container(
                         child:  Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Text("￥${MenuPageController.to.goodsList?[position].goodsPrice??""}",
                               style: TextStyle(color: Colors.red[400],fontSize: ScreenUtil().setSp(16)),
                               textAlign:TextAlign.left ,),
                            Expanded(child:  Align(
                              child:GestureDetector(
                                child:  Container(
                                  margin: EdgeInsets.fromLTRB(0,0, ScreenUtil().setWidth(16), 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: const LinearGradient(colors: [
                                      Color(0xffde53fc),
                                      Color(0xff846dfc),
                                      Color(0xff30c1fd),
                                    ]),
                                  ),
                                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: Text("选规格",
                                      style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(12))),
                                ),
                                onTap: (){
                                  var item=MenuPageController.to.goodsList?[position];
                                   showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                    return NormsDialog(item?.listNorms,item?.goodsName,item?.goodsPrice);
                                  });
                                },
                              ),
                              alignment: Alignment.topRight,
                            ))
                           ],
                         ),
                         margin: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(12), 0, 0),
                       ),

                     ],
                   ))
                 ],
               ),
         );
       }),
      height: ScreenUtil().screenHeight,
    );
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

}