import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/Colours.dart';
import '../../../res/Dimens.dart';

/**
 * Created by Amuser
 * Date:2022/12/16.
 * Desc:
 */
class ItemTextField extends StatefulWidget {
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final String? hintContent;
  final bool hasSuffixIcon;
  final EdgeInsetsGeometry? margin;
  final int maxLength;


  const ItemTextField(
      { Key? key, this.controller, this.prefixIcon, this.hintContent,
        this.margin,
        this.maxLength=16,
        this.hasSuffixIcon = false}) : super(key: key);

  @override
  ItemTextFiledState createState() {
    // TODO: implement createState
    return new ItemTextFiledState();
  }

}


class ItemTextFiledState extends State<ItemTextField> {
  bool? _obscureText;


  @override
  void initState() {
    super.initState();
    _obscureText = widget.hasSuffixIcon;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new Icon(widget.prefixIcon, size: 30, color: Colors.blue,),
            width: ScreenUtil().setWidth(Dimens.dp50),
            height: ScreenUtil().setHeight(Dimens.dp60),
          ),

          new Expanded(
            child: new Container(
              child: _getTextField(),
              margin: EdgeInsets.only(left: 0),
            ),),

        ],),
      margin:widget.margin==null?EdgeInsets.fromLTRB(30, 10, 30, 0):widget.margin,
    );
  }


  Widget _getTextField() {
    return new TextField(
      controller: widget.controller,
      maxLines: 1,
      maxLength: widget.maxLength,
      autocorrect: true,
      //是否自动更正
      autofocus: true,
      //是否自动对焦
      obscureText: _obscureText??false,
      //是否是密码
      textAlign: TextAlign.center,
      decoration: new InputDecoration(
        hintText: widget.hintContent,
        hintStyle: new TextStyle(color: Colours.gray_99, fontSize:ScreenUtil().setSp(Dimens.sp14)),
        counterStyle: TextStyle(color: Colors.white),
        suffixIcon: widget.hasSuffixIcon
            ? new IconButton(
            icon: new Icon(
              _obscureText!
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: _obscureText!
                  ?Colors.blue:Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText!;
              });
            })
            : new IconButton(icon: new Icon(Icons.visibility,color: Colors.transparent,), onPressed: (){}),
        focusedBorder: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Colours.green_de)),
        enabledBorder: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Colours.green_de)),
      ),
      style: TextStyle(
          fontSize: ScreenUtil().setSp(Dimens.sp14),
          color: Colors.blue), //输入文本的样式
    );
  }
}