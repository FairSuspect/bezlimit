import 'package:bezlimit/getx/main.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    Controller c = Get.find();
    if (newValue.text.contains('-')) return oldValue;
    // return TextEditingValue(newValue.re)
    if (newValue.text == '') return newValue;
    var intValue = int.tryParse(newValue.text);
    if (intValue != null && intValue >= 0) {
      if (intValue > c.maxTiles.value)
        return TextEditingValue(text: c.maxTiles.toString());
      else
        return newValue;
    } else
      return oldValue;
  }
}
