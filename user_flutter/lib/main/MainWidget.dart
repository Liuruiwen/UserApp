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

class _MainWidget extends BaseStateWidget<MainWidget> {
  int _currentIndex=0;
  var page_title=<String>["菜单","购物车","我的"];
  List<Widget> page_children=[MenuPageWidget(),MinePageWidget(),CarPageWidget()];
  PageController? _controller;


  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currentIndex);
  }


  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return  _getBody();
    // return Scaffold(
    //   body: page_children[_currentIndex],
    //   bottomNavigationBar: new BottomAppBar(
    //     shape: CircularNotchedRectangle(), ///中间悬浮按钮嵌入BottomAppBar
    //     notchMargin: 8,///缺口边距
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         buildBottomBarItem(_currentIndex, 0, Icons.home, '首页'),
    //         buildBottomBarItem(_currentIndex, -1, Icons.person, ''),
    //         buildBottomBarItem(_currentIndex, 1, Icons.person, '我的'),
    //
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     foregroundColor: Colors.white,
    //     elevation: 10.0,///阴影
    //     onPressed: (){
    //       setState(() {
    //         _currentIndex = 2;
    //       });
    //     },
    //     child: new Icon(Icons.car_repair),
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,//放在中间
    // );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }


Widget _getBody(){
    return Scaffold(
      body:IndexedStack(
        index: _currentIndex,
        children: page_children,
      ),
      bottomNavigationBar: new BottomAppBar(
        shape: CircularNotchedRectangle(), ///中间悬浮按钮嵌入BottomAppBar
        notchMargin: 8,///缺口边距
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildBottomBarItem(_currentIndex, 0, Icons.home, '首页'),
            buildBottomBarItem(_currentIndex, -1, Icons.person, ''),
            buildBottomBarItem(_currentIndex, 1, Icons.person, '我的'),

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
        child: new Icon(Icons.car_repair),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,//放在中间
    );


}


  Widget _getPageView(){
    return new PageView(
      physics: NeverScrollableScrollPhysics(),//viewPage禁止左右滑动
      onPageChanged: _pageChange,
      controller: _controller,
      children: <Widget>[
        Offstage(
          offstage: _currentIndex != 0,
          child:  TickerMode(
            enabled: _currentIndex == 0,
            child:  MaterialApp(
              home: MenuPageWidget(),
            ),
          ),
        ),
        Offstage(
          offstage: _currentIndex != 1,
          child:  TickerMode(
            enabled: _currentIndex == 1,
            child:  MaterialApp(
              home: CarPageWidget(),
            ),
          ),
        ),
        Offstage(
          offstage: _currentIndex != 2,
          child:  TickerMode(
            enabled: _currentIndex ==2,
            child:  MaterialApp(
              home:  MinePageWidget(),
            ),
          ),
        )
      ],);
  }

  void _pageChange(int index) {
    if (index != _currentIndex) {
        _currentIndex = index;
        print("现在是坎坎坷坷====${_currentIndex}");
      };
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
              // _controller?.jumpToPage(index);
              setState(() {
                _currentIndex = index;
                print("ddddddd==${index}");
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