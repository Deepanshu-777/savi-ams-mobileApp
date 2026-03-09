import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/widgets/custom_toast.dart';

import '../../../../model/scc_module_models/ticket_request_model.dart';
import '../../../../routes/urls.dart';
import '../../../../service/network_requester.dart';

class TicketRequestController extends GetxController {
  final ScrollController scrollController = ScrollController();
  Rx<TicketRequestModel> ticketRequestData = TicketRequestModel().obs;
  RxList<Datum> ticketRequests = <Datum>[].obs;
  RxBool isTicketsLoaded = false.obs;

  RxBool isLoading = true.obs;
  RxBool isPaginating = false.obs;
  RxBool canPaginate = true.obs;
  RxInt totalRequests = 0.obs;

  int currentPage = 1;
  RxString sortBy = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchTicketRequests();
    initScrollListener();
  }

  void initScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels /
              scrollController.position.maxScrollExtent >
          0.9) {
        if (!isPaginating.value && canPaginate.value) {
          fetchTicketRequests(isScroll: true);
        }
      }
    });
  }

  Future<void> fetchTicketRequests({
    bool isScroll = false,
    bool isReset = false,
  }) async {
    if (isReset) {
      ticketRequests.clear();
      currentPage = 1;
      canPaginate.value = true;
    }

    if (isScroll) {
      isPaginating.value = true;
    } else {
      isLoading.value = true;
    }

    final response = await NetworkRequester().get(
      api: () async => await fetchTicketRequests(),
      query: {
        "page": currentPage,
        "sort_by": sortBy.value,
        // Add more filters here if needed
      },
      path: Urls.GET_TICKET_REQUEST,
      isLoader: !isScroll,
    );

    if (isScroll) {
      isPaginating.value = false;
    } else {
      isLoading.value = false;
    }

    if (response != null) {
      final model = ticketRequestModelFromJson(jsonEncode(response));
      ticketRequestData.value = model;
      totalRequests.value = model.data?.total ?? 0;
      final newTickets = model.data?.ticketRequests?.data ?? [];
      if (newTickets.isEmpty) {
        canPaginate.value = false;
      } else {
        ticketRequests.addAll(newTickets);
        currentPage++;
      }
      isTicketsLoaded.value = true; // <- This line
      log("Tickets loaded: ${ticketRequests.length}");
    }
  }

  void changeSort(String newSortBy) {
    sortBy.value = newSortBy;
    fetchTicketRequests(isReset: true);
  }

  void resetController() {
    sortBy.value = "";
    fetchTicketRequests(isReset: true);
  }

  void resetPagination() {
    ticketRequests.clear();
    currentPage = 1;
    canPaginate.value = true;
  }

  Future<void> ticketRequestProcess({
    required int ticketRequestId,
    required String action,
    String? ticket_id,
    bool isLoader = true,
  }) async {
    final response = await NetworkRequester().post(
      path: Urls.TICKETREQUESTPROCESS,
      data: {
        "ticket_request_id": ticketRequestId,
        "action": action,
      },
      isLoader: isLoader,
      api: () async => await ticketRequestProcess(
        ticketRequestId: ticketRequestId,
        action: action,
        ticket_id: ticket_id,
      ),
    );

    if (response != null) {
      final message = response['message'] ?? 'Action completed.';
      Get.back();
      resetPagination();
      fetchTicketRequests();
      customToast(msg: message);
    }
  }

  Future<void> ticketRequestProcessNew({
    required int ticketRequestId,
    required String action,
    String? ticket_id,
    bool isLoader = true,
  }) async {
    final response = await NetworkRequester().post(
      path: Urls.TICKETREQUESTPROCESS,
      data: {
        "ticket_request_id": ticketRequestId,
        "action": action,
        "ticket_id": ticket_id,
      },
      isLoader: isLoader,
      api: () async => await ticketRequestProcess(
        ticketRequestId: ticketRequestId,
        action: action,
      ),
    );

    if (response != null) {
      final message = response['message'] ?? 'Action completed.';
      // Get.back();
      resetPagination();
      fetchTicketRequests();
      customToast(msg: message);
    }
  }
}
