import 'package:get/get.dart';

import 'home/home_controller.dart';

class MainViewController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  RxInt selectedTabIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }
}
