import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:user_flutter/base/widget/BaseStateWidget.dart';
import 'package:user_flutter/main/bean/GoodsOrderBean.dart';
import 'package:user_flutter/main/ui/MinePageWidget.dart';

import '../../base/widget/BaseFulWidget.dart';
import '../bean/MenuCategoryBean.dart';
import '../controller/MenuPageController.dart';
import '../dialog/NormsDialogWidget.dart';

/**
 * Created by Amuser
 * Date:2022/12/10.
 * Desc:菜单页
 */
class MenuPageWidget extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MenuPageWidget();
  }
}

class _MenuPageWidget extends BaseStateWidget<MenuPageWidget>
    implements OnNormsDialogClickListener {
  //多订阅流的方式来创建
  StreamController<int> _streamController = new StreamController.broadcast();
  List<MenuCategoryData> _listCategory = [];
  List<String> list = [
    "fdgdfgd",
    "125454",
    "2332233232",
    "eiiiiiii",
    "125454",
    "2332233232",
    "eiiiiiii",
    "125454",
    "2332233232",
    "eiiiiiii",
    "125454",
    "2332233232",
    "eiiiiiii"
  ];
  int selectPosition = 0;
  int lastPosition=0;
  var _controller = AutoScrollController();
  bool isMenuClick=false;

  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return GetBuilder<MenuPageController>(
        init: MenuPageController(), builder: (_) => _getBody());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadingData());

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadingData() async {
    await MenuPageController.to.getGoodsData("GY11156336987889");
  }

  /**
   * 主体
   */
  Widget _getBody() {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.only(
            top: MediaQueryData.fromWindow(window)
                .padding
                .top), //如果要获取window 需要导入import 'dart:ui';
        child: Row(
          children: [
            Container(
              child:StreamBuilder<int>(
                //绑定流控制器
                stream: _streamController.stream,
                //初始显示的数据
                initialData: 0,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return _getLeftMenu(snapshot);
                },
              ),
              color: Colors.white,
              width: 100,
              height: ScreenUtil().screenHeight,
            ),
            Expanded(child: _getRightGoods())
          ],
        ),
      ),
    );
  }

  Widget _Test() {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: list.length,
        itemBuilder: (context, position) {
          return Container(
            width: 100,
            height: 100,
            child: Center(child: Text(list[position])),
          );
        });
  }

  /**
   * 左边menu菜单
   */
  Widget _getLeftMenu(AsyncSnapshot<int> snapshot) {
    final counter = Get.put(MenuPageController());
    return MenuPageController.to.categoryList == null
        ? Container()
        : ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: MenuPageController.to.categoryList?.length,
            itemBuilder: (context, position) {
              return GestureDetector(
                child: Container(
                  width: ScreenUtil().setWidth(100),
                  height: ScreenUtil().setHeight(60),
                  color: snapshot.data == position
                      ? Colors.grey[300]
                      : Colors.white,
                  child: Center(
                    child: Text(
                      MenuPageController
                              .to.categoryList?[position].categoryName ??
                          "",
                      style: TextStyle(
                          color: snapshot.data  == position
                              ? Colors.black87
                              : Colors.black45,
                          fontWeight: snapshot.data  == position
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                  ),
                ),
                onTap: () {
                  isMenuClick=true;
                  // selectPosition = position;
                  _streamController.add(position);


                  /**
                   * listview 滚动到指定的item  https://www.jianshu.com/p/72754a08b423
                   */
                  var list= MenuPageController.to.goodsList;
                  if(list!=null){
                    for(var i = 0;i < list.length;i++){
                      var element=list[i];
                      if(element.categoryId==MenuPageController.to.categoryList?[position].id){
                        // _controller.scrollToIndex(i+10);
                        int positions=0;
                        if(i>0){
                          positions=i-1;
                        }
                        double itemHeight=MediaQuery.of(context).size.height/lastPosition;
                        _controller.jumpTo(positions*itemHeight);
                        print("=${ScreenUtil().screenHeight}===${itemHeight}过分啊${list.length}。。==${element.goodsName}===${element.categoryId}。========我点击了啊${i}");
                         break;
                      }

                    }
                  }
                },
              );
            },
          );
  }

  Widget _getRightGoods() {
    return Container(
      color: Colors.white,
      height: ScreenUtil().screenHeight,
      child: MenuPageController.to.goodsList == null
          ? Container()
          : ListView.custom(
              padding: EdgeInsets.all(0),
              controller: _controller,
              cacheExtent: 0.0,
              childrenDelegate:
                  CustomScrollDelegate((BuildContext context, int index) {
                //ListView的子条目
                    return AutoScrollTag(
                      key: ValueKey(index),
                      controller: _controller,
                      index: index,
                      child: _goodsItem(context, index),
                  );

                // return _goodsItem(context, index);
              },
              itemCount: MenuPageController.to.goodsList?.length ?? 0,
                    scrollCallBack: (int firstIndex, int lastIndex) {

                         var item= MenuPageController.to.goodsList?[firstIndex];
                     int position= MenuPageController.to.categoryPosition?[item?.categoryId];
                      print("当前是${firstIndex}=========现在是${lastIndex}");
                      if(lastPosition==0){
                        lastPosition=lastIndex;
                      }

                     if(position!=selectPosition ){

                       if(isMenuClick==true){

                         return;
                       }
                       selectPosition=position;
                       _streamController.add(selectPosition);

                     }
                    },
                  ),

            ),
    );
  }

  Widget _goodsItem(BuildContext context, int position) {
    return Listener(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _imageWrapper(
              MenuPageController.to.goodsList?[position].goodsImage ?? ""),
          Expanded(
              child: Container(
            margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MenuPageController.to.goodsList?[position].goodsName ?? "",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(16)),
                  textAlign: TextAlign.start,
                ),
                Container(
                  child: Text(
                    MenuPageController.to.goodsList?[position].goodsDesc ?? "",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: ScreenUtil().setSp(12)),
                    textAlign: TextAlign.left,
                  ),
                  margin:
                      EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(6), 0, 0),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "￥",
                        style: TextStyle(
                            color: Colors.red[400],
                            fontSize: ScreenUtil().setSp(12)),
                        textAlign: TextAlign.left,
                      ),
                      Expanded(
                        child: Text(
                          "${MenuPageController.to.goodsList?[position].goodsPrice ?? ""}",
                          style: TextStyle(
                              color: Colors.red[400],
                              fontSize: ScreenUtil().setSp(16)),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Align(
                        child: GestureDetector(
                          child: MenuPageController
                                      .to.goodsList?[position].listNorms ==
                                  null
                              ? Container(
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(20),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ))
                              : Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 0, ScreenUtil().setWidth(16), 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: const LinearGradient(colors: [
                                      Color(0xffde53fc),
                                      Color(0xff846dfc),
                                      Color(0xff30c1fd),
                                    ]),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: Text("选规格",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(12))),
                                ),
                          onTap: () {
                            var item =
                                MenuPageController.to.goodsList?[position];
                            if (item?.listNorms != null) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: NormsDialogWidget(
                                          item, item?.listNorms, this),
                                    );
                                  });
                            }
                          },
                        ),
                        alignment: Alignment.topRight,
                      )
                    ],
                  ),
                  margin:
                      EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(12), 0, 0),
                ),
              ],
            ),
          ))
        ],
      ),
       onPointerDown: (event){
         isMenuClick=false;
       },

    );
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

  @override
  void onAddCar(GoodsOrderBean? bean) {
    MenuPageController.to.addGoodsOrderBean(bean);
  }
}
