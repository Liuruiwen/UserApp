import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/Dimens.dart';

typedef Future onLoadingFinish();

/**
 * Created by Amuser
 * Date:2019/12/26.
 * Desc:
 */
class LoadingButton extends StatefulWidget {
  int _state = 1;
  int _animateWidth = 0;
  onLoadingFinish _finish;
  void Function() _function;
  String _title;
  final EdgeInsetsGeometry? edgeInsetsGeometry;

  LoadingButton(this._title, this._state, this._animateWidth, this._finish,
      this._function,this.edgeInsetsGeometry);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoadingButton();
  }
}

class _LoadingButton extends State<LoadingButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: (200).round()), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    _controller?.addListener(() {
      setState(() {});
    });
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(Duration(milliseconds: 10), () {
          widget._finish();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          height: getWidth(Dimens.dp55),
          width: widget._animateWidth == 0
              ? MediaQuery.of(context).size.width
              : getWidth(widget._animateWidth),
          margin:widget.edgeInsetsGeometry??EdgeInsets.fromLTRB(getWidth(Dimens.dp50),
              getHeight(Dimens.dp80), getWidth(Dimens.dp50), 0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(60),
          ),
          child: Center(
            child: _getLoginWidget(),
          ),
        ),
        onTap: widget._function,
      ),
    );
  }

  Widget _getText() {
    return new Center(
      child: new Text(
        widget._title,
        style: TextStyle(color: Colors.white, fontSize: getSp(Dimens.sp16)),
      ),
    );
  }

  Widget _getLoading() {
    return SizedBox(
      height: getWidth(Dimens.dp30),
      width: getWidth(Dimens.dp30),
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }

  Widget _getLoginWidget() {
    switch (widget._state) {
      case 1:
        return _getText();
      case 2:
        return _getLoading();
      case 3:
        _controller?.forward();
        return Container(
            padding: EdgeInsets.only(right: getWidth(30),bottom:  getWidth(10)),
            alignment: Alignment.center,
        //     child: Text("好吧",style: TextStyle(color: Colors.white),),
        // );
            child: CustomPaint(
              painter: LoadingFinish(_animation?.value),
            ));
      default:

        return _getLoading();
    }
  }

  getWidth(int width) {
    return ScreenUtil().setWidth(width);
  }

  double getHeight(int height) {
    return ScreenUtil().setHeight(height);
  }

  getSp(int sp) {
    return ScreenUtil().setSp(sp);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
  }
}

class LoadingFinish extends CustomPainter {
  double _animateValue = 0.0;

  LoadingFinish(this._animateValue); //绘制流程
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = Colors.white //画笔颜色
      ..style = PaintingStyle.stroke //画笔样式，默认为填充
      ..strokeWidth = 4.0; //画笔的宽度

    var path = Path();
    path.lineTo(20 / 3 * _animateValue, 40 / 3 * _animateValue);
    path.lineTo(100 / 3 * _animateValue, 10 / 3 * _animateValue);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
