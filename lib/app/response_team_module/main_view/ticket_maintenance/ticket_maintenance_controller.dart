import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:rail_weld/model/scc_module_models/ticket_request_model.dart'
    as ticketrequest;
import 'package:rail_weld/service/network_requester.dart';
import '../../../../model/scc_module_models/ticket_detail_model.dart';
import '../../../../model/scc_module_models/tickets_list_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../routes/urls.dart';
import '../../../../storage/storage.dart';
import 'package:rail_weld/model/scc_module_models/shop_list_model.dart' as shop;

class TicketMaintenanceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt currentFilterIndex = 0.obs;
  RxInt ticketRequestCount = 0.obs;
  RxList<Datum>? selectedFilterTickets = <Datum>[].obs;
  RxString sortBy = "".obs;

  String? userRole;
  List<String> assigneeTypes = [];

  late TextEditingController searchByNameOrItemCode;

  void changeFilterIndex(int currentIndex) async {
    currentFilterIndex.value = currentIndex;
    selectedFilterTickets = <Datum>[].obs;
    currentPage = 1;
    await getTicketList();
  }

  int currentPage = 1;
  RxBool apiStatus = true.obs;
  RxBool isTicketsLoaded = true.obs;
  final ScrollController scrollController = ScrollController();
  void init() {
    scrollController.addListener(() {
      scrollListener();
    });
  }

  void scrollListener() async {
    TicketsList? ticket = ticketList.value.data?.ticketsList;
    if (scrollController.position.pixels /
            scrollController.position.maxScrollExtent >
        0.9) {
      if (apiStatus.value && ((ticket?.lastPage ?? 0) >= currentPage)) {
        await getTicketList(
          isScroll: true,
        );
        ;
      }
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

  void resetFilter() {
    selectedFilterTickets?.clear();
    currentPage = 1;
    shopIds = <int>[].obs;
    shopTitles = <String>[].obs;
    searchByNameOrItemCode.clear();
    searchByNameOrItemCode.text == "";
  }

  RxList<String> shopTitles = <String>[].obs;

  void changeShopTitle(String title) {
    shopTitles.contains(title)
        ? shopTitles.remove(title)
        : shopTitles.add(title);
  }

  RxList<int> shopIds = <int>[].obs;

  void changeShopIds(int id) {
    shopIds.contains(id) ? shopIds.remove(id) : shopIds.add(id);
    log(shopIds.toString());
  }

  RxString currentAssigneeType = ''.obs;

  void changeCurrentAssigneeType(String newType) {
    currentAssigneeType.value = newType;
  }

  Future<void> fetchTicketRequests({
    bool isLoader = false,
  }) async {
    final response = await NetworkRequester().get(
        api: () async => await fetchTicketRequests(),
        path: Urls.GET_TICKET_REQUEST,
        isLoader: isLoader,
        query: {
          "status": "pending",
        });
    if (response != null) {
      final model =
          ticketrequest.ticketRequestModelFromJson(jsonEncode(response));
      ticketRequestCount.value = model.data?.total ?? 0;
    }
  }

  void resetPagination() {
    selectedFilterTickets?.clear();
    currentPage = 1;
  }

  Rx<TicketDetailModel> ticketDetails = TicketDetailModel().obs;

  Future<TicketDetailModel> getTicketDetails({
    String? ticketId,
    bool isSsc = false,
  }) async {
    final response = await NetworkRequester().post(
      api: () async => await getTicketDetails(),
      path: Urls.TICKETDETAIL,
      data: {
        "user_id": Storage.getUserId(),
        "ticket_id": ticketId,
      },
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        ticketDetails.value = ticketDetailModelFromJson(
          jsonEncode(response),
        );
        Get.toNamed(
          Routes.RTICKETDETAIL,
          arguments: isSsc,
        );
      }
    }
    return ticketDetails.value;
  }

  Future<TicketDetailModel> getTicketDetailsNew({
    String? ticketId,
    bool isSsc = false,
  }) async {
    final response = await NetworkRequester().post(
      api: () async => await getTicketDetails(),
      path: Urls.TICKETDETAIL,
      data: {
        "user_id": Storage.getUserId(),
        "ticket_id": ticketId,
      },
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        ticketDetails.value = ticketDetailModelFromJson(
          jsonEncode(response),
        );
        Get.offNamed(
          Routes.RTICKETDETAIL,
          arguments: isSsc,
        );
      }
    }
    return ticketDetails.value;
  }

  Rx<TicketListing> ticketList = TicketListing().obs;
  RxList<Datum>? tickets = <Datum>[].obs;

  Future<void> getTicketList({
    bool isLoader = true,
    bool isScroll = false,
    bool isReset = false,
  }) async {
    isScroll ? apiStatus.value = false : isTicketsLoaded.value = false;

    final Map<String, dynamic> query = {
      "status": currentFilterIndex.value == 0
          ? "raised"
          : currentFilterIndex.value == 1
              ? "acknowledged"
              : currentFilterIndex.value == 2
                  ? "resolved"
                  : currentFilterIndex.value == 3
                      ? "approved"
                      : "cancelled",
      "page": currentPage,
      "sort_by": sortBy.value,
    };
    log("isResetisResetisResetisReset ${searchByNameOrItemCode.text.trim()}");
    if (isReset) {
      query["shop[]"] = shopIds;
      query["search_by_item_code_name"] = searchByNameOrItemCode.text.trim();
      query["assignee_type"] = currentAssigneeType.value;
    }

    final response = await NetworkRequester().post(
      api: () async => await getTicketList(),
      path: Urls.TICKETLIST,
      isLoader: isLoader,
      data: {
        "user_id": Storage.getUserId(),
      },
      query: query,
    );

    isScroll ? apiStatus.value = true : isTicketsLoaded.value = true;

    if (response != null) {
      ticketList.value = ticketListingFromJson(
        jsonEncode(response),
      );
      tickets?.value = ticketList.value.data?.ticketsList?.data ?? [];
      for (int i = 0; i < (tickets?.length ?? 0); i++) {
        selectedFilterTickets?.add(tickets?[i] ?? Datum());
      }
      currentPage++;
    }
  }

  @override
  void onInit() {
    super.onInit();
    searchByNameOrItemCode = TextEditingController();
    getShopList();
    getTicketList(isLoader: false);
    fetchTicketRequests(isLoader: false);
    init();

    if (userRole == "4") {
      assigneeTypes = Storage.getRoleType() ?? [];
    } else {
      assigneeTypes = ["Power", "Millwright", "M&P Cell", "Transport"];
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
