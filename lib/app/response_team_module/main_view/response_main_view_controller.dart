import 'package:get/get.dart';

class ResponseMainViewController extends GetxController {
  RxInt selectedTabIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }
}
