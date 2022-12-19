import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:user_flutter/base/widget/BaseFulWidget.dart';

import '../base/widget/BaseStateWidget.dart';
import 'ui/CarPageWidget.dart';
import 'ui/MenuPageWidget.dart';
import 'ui/MinePageWidget.dart';

/**
 * Created by Amuser
 * Date:2022/12/10.
 * Desc:
 */
class MainWidget extends BaseFulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainWidget();
  }

}

class _MainWidget extends BaseStateWidget<MainWidget>{
  int _currentIndex=0;
  var page_title=<String>["菜单","购物车","我的"];
  List<Widget> page_children=[MenuPageWidget(),CarPageWidget(),MinePageWidget()];

  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return Scaffold(
      appBar: AppBar(
        title: Text(page_title[_currentIndex]),

        ///导航栏标题
        centerTitle: true,

        ///导航栏标题居中显示（IOS默认居中，Android默认靠左）
      ),
      body: page_children[_currentIndex],
      bottomNavigationBar: new BottomAppBar(
        shape: CircularNotchedRectangle(), ///中间悬浮按钮嵌入BottomAppBar
        notchMargin: 8,///缺口边距
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildBottomBarItem(_currentIndex, 0, Icons.home, '首页'),
            buildBottomBarItem(_currentIndex, -1, Icons.person, ''),
            buildBottomBarItem(_currentIndex, 1, Icons.image, '我的'),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        elevation: 10.0,///阴影
        onPressed: (){
          setState(() {
            _currentIndex = 2;
          });
        },
        child: new Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,//放在中间
    );
  }

  buildBottomBarItem(
      int selectedIndex, int index, IconData iconData, String title) {
    ///未选中
    TextStyle textStyle = TextStyle(fontSize: 11.0, color: Colors.grey);
    MaterialColor iconColor = Colors.grey;
    double iconSize = 20;
    EdgeInsetsGeometry padding = EdgeInsets.only(top: 9.0);

    //判断是否是选中
    if (selectedIndex == index) {
      textStyle = TextStyle(fontSize: 13.0, color: Colors.blue);
      iconColor = Colors.blue;
      iconSize = 25;
      padding = EdgeInsets.only(top: 6.0);
    }
    Widget paddingItem = SizedBox();
    if (iconData != null) {
      paddingItem = Padding(
        padding: padding,
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                Icon(
                  iconData,
                  color: iconColor,
                  size: iconSize,
                ),
                Text(
                  title,
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget item = Expanded(
        flex: 0,
        child: new GestureDetector(
          onTap: () {
            if(index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          child: SizedBox(
            height: 52,
            child: paddingItem,
          ),
        )
    );
    return item;
  }

}