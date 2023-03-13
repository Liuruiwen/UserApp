import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/widget/BaseFulWidget.dart';
import '../../base/widget/BaseWidget.dart';
import 'OrderWidget.dart';

/**
 * Created by Amuser
 * Date:2023/2/28.
 * Desc:用户订单页
 */
class UserOrderWidget extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserOrderWidget();
  }
}

class _UserOrderWidget extends BaseWidget with SingleTickerProviderStateMixin{
  TabController? _tabController=null; //tabbar控制器，控制顶部tabbar切换
  @override
  String getTitle() {
    // TODO: implement getTitle
    return "我的订单";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);//初始化控制器
  }

  @override
  Widget setBodyWidget(BuildContext buildContext) {
    // TODO: implement setBodyWidget
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _tabMenu(),
          Expanded(child: _body())
        ],
      ),
    );
  }

  Widget _tabMenu(){
    return Container(
        width: ScreenUtil().screenWidth,
        color: Colors.blue,
        child: TabBar(
          unselectedLabelColor: Colors.white30,
          isScrollable: true,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 18),
          unselectedLabelStyle: TextStyle(fontSize: 15),
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            tabs: [
               Tab(
                 child: Container(
                   // height: ScreenUtil().setHeight(45),
                   child: Text("全部订单"),
                 ),
               ),
             Tab(
               child:  Container(
                 // height: ScreenUtil().setHeight(45),
                 child: Text("待完成"),
               ),
             ),
              Tab(
                child: Container(
                  // height: ScreenUtil().setHeight(45),
                  child: Text("已完成"),
                ),
              )
            ],
        )

    );
  }


  Widget _body(){
    return TabBarView(
        controller: _tabController,//tabbar控制器
        children: [
             Container(
               width: ScreenUtil().screenWidth,
               height: ScreenUtil().scaleHeight,
               alignment: Alignment.center,
               child: OrderWidget(),
             ),
          Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().scaleHeight,
            alignment: Alignment.center,
            color: Colors.black,
          ),
          Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().scaleHeight,
            alignment: Alignment.center,
            color: Colors.amber,
          )
    ]);
  }



  Widget _testWidget(){
    return  PreferredSize(
      preferredSize: Size.fromHeight(35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: 48,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  controller: _tabController,
                  tabs: [
                    Container(
                      width: 60,
                      alignment: Alignment.center,
                      child: Text('退机'),
                    ),
                    Container(
                      width: 60,
                      alignment: Alignment.center,
                      child: Text('退机'),
                    ),
                    Container(
                      width: 60,
                      alignment: Alignment.center,
                      child: Text('退机'),
                    ),
                    // Container(
                    //   width: 60,
                    //   alignment: Alignment.center,
                    //   child: Text('退机'),
                    // ),
                    // Container(
                    //   width: 60,
                    //   alignment: Alignment.center,
                    //   child: Text('退机'),
                    // ),
                    // Container(
                    //   width: 60,
                    //   alignment: Alignment.center,
                    //   child: Text('退机'),
                    // ),
                    // Container(
                    //   width: 60,
                    //   alignment: Alignment.center,
                    //   child: Text('退机'),
                    // ),
                    // Container(
                    //   width: 60,
                    //   alignment: Alignment.center,
                    //   child: Text('退机'),
                    // ),
                    // Container(
                    //   width: 60,
                    //   alignment: Alignment.center,
                    //   child: Text('退机'),
                    // ),
                  ],
                ),
              )),
          Expanded(flex: 0, child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Icon(Icons.ac_unit),
          ))
        ],
      ),
    );
  }

}