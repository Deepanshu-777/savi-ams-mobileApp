import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/model/scc_module_models/machine_condemn_request_list_model.dart'
    as condemnRequest;
import 'package:rail_weld/model/scc_module_models/machine_list_model.dart';
import 'package:rail_weld/model/scc_module_models/shop_list_model.dart' as shop;
import '../../../../routes/urls.dart';
import '../../../../service/network_requester.dart';

class TotalMachinesController extends GetxController {
  final ScrollController scrollController = ScrollController();
  late TextEditingController searchByNameOrItemCode;
  int currentPage = 1;
  RxString sortBy = "".obs;
  RxBool isMachineLoaded = true.obs;
  RxBool apiStatus = true.obs;
  @override
  void onInit() {
    super.onInit();
    searchByNameOrItemCode = TextEditingController();
    fetchTotalMachineCondemnRequests();
    getShopList();
    getMachineList(
      isScroll: true,
    );
    init();
  }

  void init() {
    scrollController.addListener(() {
      scrollListener();
    });
  }

  void scrollListener() async {
    if (scrollController.position.pixels /
            scrollController.position.maxScrollExtent >
        0.9) {
      if (apiStatus.value &&
          ((machineList.value.data?.machinesList?.lastPage ?? 0) >=
              currentPage)) {
        await getMachineList(
          isScroll: true,
        );
      }
    }
  }

  RxInt totalCondemnRequests = 0.obs;
  Future<void> fetchTotalMachineCondemnRequests() async {
    final response = await NetworkRequester().get(
      api: () async => await fetchTotalMachineCondemnRequests(),
      query: {
        "request_type": 'condemnation',
        "status": 'pending',
        // You can add more filters here if needed
      },
      path: Urls.GET_MACHINE_CONDEMN_REQUEST,
      isLoader: false,
    );

    if (response != null) {
      final model = condemnRequest
          .machineCondemnRequestModelFromJson(jsonEncode(response));

      totalCondemnRequests.value = model.data?.total ?? 0;
    }
  }

  RxInt currentConditionIndex = 5.obs;

  void changeCurrentConditionIndex(int currentIndex) {
    currentConditionIndex.value = currentIndex;
  }

  RxInt currentMachineStatusIndex = 5.obs;

  void changeCurrentMachineStatusIndex(int currentIndex) {
    currentMachineStatusIndex.value = currentIndex;
  }

  RxInt currentWarrantyIndex = 5.obs;

  void changeCurrentWarrantyIndex(int currentIndex) {
    currentWarrantyIndex.value = currentIndex;
  }

  RxInt currentTimeIndex = 5.obs;

  void changeCurrentTimeIndex(int currentIndex) {
    currentTimeIndex.value = currentIndex;
  }

  Rx<MachineListing> machineList = MachineListing().obs;
  RxList<Data?>? machines = <Data>[].obs;
  void resetPagination() {
    machines?.clear();
    currentPage = 1;
  }

  void resetFilter() {
    shopIds = <int>[].obs;
    shopTitles = <String>[].obs;
    currentMachineStatusIndex.value = 5;
    currentWarrantyIndex.value = 5;
    currentTimeIndex.value = 5;
    currentConditionIndex.value = 5;
    searchByNameOrItemCode.clear();
    searchByNameOrItemCode.text == "";
  }

  Future<void> getMachineList({
    bool isLoader = true,
    bool isReset = false,
    bool isScroll = false,
  }) async {
    isScroll ? apiStatus.value = false : isMachineLoaded.value = false;
    final response = await NetworkRequester().get(
      api: () async => await getMachineList(),
      query: isReset
          ? {}
          : {
              "sort_by": sortBy.value,
              "machine_status": currentMachineStatusIndex.value == 0
                  ? "working"
                  : currentMachineStatusIndex.value == 1
                      ? "out-of-order"
                      : "",
              "warranty": currentWarrantyIndex.value == 0
                  ? "in-warranty"
                  : currentWarrantyIndex.value == 1
                      ? "out-of-warranty"
                      : "",
              "upcoming_maintenance": currentTimeIndex.value == 0
                  ? "7"
                  : currentTimeIndex.value == 1
                      ? "15"
                      : currentTimeIndex.value == 2
                          ? "30"
                          : "",
              "machine_condition": currentConditionIndex.value == 0
                  ? "1"
                  : currentConditionIndex.value == 1
                      ? "2"
                      : currentConditionIndex.value == 2
                          ? "3"
                          : "",
              "shop[]": shopIds,
              "page": currentPage,
              "search_by_item_code_name": searchByNameOrItemCode.text.trim(),
            },
      isLoader: isLoader,
      path: Urls.MACHINELIST,
    );
    isScroll ? apiStatus.value = true : isMachineLoaded.value = true;
    if (response != null) {
      machineList.value = machineListingFromJson(jsonEncode(response));
      for (int i = 0;
          i < (machineList.value.data?.machinesList?.data?.length ?? 0);
          i++) {
        machines?.add(machineList.value.data?.machinesList?.data?[i]);
      }
      currentPage++;
      log("Length : ${machines?.length}");
    }
  }

  Rx<shop.ShopListModel> shopList = shop.ShopListModel().obs;
  Future<void> getShopList() async {
    final response = await NetworkRequester().get(
      api: () async => await getShopList(),
      path: Urls.SHOPLIST,
    );
    if (response != null) {
      shopList.value = shop.shopListModelFromJson(jsonEncode(response));
    }
  }

  RxList<int> shopIds = <int>[].obs;

  void changeShopIds(int id) {
    shopIds.contains(id) ? shopIds.remove(id) : shopIds.add(id);
    log(shopIds.toString());
  }

  RxList<String> shopTitles = <String>[].obs;

  void changeShopTitle(String title) {
    shopTitles.contains(title)
        ? shopTitles.remove(title)
        : shopTitles.add(title);
  }
}
