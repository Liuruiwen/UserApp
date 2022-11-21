


import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/**
 * Created by Amuser
 * Date:2022/11/21.
 * Desc:
 */
class CounterController extends GetxController {
  int _counter = 0;
  static CounterController get to => Get.find();
  get counter => _counter;

  void increment() {
    _counter++;
    update();
  }
}