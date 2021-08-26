import 'package:get/get.dart';

class GlobalMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    if (page!.path.regex.hasMatch("/SelectedScreen")) {}
  }
}
