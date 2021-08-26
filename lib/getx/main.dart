import 'package:get/get.dart';

class Controller extends GetxController {
  final maxTiles = 20.obs;
  var count = 1.obs;
  increment() => count++;
  setValue(int value) {
    count(value);
  }
}
