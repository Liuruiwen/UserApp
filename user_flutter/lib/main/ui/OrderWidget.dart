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


    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colours.white_bg,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        //设置四周边框
        border: new Border.all(width: 1, color: Colours.blue_bg),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text("让我说点什么好", style: TextStyle(
                  fontSize: getSp(16), color: Colours.text_dark),)),
              Text(item?.orderState == 0 ? "创作中" : "已完成", style: TextStyle(
                  fontSize: getSp(16),
                  color: item?.orderState == 0 ? Colours.text_gray : Colours
                      .text_dark),)
            ],
          ), //店铺名称和状态
          Container(
            margin: EdgeInsets.only(top: getHeight(8)),
            child: Text(item?.orderTime ?? "",
              style: TextStyle(fontSize: getSp(14), color: Colours.text_gray),),
          ), //时间
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded(
              //   child: ListView.builder(
              //       itemCount: goodsList.length>=4?4:goodsList.length,
              //       itemBuilder: (context, position) {
              //         return goodsItem(goodsList[position]);
              //       }),
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Text("￥${item?.goodsPrice??""}",style: TextStyle(fontSize: getSp(18), color: Colours.text_dark,fontWeight: FontWeight.bold)),
                  Text("共${item?.goodsNum}件",style: TextStyle(fontSize: getSp(12), color: Colours.text_gray))
                ],
              )
            ],
          ),//商品和价格、数量
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colours.text_E5E5E5,
              //设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              //设置四周边框
              border: new Border.all(width: 1, color: Colours.blue_bg),
            ),
            child: Text("订单号：${item?.id}",style: TextStyle(fontSize: getSp(16), color: Colours.text_gray)),
          )
        ],
      ),
    );
  }

  Widget goodsItem(GoodsList item){
    return Container(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
             _imageWrapper(item.goodsImage??""),
             Container(
               width: getWidth(50),
               child: Text(item.goodsName??"",maxLines: 1,
                 overflow: TextOverflow.ellipsis,style:TextStyle(fontSize: getSp(12), color: Colours.text_normal),),
             )

         ],
       ),
    );
  }


  Widget _imageWrapper(String imageUrl) {
    return SizedBox(
      width: getWidth(50),
      height: getHeight(50),
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