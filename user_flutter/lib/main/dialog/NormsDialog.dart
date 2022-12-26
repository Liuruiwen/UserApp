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
  String? _price;
  var map=Map();
  String? _normsList="已选规格：";

  NormsDialog(this._list, this._goodsName,this._price);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      //创建透明层
         type: MaterialType.transparency,//透明层类型
         child: Wrap(
           children: [
             Container(
               height: ScreenUtil().screenHeight/2,
               margin: EdgeInsets.fromLTRB(30,80,30,80),
               color: Colors.white,
               child: StatefulBuilder(builder: (context,_state){
                 return Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Container(
                       padding: EdgeInsets.all(8),
                       child: Text("${_goodsName}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(16)),),),
                     Expanded(child:Container(
                       padding: EdgeInsets.all(8),
                       child:  _getListNorms(_state),),
                     ),
                     Container(
                       padding: EdgeInsets.all(8),
                       width: ScreenUtil().screenWidth,
                       color: Colours.grey_bg_f2,
                       child: Text(_normsList??"",style: TextStyle(color: Colours.text_dark,fontSize: ScreenUtil().setSp(14)),),
                     ),
                     Container(
                       padding:EdgeInsets.all(8) ,
                       margin:EdgeInsets.fromLTRB(0, 0, 0, 16),
                       child:Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text("总计",style: TextStyle(color: Colours.text_dark,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(14)),),
                           Text("￥",style: TextStyle(color:Colours.text_red_EF5350,fontSize: ScreenUtil().setSp(14))),
                           Text("${_price??""}",style: TextStyle(color:Colours.text_red_EF5350,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(24))),
                           Expanded(child: Align(
                             alignment: Alignment.topRight,
                             child: GestureDetector(child: Container(
                               margin: EdgeInsets.fromLTRB(2, 5, 2, 0),
                               padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                               decoration: BoxDecoration(
                                 color: Colours.blue_bg,
                                 //设置四周圆角 角度
                                 borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                 //设置四周边框
                                 border: new Border.all(width: 1, color: Colours.blue_bg),
                               ),
                               child: Text("加入购物车",style: TextStyle(
                                   color: Colors.white,fontSize: ScreenUtil().setSp(14)),
                               ),

                             ),
                             onTap: (){

                             },
                             ),
                           ))
                         ],
                       ) ,
                     )

                   ],
                 );
               },),
             )
           ],
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
                     border: new Border.all(width: 1, color: list[position].isSelect==1?Colours.blue_bg:Colours.grey_bg_f2),
                   ),
                   child: Text(list[position].normsAttributeName??"",style: TextStyle(
                       color: list[position].isSelect==1?Colors.blue:Colours.text_normal,fontSize: ScreenUtil().setSp(14)),
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
          backgroundColor: _model.isSelect == 1 ? Colors.blue : Colors.grey[200],
          label:  Text(
            _model.normsAttributeName ?? "",
            style: new TextStyle(
                fontSize: ScreenUtil().setSp(14),
                color: _model.isSelect == 1 ? Colors.white : Colours.gray_66),
          ),
        ),
        behavior: HitTestBehavior.opaque,
        onTap: () {
          map[_list?[i].id]=_model;
          _state((){
            list.forEach((element) {
              if(_model.id==element.id){
                if(element.isSelect==1){
                  element.isSelect=0;
                  map.remove(_list?[i].id);
                }else{
                  element.isSelect=1;
                }

              }else{
                element.isSelect=0;
              }
            });

            var listAttribute=<String>[];
            map.forEach((key, value) {
              listAttribute.add("${map[key].normsAttributeName}");
            });
            String data="";
            listAttribute.forEach((element) {
                         data==""? data=element:data="${data}、${element}";
            });
            _normsList="已选规格：${data}";
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


