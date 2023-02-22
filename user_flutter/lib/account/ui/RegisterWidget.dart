import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_flutter/account/controller/LoginController.dart';
import 'package:user_flutter/base/widget/BaseFulWidget.dart';
import 'package:user_flutter/base/widget/BaseWidget.dart';

import '../../base/common/widget/ItemTextField.dart';
import '../../base/common/widget/LoadingButton.dart';
import '../../base/until/SpKey.dart';
import '../../provider/AppProvider.dart';
import '../../res/Dimens.dart';
import '../../res/styles.dart';

/**
 * Created by Amuser
 * Date:2022/11/23.
 * Desc:注册页面
 */

class RegisterWidget extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterWidget();
  }
}

class _RegisterWidget extends BaseWidget {
  final TextEditingController etControllerUser = TextEditingController();
  final TextEditingController etControllerUserPwd = TextEditingController();
  final TextEditingController etConfirmUserPwd = TextEditingController();
  int _animateWidth = 0;
  int _loginState = 1;

  @override
  String getTitle() {
    // TODO: implement getTitle
    return "注册";
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
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("drawable/image/login_background.jpg"),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: ListView(
        children: <Widget>[
          Container(
            height: getHeight(Dimens.dp80),
          ),
          ItemTextField(
            controller: etControllerUser,
            prefixIcon: Icons.person,
            hintContent: "请输入账号",
            maxLength: 11,
            margin: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), 0),
          ),
          Gaps.vGap15,
          ItemTextField(
              controller: etControllerUserPwd,
              prefixIcon: Icons.lock,
              hintContent: "请输入密码",
              hasSuffixIcon: true),
          Gaps.vGap15,
          ItemTextField(
              controller: etConfirmUserPwd,
              prefixIcon: Icons.lock,
              hintContent: "请确认密码",
              hasSuffixIcon: true),
          Gaps.vGap15,
          LoadingButton("注册", _loginState, _animateWidth, () async {
            _processLoginData();
          }, () {
            _login();
          },
              EdgeInsets.fromLTRB(ScreenUtil().setWidth(50),
                  ScreenUtil().setHeight(30), ScreenUtil().setWidth(50), 0)),

        ],
      ),
    );
  }

  _login() async {
    FocusScope.of(context).unfocus();
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
    var confirmPwd=etConfirmUserPwd.text.trim();
    if (confirmPwd== "") {
      showToast("确认密码不能为空");
      return;
    }
    if(confirmPwd!=pwd){
      showToast("两次密码输入的不一致");
      return;
    }

    setState(() {
      _loginState = 2;
      _animateWidth = Dimens.dp55;
    });
    await LoginController.to.register(account,pwd,"GY11156336987889");

    if(LoginController.to.loginData!=null){
      showToast("${LoginController.to.loginData?.customerAccount}注册成功");
      setState(() {
        _loginState=3;
      });

    }else{
      showToast("登录失败");
      setState(() {
        _loginState = 1;
        _animateWidth=0;
      });
    }

  }




  void saveToken(String token)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SpKey.SP_TOKEN, token);
  }

  _processLoginData() async {
    print("没有进来哦，，注册成功");
    await LoginController.to.getUserInfo();
    if(LoginController.to.userInfoBean!=null){
      var app = context.read<AppProvider>();
      app.setUserInfo(LoginController.to.userInfoBean);
      saveToken(LoginController.to.loginData?.token??"");
      LoginController.to.clearData();
      closeWidget();


    }
  }
}
