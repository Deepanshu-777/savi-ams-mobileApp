import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../model/scc_module_models/tickets_list_model.dart';
import '../../../../routes/urls.dart';
import '../../../../service/network_requester.dart';
import '../../../../storage/storage.dart';

class TotalTicketsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getTicketList();
  }

  int currentPage = 1;
  RxInt ticketRequestCount = 0.obs;
  RxBool apiStatus = true.obs;
  RxBool isMachineLoaded = true.obs;
  Rx<TicketListing> ticketList = TicketListing().obs;
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
      }
    }
  }

  Future<void> getTicketList({
    bool isLoader = true,
    bool isScroll = false,
  }) async {
    isScroll ? apiStatus.value = false : isMachineLoaded.value = false;
    final response = await NetworkRequester().post(
      api: () async => await getTicketList(),
      path: Urls.TICKETLIST,
      isLoader: isLoader,
      data: {
        "user_id": Storage.getUserId(),
      },
    );
    isScroll ? apiStatus.value = true : isMachineLoaded.value = true;

    if (response != null) {
      ticketList.value = ticketListingFromJson(
        jsonEncode(response),
      );
    }
  }

  String convertTime({
    required String time,
  }) {
    DateTime dateTime = DateFormat("HH:mm:ss").parse(time);
    String formattedTime = DateFormat("h:mm a").format(dateTime);
    return formattedTime;
  }
}
