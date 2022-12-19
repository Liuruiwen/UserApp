import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:user_flutter/base/widget/BaseStateWidget.dart';

import '../../base/widget/BaseFulWidget.dart';
import '../bean/MenuCategoryBean.dart';
import '../controller/MenuPageController.dart';

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
  List<String> list=["fdgdfgd","125454","2332233232","eiiiiiii"];
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
        .addPostFrameCallback((_) => MenuPageController.to.getCategoryData("GY11156336987889"));

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
              width: 100,
                height: ScreenUtil().screenHeight,
              ),
              Container()
              // Expanded(child: _getLeftMenu())

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
                    height: ScreenUtil().setHeight(100),
                    color: selectPosition==position?Colors.grey:Colors.white,
                    child: Center(child: Text(
                      MenuPageController.to.categoryList?[position].categoryName??"",
                      style: TextStyle(color: selectPosition==position?Colors.black87:Colors.grey),
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


}