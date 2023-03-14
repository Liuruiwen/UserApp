import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/widget/BaseFulWidget.dart';
import '../../base/widget/BaseStateWidget.dart';
import '../../res/Colours.dart';
import '../bean/UserOrderBean.dart';
import '../controller/UserOrderController.dart';

/**
 * Created by Amuser
 * Date:2023/3/5.
 * Desc:
 */

class OrderWidget extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderWidget();
  }
}

class _OrderWidget extends BaseStateWidget<OrderWidget> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadingData());

  }

  void _loadingData ()async{
    await UserOrderController.to.getOrderList(1, 10, "13333333333", -1);

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: GetBuilder<UserOrderController>(
          init: UserOrderController(),
          builder: (_) =>
              _getBodyWidget(UserOrderController.to.userInfoBean?.list)),
    );
  }

  Widget _getBodyWidget(List<UserOrderDataBean>? list) {
    return Container(
       width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      child: list == null ? getEmptyPage() : ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, position) {
            return _getItem(position);
          }),
    );
  }


  Widget _getItem(int position) {
    UserOrderDataBean? item = UserOrderController.to.userInfoBean
        ?.list?[position];
    var goodsList=item?.goodsList??[];
    List<GoodsList> showGoodsList=[];
    if(goodsList.length>4){
      showGoodsList=goodsList.sublist(0,4);
    }else{
      showGoodsList=goodsList;
    }


    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.fromLTRB(getWidth(16), getHeight(8), getWidth(16), getHeight(8)),
      decoration: BoxDecoration(
        color: Colours.white_bg,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        //设置四周边框
        border: new Border.all(width: 1, color: Colours.white_bg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: Text("让我说点什么好", style: TextStyle(
                  fontSize: getSp(16), color: Colours.text_dark),)),
              Text(item?.orderState == 0 ? "创作中" : "已完成", style: TextStyle(
                  fontSize: getSp(16),
                  color: item?.orderState == 0 ? Colours.text_gray : Colours
                      .text_dark),textAlign: TextAlign.start,)
            ],
          ), //店铺名称和状态
          Container(
            margin: EdgeInsets.only(top: getHeight(6)),
            child: Text(item?.orderTime ?? "",
              style: TextStyle(fontSize: getSp(14), color: Colours.text_gray),),
          ), //时间
          Container(
            width: ScreenUtil().screenWidth,
            height: getHeight(80),
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: goodsItem(showGoodsList),
                  ),
                ),
                Container(
                  child: Text(goodsList.length>4?"...":""),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        Text("￥",style: TextStyle(fontSize: getSp(12), color: Colours.text_dark)),
                        Text(item?.goodsPrice??"",style: TextStyle(fontSize: getSp(18), color: Colours.text_dark)),
                      ],
                    ),
                    Text("共${item?.goodsNum}件",style: TextStyle(fontSize: getSp(12), color: Colours.text_gray))
                  ],
                )
              ],
            ),
          ),//商品和价格、数量
          Container(
            margin: EdgeInsets.only(top: getHeight(16)),
            padding: EdgeInsets.all(8),
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
              color: Colours.gray_line,
              //设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              //设置四周边框
              border: new Border.all(width: 1, color: Colours.gray_line),
            ),
            child: Text("订单号：${item?.id}",style: TextStyle(fontSize: getSp(16), color: Colours.text_normal)),
          )
        ],
      ),
    );
  }

  List<Widget> goodsItem(List<GoodsList> list){



   return list.map((item) {
      return Container(
        margin: EdgeInsets.only(right: getWidth(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _imageWrapper(item.goodsImage??""),
            Container(
              width: getWidth(45),
              child: Text(item.goodsName??"",maxLines: 1,
                overflow: TextOverflow.ellipsis,style:TextStyle(fontSize: getSp(12), color: Colours.text_normal),),
            )

          ],
        ),
      );
    }).toList();


  }


  Widget _imageWrapper(String imageUrl) {
    print("电钢琴图片=========：${imageUrl}");
    return SizedBox(
      width: getWidth(45),
      height: getHeight(45),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) =>
            Image.asset('images/drawable-xxhdpi/gift_bill_list_empty.png'),
        errorWidget: (context, url, error) =>
            Image.asset('images/drawable-xhdpi/loading_error.jpg'),
      ),
    );
  }
}