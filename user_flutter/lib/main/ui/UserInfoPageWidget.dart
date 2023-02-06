import 'package:flutter/material.dart';

import '../../base/widget/BaseFulWidget.dart';
import '../../base/widget/BaseWidget.dart';
import '../../res/Colours.dart';

/**
 * Created by Amuser
 * Date:2023/2/4.
 * Desc:用户详情
 */

class UserInfoPageWidget extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _UserInfoPage();
  }

}

class _UserInfoPage extends BaseWidget<UserInfoPageWidget> {

  @override
  String getTitle() {
    // TODO: implement getTitle
    return "用户详情";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget setBodyWidget(BuildContext buildContext) {


    // TODO: implement setBodyWidget

    return Container();
    // return ListView(
    //   children: <Widget>[
    //     new Center(
    //       child: new CircleImage(
    //           url: nabs.data.headImage==null?"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1578924116&di=c59b350637136244f1559c1ffaba974e&src=http://n.sinaimg.cn/sinacn10113/762/w983h579/20190417/1a2b-hvvuiym8518690.jpg"
    //               :nabs.data.headImage,
    //           circleHeight: Dimens.dp150,
    //           circleWidth:Dimens.dp150,
    //           margin: EdgeInsets.all(30)
    //       ),
    //     ),
    //     _getItem("昵称：" + nabs.data.nickname),
    //     _getItem("Id：" + nabs.data.id.toString()),
    //     _getItem("类型：" + nabs.data.type.toString()),
    //   ],
    // );
  }

  Widget _getItem(String content) {
    return new Container(
      child: new Text(content),
      decoration: BoxDecoration(
          border:Border(bottom:BorderSide(width: 1,color:  Colours.gray_line) )
      ),
      padding: EdgeInsets.only(top:getWidth(30),bottom:getWidth(30)),
      margin: EdgeInsets.only(left:getWidth(30),right: getWidth(30) ),
    );
  }

}