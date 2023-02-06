import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_flutter/account/controller/LoginController.dart';
import 'package:user_flutter/base/widget/BaseFulWidget.dart';
import 'package:user_flutter/base/widget/BaseWidget.dart';
import 'package:user_flutter/account/bean/LoginData.dart';

import '../../base/common/widget/ItemTextField.dart';
import '../../base/common/widget/LoadingButton.dart';
import '../../base/until/SpKey.dart';
import '../../provider/AppProvider.dart';
import '../../res/Dimens.dart';
import '../../res/styles.dart';

/**
 * Created by Amuser
 * Date:2022/11/23.
 * Desc:登录页面
 */

class LoginWidget extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginWidget();
  }
}

class _LoginWidget extends BaseWidget {
  final TextEditingController etControllerUser = TextEditingController();
  final TextEditingController etControllerUserPwd = TextEditingController();
  int _animateWidth = 0;
  int _loginState = 1;

  @override
  String getTitle() {
    // TODO: implement getTitle
    return "登录";
  }

  @override
  Widget setBodyWidget(BuildContext buildContext) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_)=>_getBody()
    );
  }

  Widget _getBody() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("drawable/image/login_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        children: <Widget>[
          Container(
            height: getHeight(Dimens.dp60),
          ),
          new ItemTextField(
            controller: etControllerUser,
            prefixIcon: Icons.person,
            hintContent: "请输入用户名",
            margin: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), 0),
          ),
          Gaps.vGap15,
          new ItemTextField(
              controller: etControllerUserPwd,
              prefixIcon: Icons.lock,
              hintContent: "请输入密码",
              hasSuffixIcon: true),
          Gaps.vGap15,
          LoadingButton("登录", _loginState, _animateWidth, () async {
            _processLoginData(null);
          }, () {
            _login();
          },
              EdgeInsets.fromLTRB(ScreenUtil().setWidth(50),
                  ScreenUtil().setHeight(30), ScreenUtil().setWidth(50), 0)),
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text("亲，注册了？",
                    style: TextStyle(color: Colors.black, fontSize: getSp(12))),
                new GestureDetector(
                  child: new Text(
                    "注册",
                    style: TextStyle(color: Colors.blue, fontSize: getSp(12)),
                  ),
                  onTap: () {
                    // pushWidget(context,BlocProvider(child: RegisterPage(), bloc: RegisterPageBloc()));
                  },
                )
              ],
            ),
            margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
          ),
        ],
      ),
    );
  }

  _login() async {
    var account=etControllerUser.text.trim();
    if (account == "") {
      showToast("用户名不能为空");
      return;
    }
    var pwd=etControllerUserPwd.text.trim();
    if (pwd== "") {
      showToast("密码不能为空");
      return;
    }
    setState(() {
      _loginState = 2;
      _animateWidth = 100;
    });

   await LoginController.to.getLoginData(account,pwd,"GY11156336987889");

   if(LoginController.to.loginData!=null){
     setState(() {
       _loginState=3;
     });

     await LoginController.to.getUserInfo();
     if(LoginController.to.userInfoBean!=null){
       var app = context.read<AppProvider>();
       app.setUserInfo(LoginController.to.userInfoBean);
       saveToken(LoginController.to.loginData?.token??"");
     }
     closeWidget();
     showToast("登录成功${LoginController.to.loginData?.customerAccount}");
   }else{
     showToast("登录失败");
   }



    setState(() {
        _loginState = 1;
          _animateWidth=0;
        });
    // bool isLogin = await _bloc.loginData("${etControllerUser.text.trim()}",
    //     "${etControllerUserPwd.text.trim()}");
    // if (isLogin) {
    //   setState(() {
    //     _loginState=3;
    //   });
    // }else{
    //   setState(() {
    //     _loginState=1;
    //     _animateWidth=0;
    //   });
    // }
  }

  void saveToken(String token)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SpKey.SP_TOKEN, token);
  }

  _processLoginData(String? url) async {
    // LoginPageBean bean = await _appBloc.getLoginBean();
    // bean.headImage=url;
    // _appBloc.addLoginData(bean);
    // _appBloc.addMethodCall(null);
  }
}
