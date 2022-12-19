import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:user_flutter/base/widget/BaseStateWidget.dart';

import '../../base/widget/BaseFulWidget.dart';

/**
 * Created by Amuser
 * Date:2022/12/10.
 * Desc:菜单页
 */
class MinePageWidget extends BaseFulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MinePageWidget();
  }

}

class _MinePageWidget extends BaseStateWidget<MinePageWidget>{

  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return Scaffold(
      body: Center(
        child: Text("让我说点什么好====我的"),
      ),
    );
  }
}