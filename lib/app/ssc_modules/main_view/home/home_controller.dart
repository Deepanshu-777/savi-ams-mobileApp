import 'dart:convert';
import 'package:get/get.dart';
import '../../../../model/scc_module_models/ssc_home_model.dart';
import '../../../../routes/urls.dart';
import '../../../../service/network_requester.dart';

class HomeController extends GetxController {
  RxInt dateRangeIndex = 0.obs;
  void changeDateRangeIndex(int index) {
    dateRangeIndex.value = index;
  }

  RxInt selectedTabIndex = 0.obs;
  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  Rx<SscHomeData> homeDetail = SscHomeData().obs;
  Rx<HomeDataSse>? detail = HomeDataSse().obs;
  RxString days = "".obs;
  Future<void> getHomeDetails({
    bool isLoader = true,
  }) async {
    final response = await NetworkRequester().get(
      api: () async => await getHomeDetails(),
      path: Urls.SSCHOMEDETAIL,
      isLoader: isLoader,
      query: {
        "days": days,
      },
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        homeDetail.value = sscHomeDataFromJson(res);
        detail?.value = homeDetail.value.data?.homeDataSse ?? HomeDataSse();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getHomeDetails();
  }
}
