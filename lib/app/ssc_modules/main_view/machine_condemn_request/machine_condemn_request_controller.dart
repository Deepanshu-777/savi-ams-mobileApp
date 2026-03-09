import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/model/scc_module_models/machine_condemn_request_list_model.dart';
import 'package:rail_weld/storage/storage.dart';
import 'package:rail_weld/widgets/custom_toast.dart';

import '../../../../routes/urls.dart';
import '../../../../service/network_requester.dart';

class MachineCondemnRequestController extends GetxController {
  final ScrollController scrollController = ScrollController();
  Rx<MachineCondemnRequestModel> machineCondemnRequestData =
      MachineCondemnRequestModel().obs;
  RxList<Datum> machineCondemnRequests = <Datum>[].obs;
  RxBool isRequestLoaded = false.obs;

  RxBool isLoading = true.obs;
  RxBool isPaginating = false.obs;
  RxBool canPaginate = true.obs;
  RxInt totalRequests = 0.obs;

  int currentPage = 1;
  RxString sortBy = "".obs;
  RxString? role = "3".obs;
 RxList<String> roleType = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    role?.value = Storage.getRole() ?? "3";
    roleType.value = Storage.getRoleType() ?? [];
    fetchMachineCondemnRequests();
    initScrollListener();
  }

  void initScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels /
              scrollController.position.maxScrollExtent >
          0.9) {
        if (!isPaginating.value && canPaginate.value) {
          fetchMachineCondemnRequests(isScroll: true);
        }
      }
    });
  }

  Future<void> fetchMachineCondemnRequests({
    bool isScroll = false,
    bool isReset = false,
  }) async {
    if (isReset) {
      machineCondemnRequests.clear();
      currentPage = 1;
      canPaginate.value = true;
    }

    if (isScroll) {
      isPaginating.value = true;
    } else {
      isLoading.value = true;
    }

    final response = await NetworkRequester().get(
      api: () async => await fetchMachineCondemnRequests(),
      query: {
        "page": currentPage,
        "sort_by": sortBy.value,
        "request_type": 'condemnation',
        // Add more filters here if needed
      },
      path: Urls.GET_MACHINE_CONDEMN_REQUEST,
      isLoader: !isScroll,
    );

    if (isScroll) {
      isPaginating.value = false;
    } else {
      isLoading.value = false;
    }

    if (response != null) {
      final model = machineCondemnRequestModelFromJson(jsonEncode(response));
      machineCondemnRequestData.value = model;
      totalRequests.value = model.data?.total ?? 0;
      // final newRequests = model.data?.machineCondemnRequests?.data as List<Datum>? ?? [];
      final newRequests = model.data?.data ?? [];
      if (newRequests.isEmpty) {
        canPaginate.value = false;
      } else {
        machineCondemnRequests.addAll(newRequests);
        currentPage++;
      }
      isRequestLoaded.value = true;
      log("Tickets loaded: ${machineCondemnRequests.length}");
    }
  }

  void changeSort(String newSortBy) {
    sortBy.value = newSortBy;
    fetchMachineCondemnRequests(isReset: true);
  }

  void resetController() {
    sortBy.value = "";
    fetchMachineCondemnRequests(isReset: true);
  }

  void resetPagination() {
    machineCondemnRequests.clear();
    currentPage = 1;
    canPaginate.value = true;
  }

  Future<void> condemnRequestProcess({
    required int request_id,
    required String action_type,
    required int machine_id,
    required int request_raised_by,
    bool isLoader = true,
  }) async {
    final response = await NetworkRequester().post(
      path: Urls.MACHINE_CONDEMN_REQUEST_PROCESS,
      data: {
        "request_id": request_id,
        "action_type": action_type,
        "machine_id": machine_id,
        "request_raised_by": request_raised_by,
      },
      isLoader: isLoader,
      api: () async => await condemnRequestProcess(
        request_id: request_id,
        action_type: action_type,
        machine_id: machine_id,
        request_raised_by: request_raised_by,
      ),
    );

    if (response != null) {
      final message = response['message'] ?? 'Action completed.';
      resetPagination();
      fetchMachineCondemnRequests();
      customToast(msg: message);
    }
  }
}
