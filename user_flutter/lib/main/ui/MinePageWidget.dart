
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_flutter/base/Common.dart';
import 'package:user_flutter/base/until/SpKey.dart';
import 'package:user_flutter/provider/AppProvider.dart';
import 'package:provider/provider.dart';

import '../../account/ui/LoginWidget.dart';
import '../../base/widget/BaseFulWidget.dart';
import '../../base/widget/BaseStateWidget.dart';
import '../../account/bean/LoginData.dart';
import '../../res/Colours.dart';
import '../../res/Dimens.dart';
import '../bean/UserInfoBean.dart';
import '../controller/MinePageController.dart';





class MinePageWidget extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MinePageWidget();
  }
}

class _MinePageWidget extends BaseStateWidget<MinePageWidget> {


  @override
  Widget build(BuildContext buildContext) {
    var bean = context.watch<AppProvider>();
     return Container(
         child: ChangeNotifierProvider<AppProvider>.value(value:bean,
             child: GetBuilder<MinePageController>(
                 init: MinePageController(), builder: (_) => _getBodyWidget(bean.getUserInfo())),
             ),
     );

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadingData());

  }

  void _loadingData ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token=prefs.getString(SpKey.SP_TOKEN);
    if(isEmpty(token)){
      Common.APP_TOKEN=token??"";
      await MinePageController.to.getUserInfo();
      if(MinePageController.to.userInfoBean!=null){
        var app = context.read<AppProvider>();
        app.setUserInfo(MinePageController.to.userInfoBean);
      }
    }

  }


  Widget _getHead(UserInfoBean? bean) {


    return new Stack(
      alignment: new Alignment(0, 0),
      children: <Widget>[
        Image(image: new AssetImage('images/drawable-xhdpi/mine_head.jpg'),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: getHeight(Dimens.dp200),
          fit: BoxFit.cover,
        ),
        new GestureDetector(
          child: new Column(
            children: <Widget>[
              Container(
                height: getWidth(100),
                width: getWidth(100),
                child: ClipOval(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: bean==null ?"": isEmpty(bean.headerImage)==false?"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1578924116&di=c59b350637136244f1559c1ffaba974e&src=http://n.sinaimg.cn/sinacn10113/762/w983h579/20190417/1a2b-hvvuiym8518690.jpg"
                        :bean.headerImage??"",
                    placeholder: (context, url) =>
                        Image.asset('images/drawable-xxhdpi/gift_bill_list_empty.png'),
                    errorWidget: (context, url, error) =>
                        Image.asset('images/drawable-xhdpi/default_header.png'),
                  ),
                ),
              ),
              new Container(
                child: new Text( bean==null?"亲，您还未登录哦":bean.name??"",style: TextStyle(fontSize: getSp(Dimens.sp16),color: Colors.white),),
                margin: EdgeInsets.only(top: getWidth(Dimens.dp20)),
              )
            ],
          ),
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if(bean==null){
              pushWidget(context, new LoginWidget());
            }
          },
        ),

      ],
    );
  }




  Widget _getBodyWidget(UserInfoBean? bean){
    return Column(
      children: <Widget>[
        getStateWidget(),
        _getHead(bean),
        _getItem("用户详情", () {
          // bean!=null
          //     ? pushWidget(widget._context, new UserInfoPage())
          //     : _loginOut();
        }),
        _getItem("其它", () {
          showToast("此功能正在开发中");
        }),
        _getItem("关于我", () {
          // pushWidget(widget._context, new AboutMeWidget());
        }),
        bean==null? new Container() : _getItem("退出登录", () {
          // if(bean.openid!=null){
          //   _appBloc.getMethodChannel().invokeListMethod('login_out',bean.openid);
          //   return;
          // }
          // _loginOut();
        }),

      ],
    );
  }



      /**
       * 复用的menu item
       */
  Widget _getItem(String content, void Function() tap) {
    return new Container(
      decoration: BoxDecoration(
          border:Border(bottom:BorderSide(width: 1,color:  Colours.gray_line) )
      ),
      padding: EdgeInsets.only(top:getWidth(16),bottom:getWidth(16)),
      margin: EdgeInsets.only(left:getWidth(16),right: getWidth(16) ),
      child: new GestureDetector(
        child: new Row(
          children: <Widget>[
            new Expanded(child: new Text(content)),
            new Icon(Icons.keyboard_arrow_right, color: Colours.gray_ce,)
          ],
        ),
        onTap: tap,
      ),

    );
  }



}