
import 'package:flutter/cupertino.dart';

/**
 * Created by Amuser
 * Date:2023/1/14.
 * Desc: 自定义滑动监听回调
 */

class CustomScrollDelegate extends SliverChildBuilderDelegate {
  //定义滑动回调监听
  Function(int firstIndex, int lastIndex)? scrollCallBack;

  //构造函数
  CustomScrollDelegate(builder, {required int itemCount, this.scrollCallBack})
      : super(builder, childCount: itemCount);

  @override
  double? estimateMaxScrollOffset(int firstIndex, int lastIndex,
      double leadingScrollOffset, double trailingScrollOffset) {
    if (scrollCallBack != null) {
      scrollCallBack!(firstIndex, lastIndex);
    }
    return super.estimateMaxScrollOffset(
        firstIndex, lastIndex, leadingScrollOffset, trailingScrollOffset);
  }
}