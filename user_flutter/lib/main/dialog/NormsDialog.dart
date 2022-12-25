import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/Colours.dart';
import '../bean/MenuGoodsBean.dart';

/**
 * Created by Amuser
 * Date:2022/12/24.
 * Desc:
 */
abstract class OnNormsDialogClickListener {
  void onAttributeSelect(List<ListAttribute>? list,int position);

}

class NormsDialog extends Dialog{

  List<ListNorms>? _list;
  String? _goodsName;
  var map=Map();
  String? _normsList;

  NormsDialog(this._list, this._goodsName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      //创建透明层
         type: MaterialType.transparency,//透明层类型
         child: Container(
           margin: EdgeInsets.fromLTRB(30,80,30,80),
           color: Colors.white,
           padding: EdgeInsets.all(8),
           // decoration:BoxDecoration(
           //  //背景
           //   color: Colors.white,
           //   //设置四周圆角 角度
           //   borderRadius: BorderRadius.all(Radius.circular(4.0)),
           //   //设置四周边框
           //   border: new Border.all(width: 1, color: Colours.white_19),
           // ),
           child: StatefulBuilder(builder: (context,_state){
             return Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("${_goodsName}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(16)),),
                 Expanded(child: _getListNorms(_state),),
                 Container(
                   color: Colours.blue_bg,
                   child: Text(_normsList??"",style: TextStyle(color: Colours.text_dark,fontSize: ScreenUtil().setSp(14)),),
                 )

               ],
             );
           },),
         ),
    );
  }

  /**
   * 获取规格
   */
  Widget _getListNorms(StateSetter _state){
    return _list==null?Container():ListView.builder(
      //解决无线高度问题
        physics: new NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _list?.length,
        padding: EdgeInsets.all(0),
        itemBuilder: (context,position){
             return Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(_list?[position].normsName??"",style: TextStyle(color: Colours.gray_99,fontSize: ScreenUtil().setSp(14)),),
                _list?[position].listAttribute==null?Container():_getNaiList(_list?[position].listAttribute,position, _state),

               ],
             );

    });
  }


  /**
   * 获取规格属性
   */
  Widget  _getNormsAttribute(List<ListAttribute>? list,int i){
      return list==null?Container():GridView.builder(
        shrinkWrap: true,
        //解决无线高度问题
        physics: new NeverScrollableScrollPhysics(),
        //禁用滑动事件
        scrollDirection: Axis.vertical,

        padding: EdgeInsets.only(left: 16.0, top: 0, right: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //每行显示3列
          // childAspectRatio: 60 / 60, //显示区域宽高相等
          mainAxisSpacing: 1.0, //每行的间距
          crossAxisSpacing: 1.0, //每列的间距
        ),
        itemCount: list.length,
        itemBuilder: (context,position){
          return StatefulBuilder(builder: (context,_state){
               return GestureDetector(
                 child: Container(
                   margin: EdgeInsets.fromLTRB(2, 5, 2, 0),
                   padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                   decoration: BoxDecoration(
//背景
                     color: Colors.white,
                     //设置四周圆角 角度
                     borderRadius: BorderRadius.all(Radius.circular(4.0)),
                     //设置四周边框
                     border: new Border.all(width: 1, color: list[position].isSelect==1?Colours.blue_bg:Colours.gray_F5),
                   ),
                   child: Text(list[position].normsAttributeName??"",style: TextStyle(
                       color: list[position].isSelect==1?Colors.blue:Colors.black,fontSize: ScreenUtil().setSp(14)),
                   ),

                 ),
                 onTap: (){


                 },
               );
          }) ;
      });
  }

  Widget _getNaiList(List<ListAttribute>? list,int i,StateSetter _state) {
    final List<Widget> chips = list!.map<Widget>((ListAttribute _model) {
      return new GestureDetector(
        child: Chip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          key: ValueKey<String>(_model.normsAttributeName ?? ""),
          backgroundColor:Colors.white,
          label: Container(
            margin: EdgeInsets.fromLTRB(2, 5, 2, 0),
            padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
           decoration: BoxDecoration(
             //背景
            color: Colors.white,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(15)),
            //设置四周边框
            border: new Border.all(width: 1, color: _model.isSelect==1?Colours.blue_bg:Colours.gray_F5),
          ),
            child: Text(
              _model.normsAttributeName ?? "",
              style: new TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  color: _model.isSelect == 1 ? Colors.blue : Colors.black),
            ),
          ),
        ),
        behavior: HitTestBehavior.opaque,
        onTap: () {
          map[_list?[i].id]=list[i];
          _state((){
            list.forEach((element) {
              if(_model.id==element.id){
                if(element.isSelect==1){
                  element.isSelect=0;
                }else{
                  element.isSelect=1;
                }

              }else{
                element.isSelect=0;
              }
            });
            map[_list?[i].id]=_model;
            var listAttribute=<String>[];
            map.forEach((key, value) {
              listAttribute.add("${map[key].normsAttributeName}、");
            });
            String data=listAttribute.toString();
            _normsList=data.substring(0,data.length-1);
            print(_normsList??"");

          });
        },
      );
    }).toList();
    return Wrap(
        children: chips.map((Widget chip) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(5, 6, 5, 6),
        child: chip,
      );
    }).toList());
  }
}


