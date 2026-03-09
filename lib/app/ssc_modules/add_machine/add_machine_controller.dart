import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rail_weld/app/response_team_module/main_view/res_machine_list/res_machine_list_controller.dart';
import 'package:rail_weld/app/response_team_module/res_machine_details/res_machine_details_controller.dart';
import 'package:rail_weld/app/ssc_modules/machine_details/machine_details_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/total_machines_controller.dart';
import 'package:rail_weld/data/strings.dart';
import 'package:rail_weld/model/scc_module_models/get_category_list.dart';
import 'package:rail_weld/model/scc_module_models/get_fac_list.dart';
import 'package:rail_weld/model/scc_module_models/get_make_list.dart';
import 'package:rail_weld/model/scc_module_models/get_plant_code_list.dart';
import 'package:rail_weld/model/scc_module_models/machine_details_edit.dart';
import 'package:rail_weld/model/scc_module_models/shop_list_model.dart';
import 'package:rail_weld/routes/urls.dart';
import 'package:rail_weld/service/network_requester.dart';
import 'package:rail_weld/storage/storage.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import 'package:rail_weld/widgets/custom_toast.dart';

import '../../../model/scc_module_models/get_vendor_list.dart';

class AddMachineController extends GetxController {
  GlobalKey<FormState> addMachineForm1 = GlobalKey();
  GlobalKey<FormState> addMachineForm2 = GlobalKey();
  GlobalKey<FormState> addMachineForm3 = GlobalKey();

  late TextEditingController machineName;
  late TextEditingController itemCode;
  late TextEditingController pressureVesselNo;
  late TextEditingController hoursPerDay;
  late TextEditingController stockHolderCode;
  late TextEditingController station;
  RxString manufactureDate = "".obs;
  RxString dateOfCommissioning = "".obs;
  RxString lastMaintenanceScheduledDate = "".obs;
  RxString lastMaintenanceDate = "".obs;
  RxString nextMaintenanceDate = "".obs;
  RxString amcFrom = "".obs;
  RxString amcTo = "".obs;
  RxString warrantyFrom = "".obs;
  RxString warrantyTo = "".obs;
  late TextEditingController make;
  late TextEditingController other_shop_name;
  late TextEditingController other_make_name;
  late TextEditingController other_category_name;
  late TextEditingController other_fac_name;
  late TextEditingController other_vendor_name;
  late TextEditingController model;
  late TextEditingController plantNumber;
  late TextEditingController poNumber;
  late TextEditingController irepsPoNumber;
  late TextEditingController gemPoNumber;
  late TextEditingController machineCost;
  late TextEditingController machinePhysicalLocation;
  late TextEditingController costOfAcquisitionInstallation;
  late TextEditingController allocation;
  RxString poDate = "".obs;
  RxString dateOfAcquisitionInstallation = "".obs;
  RxString detailsOfImprovementsDate = "".obs;
  RxString gemPoDate = "".obs;
  RxString lastTestedOn = "".obs;
  RxString nextTestDueDate = "".obs;
  RxString lastCalibratedOn = "".obs;
  RxString nextCalibrationOn = "".obs;
  RxString testCertificate = "".obs;
  late TextEditingController codelLife;
  late TextEditingController currentMarketValue;
  late TextEditingController whetherSurplus;
  late TextEditingController headQuartersUcNo;
  late TextEditingController warranty;
  late TextEditingController maintenance;
  late TextEditingController vendorPhoneNumber;
  late TextEditingController vendorEmail;
  late TextEditingController vendorLocation;
  late TextEditingController current;
  late TextEditingController voltage;
  late TextEditingController power;
  late TextEditingController efficiency;
  late TextEditingController frequency;
  late TextEditingController weight;
  late TextEditingController AMCPeriod;
  late TextEditingController height;
  late TextEditingController width;
  late TextEditingController length;
  late TextEditingController description;
  late TextEditingController capacity;
  late TextEditingController noOfShiftsUse;
  late TextEditingController detailsOfImprovementsCost;
  late TextEditingController amc_firm;
  late TextEditingController amc_firm_contact_email_id;
  late TextEditingController mc_specility;
  late TextEditingController loa_details;
  late TextEditingController remarks;
  late TextEditingController total_amc_cost;
  RxList<String> POBase64 = <String>[].obs;
  RxList<String> POLocalFiles = <String>[].obs;
  RxList<String> generalBase64 = <String>[].obs;
  RxList<String> generalLocalFiles = <String>[].obs;
  RxString machineBase64 = "".obs;
  RxString machineLocalFiles = "".obs;
  RxString testCertificateBase64 = "".obs;
  RxString testCertificateLocalFiles = "".obs;
  RxString selectedPlantCode = "".obs;
  RxInt makeId = 0.obs;
  RxString makeName = "Select Make".obs;
  RxBool isOtherMakeSelected = false.obs;
  RxString categoryName = "Category/Type of Machine".obs;
  RxInt categoryId = 0.obs;
  RxBool isOtherCategorySelected = false.obs;
  RxInt facId = 0.obs;
  RxString facName = "Fund Allocation Code".obs;
  RxBool isOtherFacSelected = false.obs;
  RxString plantCodeName = "Select Plant".obs;
  RxString amcWarrantyName = "Select".obs;
  RxString vendorId = "".obs;
  RxBool isOtherVendorSelected = false.obs;
  RxString vendorSelectFieldName = "Select Vendor".obs;
  RxBool isVendorFieldReadOnly = true.obs;
  RxString isUnderAMC = "".obs;
  MachineDetailsToEdit? details = Get.arguments;

  RxString machineType = "Machine".obs;
  RxString noOfyearsMachineryInUse = "0".obs;

  @override
  void onInit() {
    super.onInit();
    getMakeList(isLoader: false);
    getCategoryList(isLoader: false);
    getFacList(isLoader: false);
    getVendorList(isLoader: false);
    getShopList();
    getPlantCodeList();
    description = TextEditingController();
    capacity = TextEditingController();
    noOfShiftsUse = TextEditingController();
    detailsOfImprovementsCost = TextEditingController();
    amc_firm = TextEditingController();
    amc_firm_contact_email_id = TextEditingController();
    mc_specility = TextEditingController();
    loa_details = TextEditingController();
    remarks = TextEditingController();
    total_amc_cost = TextEditingController();
    gemPoNumber = TextEditingController();
    machineName = TextEditingController();
    itemCode = TextEditingController();
    pressureVesselNo = TextEditingController();
    hoursPerDay = TextEditingController();
    stockHolderCode = TextEditingController();
    station = TextEditingController();
    make = TextEditingController();
    other_shop_name = TextEditingController();
    other_make_name = TextEditingController();
    other_category_name = TextEditingController();
    other_fac_name = TextEditingController();
    other_vendor_name = TextEditingController();
    model = TextEditingController();
    plantNumber = TextEditingController();
    poNumber = TextEditingController();
    irepsPoNumber = TextEditingController();
    machineCost = TextEditingController();
    machinePhysicalLocation = TextEditingController();
    costOfAcquisitionInstallation = TextEditingController();
    allocation = TextEditingController();
    codelLife = TextEditingController();
    currentMarketValue = TextEditingController();
    whetherSurplus = TextEditingController();
    headQuartersUcNo = TextEditingController();
    warranty = TextEditingController();
    maintenance = TextEditingController();
    vendorPhoneNumber = TextEditingController();
    vendorEmail = TextEditingController();
    vendorLocation = TextEditingController();
    current = TextEditingController();
    voltage = TextEditingController();
    power = TextEditingController();
    efficiency = TextEditingController();
    frequency = TextEditingController();
    weight = TextEditingController();
    AMCPeriod = TextEditingController();
    height = TextEditingController();
    width = TextEditingController();
    length = TextEditingController();
    fillDetails();
  }

  @override
  void onClose() {
    super.onClose();
    capacity.dispose();
    noOfShiftsUse.dispose();
    detailsOfImprovementsCost.dispose();
    amc_firm.dispose();
    amc_firm_contact_email_id.dispose();
    mc_specility.dispose();
    loa_details.dispose();
    total_amc_cost.dispose();
    remarks.dispose();
    description.dispose();
    gemPoNumber.dispose();
    machineName.dispose();
    itemCode.dispose();
    pressureVesselNo.dispose();
    hoursPerDay.dispose();
    stockHolderCode.dispose();
    station.dispose();
    make.dispose();
    other_shop_name.dispose();
    other_make_name.dispose();
    other_category_name.dispose();
    other_fac_name.dispose();
    other_vendor_name.dispose();
    model.dispose();
    plantNumber.dispose();
    poNumber.dispose();
    irepsPoNumber.dispose();
    machineCost.dispose();
    machinePhysicalLocation.dispose();
    costOfAcquisitionInstallation.dispose();
    codelLife.dispose();
    currentMarketValue.dispose();
    whetherSurplus.dispose();
    headQuartersUcNo.dispose();
    warranty.dispose();
    maintenance.dispose();
    vendorPhoneNumber.dispose();
    vendorEmail.dispose();
    vendorLocation.dispose();
    current.dispose();
    voltage.dispose();
    power.dispose();
    efficiency.dispose();
    frequency.dispose();
    weight.dispose();
    AMCPeriod.dispose();
    height.dispose();
    width.dispose();
    length.dispose();
  }

  RxBool isWarrantyDetails = false.obs;
  void toggleWarrantyDetails() {
    isWarrantyDetails.value = !(isWarrantyDetails.value);
    if (!(isWarrantyDetails.value)) {
      warrantyFrom.value = "";
      warrantyTo.value = "";
    }
  }

  RxBool isGem = false.obs;
  void toggleGem() {
    isGem.value = !(isGem.value);
    if (!(isGem.value)) {
      gemPoDate.value = "";
      gemPoNumber.text = "";
    }
  }

  RxBool isCompressorCheck = false.obs;

  void toggleCompressor() {
    isCompressorCheck.value = !isCompressorCheck.value;
    if (isCompressorCheck.value) {
      machineType.value = "Compressor";
    } else {
      machineType.value = "Machine";
      pressureVesselNo.clear();
      pressureVesselNo.text == "";
      hoursPerDay.clear();
      hoursPerDay.text == "";
    }
  }

  RxBool isFirstMainCheck = false.obs;
  void toggleFirstMaintenanceCheck() {
    isFirstMainCheck.value = !isFirstMainCheck.value;
  }

  void changeAMCStatus(String val) {
    isUnderAMC.value = val.replaceAll("Under", "").trim();
  }

  void fillDetails() {
    if (details != null) {
      MachineDetails? machineDetails = details?.data?.machineDetails;
      machineName.text = machineDetails?.name ?? "";
      dateOfCommissioning.value = machineDetails?.dateOfCommissioning != null
          ? (DateFormat('yyyy-MM-dd').format(
                  machineDetails?.dateOfCommissioning ?? DateTime.now()))
              .toString()
          : "";
      lastMaintenanceScheduledDate.value =
          machineDetails?.lastMaintenanceScheduledDate != null
              ? (DateFormat('yyyy-MM-dd').format(
                      machineDetails?.lastMaintenanceScheduledDate ??
                          DateTime.now()))
                  .toString()
              : "";
      lastMaintenanceDate.value = machineDetails?.lastMaintenanceDate != null
          ? (DateFormat('yyyy-MM-dd').format(
                  machineDetails?.lastMaintenanceDate ?? DateTime.now()))
              .toString()
          : "";
      nextMaintenanceDate.value = machineDetails?.nextMaintenanceDate != null
          ? (DateFormat('yyyy-MM-dd').format(
                  machineDetails?.nextMaintenanceDate ?? DateTime.now()))
              .toString()
          : "";
      makeId.value = int.parse(machineDetails?.make ?? "0");
      categoryId.value = machineDetails?.categoryOfMachineId ?? 0;
      categoryName.value = machineDetails?.categoryOfMachine ?? "";
      facId.value = machineDetails?.fundAllocationCodeId ?? 0;
      facName.value = machineDetails?.fundAllocationCode ?? "";
      loa_details.text = machineDetails?.loaDetails ?? "";
      mc_specility.text = machineDetails?.mcSpecility ?? "";
      remarks.text = machineDetails?.remarks ?? "";
      detailsOfImprovementsCost.text =
          machineDetails?.detailsOfImprovementsCost ?? "";
      detailsOfImprovementsDate.value =
          machineDetails?.detailsOfImprovementsDate ?? "";
      capacity.text = machineDetails?.capacity ?? "";
      noOfShiftsUse.text = (machineDetails?.noOfShiftsUse ?? "").toString();
      model.text = machineDetails?.model ?? "";
      plantNumber.text = machineDetails?.plantNumber ?? "";
      itemCode.text = machineDetails?.itemCode ?? "";
      pressureVesselNo.text = machineDetails?.pressureVesselNo ?? "";
      hoursPerDay.text = machineDetails?.hoursPerDay ?? "";
      stockHolderCode.text = machineDetails?.stockHolderCode ?? "";
      station.text = machineDetails?.station ?? "";
      selectedPlantCode.value = machineDetails?.plantCode ?? "";
      plantCodeName.value = machineDetails?.plantCode ?? "";
      makeName.value = machineDetails?.makeTitle ?? "";
      machineCost.text = machineDetails?.machineCost ?? "";
      machinePhysicalLocation.text =
          machineDetails?.machinePhysicalLocation ?? "";
      costOfAcquisitionInstallation.text =
          machineDetails?.costOfAcquisitionInstallation ?? "";
      allocation.text = machineDetails?.allocation ?? "";
      poNumber.text = machineDetails?.poNumber ?? "";
      irepsPoNumber.text = machineDetails?.irepsPoNumber ?? "";
      poDate.value = machineDetails?.poDate != null
          ? (DateFormat('yyyy-MM-dd')
                  .format(machineDetails?.poDate ?? DateTime.now()))
              .toString()
          : "";
      dateOfAcquisitionInstallation.value =
          machineDetails?.dateOfAcquisitionInstallation != null
              ? machineDetails?.dateOfAcquisitionInstallation ?? ""
              : "";
      detailsOfImprovementsDate.value =
          machineDetails?.detailsOfImprovementsDate != null
              ? machineDetails?.detailsOfImprovementsDate ?? ""
              : "";
      isGem.value = machineDetails?.isGemPoDetailsGiven == 0 ? false : true;
      isWarrantyDetails.value =
          machineDetails?.isAdditionalWarrantyDetailsGiven == 0 ? false : true;
      gemPoNumber.text = machineDetails?.gemPoNumber ?? "";
      gemPoDate.value = machineDetails?.gemPoDate != null
          ? (DateFormat('yyyy-MM-dd')
                  .format(machineDetails?.gemPoDate ?? DateTime.now()))
              .toString()
          : "";
      codelLife.text = machineDetails?.expiryLife ?? "";
      currentMarketValue.text = machineDetails?.currentMarketValue ?? "";
      whetherSurplus.text = machineDetails?.whetherSurplus ?? "";
      headQuartersUcNo.text = machineDetails?.headQuartersUcNo ?? "";
      warranty.text = (machineDetails?.warranty ?? "").toString();
      amcWarrantyName.value = machineDetails?.underAmc == "Warranty"
          ? Strings.UNDERWARRANTY
          : machineDetails?.underAmc == "AMC"
              ? Strings.UNDERAMC
              : machineDetails?.underAmc == "MW maintenance"
                  ? Strings.UNDERMW
                  : "";

      amcFrom.value = machineDetails?.amcFrom != null
          ? (DateFormat('yyyy-MM-dd')
                  .format(machineDetails?.amcFrom ?? DateTime.now()))
              .toString()
          : "";
      amcTo.value = machineDetails?.amcTo != null
          ? (DateFormat('yyyy-MM-dd')
                  .format(machineDetails?.amcTo ?? DateTime.now()))
              .toString()
          : "";
      warrantyFrom.value = machineDetails?.warrantyFrom != null
          ? (DateFormat('yyyy-MM-dd')
                  .format(machineDetails?.warrantyFrom ?? DateTime.now()))
              .toString()
          : "";
      warrantyTo.value = machineDetails?.warrantyTo != null
          ? (DateFormat('yyyy-MM-dd')
                  .format(machineDetails?.warrantyTo ?? DateTime.now()))
              .toString()
          : "";
      amc_firm.text = machineDetails?.amcFirm ?? "";
      amc_firm_contact_email_id.text = machineDetails?.amcFirmContactEmailId ?? "";
      description.text = machineDetails?.description ?? "";
      maintenance.text = (machineDetails?.maintenance ?? "").toString();
      vendorId.value = (machineDetails?.vendor ?? "").toString();
      vendorSelectFieldName.value = machineDetails?.vendorName ?? "";
      vendorPhoneNumber.text = machineDetails?.vendorPhoneNumber ?? "";
      vendorEmail.text = machineDetails?.vendorEmailAddress ?? "";
      vendorLocation.text = machineDetails?.vendorLocation ?? "";
      machineBase64.value = machineDetails?.machineImage ?? "";
      testCertificateBase64.value = machineDetails?.testCertificate ?? "";
      shopTitle.value = machineDetails?.location ?? "";
      lastTestedOn.value = machineDetails?.lastTestedOn != null
          ? (DateFormat('yyyy-MM-dd')
                  .format(machineDetails?.lastTestedOn ?? DateTime.now()))
              .toString()
          : "";
      ;
      nextTestDueDate.value = machineDetails?.nextTestDueDate != null
          ? (DateFormat('yyyy-MM-dd')
                  .format(machineDetails?.nextTestDueDate ?? DateTime.now()))
              .toString()
          : "";
      ;
      lastCalibratedOn.value = machineDetails?.lastCalibratedOn != null
          ? (DateFormat('yyyy-MM-dd')
                  .format(machineDetails?.lastCalibratedOn ?? DateTime.now()))
              .toString()
          : "";
      ;
      nextCalibrationOn.value = machineDetails?.nextCalibrationOn != null
          ? (DateFormat('yyyy-MM-dd')
                  .format(machineDetails?.nextCalibrationOn ?? DateTime.now()))
              .toString()
          : "";
      ;
      shopId.value = 23;
      machineType.value = (machineDetails?.machineType?.trim().isEmpty ?? true)
          ? "Machine"
          : machineDetails!.machineType!;

      isCompressorCheck.value =
          machineDetails?.machineType == "Compressor" ?? false;
      // for (int i = 0; i < (machineDetails?.poAttachments?.length ?? 0); i++) {
      //   POBase64.add(machineDetails?.poAttachments?[i].name ?? "");
      // }
      // for (int i = 0;
      //     i < (machineDetails?.generalAttachments?.length ?? 0);
      //     i++) {
      //   generalBase64.add(machineDetails?.generalAttachments?[i].name ?? "");
      // }
    }
  }

  RxInt step = 1.obs;
  Future selectDate({
    required RxString selectedDate,
    DateTime? lastDate,
  }) async {
    final ThemeData customTheme = ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: AppColors.navyBlue,
        onPrimary: AppColors.white,
        onSurface: AppColors.black,
      ), dialogTheme: DialogThemeData(backgroundColor: AppColors.lightNavyBlue),
    );
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      builder: (context, child) => Theme(
        data: customTheme,
        child: child!,
      ),
    );
    if (pickedDate != null) {
      String date = DateFormat('yyyy-MM-dd').format(pickedDate);
      selectedDate.value = date;
    }
  }

  final ImagePicker picker = ImagePicker();
  String imageBaseUrl = "data:image/png;base64,";
  RxBool isMachineImageSelected = false.obs;
  void singlePhotoSelect(
    ImageSource source,
  ) async {
    final pickedImage = await picker.pickImage(
      source: source,
      imageQuality: 20,
    );
    log("Img :: ${pickedImage?.path.toString()}");
    File file = File(pickedImage?.path ?? "");
    Uint8List bytes = file.readAsBytesSync();
    machineBase64.value = imageBaseUrl + base64Encode(bytes);
    isMachineImageSelected.value = true;
    machineLocalFiles.value = pickedImage?.path ?? "";
  }

  RxBool isTestCertificateImageSelected = false.obs;
  void singlePhotoSelectTC(
    ImageSource source,
  ) async {
    final pickedImage = await picker.pickImage(
      source: source,
      imageQuality: 20,
    );
    log("Img :: ${pickedImage?.path.toString()}");
    File file = File(pickedImage?.path ?? "");
    Uint8List bytes = file.readAsBytesSync();
    testCertificateBase64.value = imageBaseUrl + base64Encode(bytes);
    isTestCertificateImageSelected.value = true;
    testCertificateLocalFiles.value = pickedImage?.path ?? "";
  }

  void selectAttachment({
    required RxList<String> base64Image,
    required RxList<String> localImagePath,
  }) async {
    final List<XFile> pickedImage =
        await picker.pickMultiImage(imageQuality: 20);
    if (pickedImage.isNotEmpty) {
      for (int i = 0; i < pickedImage.length; i++) {
        localImagePath.add(pickedImage[i].path);
        File file = File(pickedImage[i].path);
        Uint8List bytes = file.readAsBytesSync();
        base64Image.add("${imageBaseUrl}${base64Encode(bytes)}");
      }
    }
  }

  void takePhoto({
    required RxList<String> base64Image,
    required RxList<String> localImagePath,
  }) async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );
    if (pickedImage?.path != "") {
      localImagePath.add(pickedImage?.path ?? "");
      File file = File(pickedImage?.path ?? "");
      Uint8List bytes = file.readAsBytesSync();
      base64Image.add("${imageBaseUrl}${base64Encode(bytes)}");
    }
  }

  Future<void> addMachine() async {
    String? role = Storage.getRole();
    final response = await NetworkRequester().post(
      path: Urls.ADDMACHINE,
      api: () async => await addMachine(),
      data: {
        "edit_machine":
            details != null ? details?.data?.machineDetails?.id : "",
        "name": machineName.text.trim(),
        "item_code": itemCode.text.trim(),
        "stock_holder_code": stockHolderCode.text.trim(),
        "station": station.text.trim(),
        "pressure_vessel_no": pressureVesselNo.text.trim(),
        "hours_per_day": hoursPerDay.text.trim(),
        "date_of_commissioning": dateOfCommissioning.value,
        "next_maintenance_date": nextMaintenanceDate.value,
        "last_maintenance_scheduled_date": lastMaintenanceScheduledDate.value,
        "last_maintenance_date": lastMaintenanceDate.value,
        "model": model.text.trim(),
        "make": makeId.value.toString(),
        "location": shopId.value.toString(),
        "other_shop_name": other_shop_name.text.trim(),
        "category_of_machine": categoryId.value.toString(),
        "other_category_name": other_category_name.text.trim(),
        "fund_allocation_code": facId.value.toString(),
        "other_fac_name": other_fac_name.text.trim(),
        "other_make_name": other_make_name.text.trim(),
        "other_vendor_name": other_vendor_name.text.trim(),
        "machine_cost": machineCost.text.trim(),
        "machine_physical_location": machinePhysicalLocation.text.trim(),
        // "allocation": allocation.text.trim(),
        "po_number": poNumber.text.trim(),
        "ireps_po_number": irepsPoNumber.text.trim(),
        "capacity": capacity.text.trim(),
        "no_of_shifts_use": noOfShiftsUse.text.trim(),
        "details_of_improvements_cost": detailsOfImprovementsCost.text.trim(),
        "amc_firm": amc_firm.text.trim(),
        "amc_firm_contact_email_id": amc_firm_contact_email_id.text.trim(),
        "mc_specility": mc_specility.text.trim(),
        "loa_details": loa_details.text.trim(),
        "remarks": remarks.text.trim(),
        "total_amc_cost": total_amc_cost.text.trim(),
        "po_date": poDate.value,
        "date_of_acquisition_installation": dateOfAcquisitionInstallation.value,
        "details_of_improvements_date": detailsOfImprovementsDate.value,
        "cost_of_acquisition_installation":
            costOfAcquisitionInstallation.text.trim(),
        "is_gem_po_details_given": isGem.value ? 1 : 0,
        "gem_po_number": gemPoNumber.text.trim(),
        "gem_po_date": gemPoDate.value,
        "expiry_life": codelLife.text.trim(),
        "current_market_value": currentMarketValue.text.trim(),
        "whether_surplus": whetherSurplus.text.trim(),
        "head_quarters_uc_no": headQuartersUcNo.text.trim(),
        "warranty": warranty.text.trim(),
        "under_amc": isUnderAMC.value,
        "amc_warranty_from": amcFrom.value,
        "amc_warranty_to": amcTo.value,
        "is_additional_warranty_details_given": isWarrantyDetails.value ? 1 : 2,
        "warranty_from": warrantyFrom.value,
        "warranty_to": warrantyTo.value,
        "maintenance": maintenance.text.trim(),
        "description": description.text.trim(),
        "vendor": vendorId.value,
        "vendor_name": vendorSelectFieldName.value,
        "vendor_phone_number": vendorPhoneNumber.text.trim(),
        "vendor_email_address": vendorEmail.text.trim(),
        "vendor_location": vendorLocation.text.trim(),
        "machine_image":
            isMachineImageSelected.value ? machineBase64.value : "",
        "test_certificate": isTestCertificateImageSelected.value
            ? testCertificateBase64.value
            : "",
        "po_attachments": POBase64,
        "general_attachments": generalBase64,
        "last_tested_on": lastTestedOn.value,
        "next_test_due_date": nextTestDueDate.value,
        "last_calibrated_on": lastCalibratedOn.value,
        "next_calibration_on": nextCalibrationOn.value,
        "machine_type": machineType.value.toString().toLowerCase(),
      },
    );
    if (response != null) {
      if (jsonDecode(jsonEncode(response))["success"] == true) {
        Get.back();
        customToast(msg: "Machine Added Successfully");
        details != null
            ? {
                if (role == "3" || role == "1")
                  {
                    if (Get.isRegistered<MachineDetailsController>())
                      {
                        Get.find<MachineDetailsController>().getMachineDetail(
                          machineId: (details?.data?.machineDetails?.id ?? 0),
                          isLoader: false,
                        ),
                        Get.find<TotalMachinesController>().resetPagination(),
                        Get.find<TotalMachinesController>()
                            .getMachineList(isLoader: false),
                      }
                  }
                else
                  {
                    if (Get.isRegistered<ResMachineDetailsController>())
                      {
                        Get.find<ResMachineDetailsController>()
                            .getMachineDetail(
                          machineId: (details?.data?.machineDetails?.id ?? 0),
                          isLoader: false,
                        ),
                        Get.find<ResMachineListController>().resetPagination(),
                        Get.find<ResMachineListController>()
                            .getMachineList(isLoader: false),
                      }
                  }
              } 
            : {
                if (role == "3" || role == "1")
                  {
                    if (Get.isRegistered<TotalMachinesController>())
                      {
                        Get.find<TotalMachinesController>().resetPagination(),
                        Get.find<TotalMachinesController>().getMachineList(),
                        Get.find<HomeController>()
                            .getHomeDetails(isLoader: false),
                      }
                  }
                else
                  {
                    if (Get.isRegistered<ResMachineListController>())
                      {
                        Get.find<ResMachineListController>().resetPagination(),
                        Get.find<ResMachineListController>()
                            .getMachineList(isLoader: false),
                      }
                  }
              };
      }
    }
  }

  Rx<GetPlantCodeListModel> plantCodeList = GetPlantCodeListModel().obs;
  Future<void> getPlantCodeList({
    bool isLoader = true,
  }) async {
    final response = await NetworkRequester().get(
      path: Urls.PLANTCODELIST,
      api: () async => await getPlantCodeList(),
      isLoader: isLoader,
    );
    if (response != null) {
      plantCodeList.value = getPlantCodeListModelFromJson(
        jsonEncode(response),
      );
    }
  }

  Rx<GetMakeList> makeList = GetMakeList().obs;
  Future<void> getMakeList({
    bool isLoader = true,
  }) async {
    final response = await NetworkRequester().get(
      path: Urls.MAKELIST,
      api: () async => await getMakeList(),
      isLoader: isLoader,
    );
    if (response != null) {
      makeList.value = getMakeListFromJson(
        jsonEncode(response),
      );
    }
  }

  Rx<GetCategoryList> categoryList = GetCategoryList().obs;
  Future<void> getCategoryList({
    bool isLoader = true,
  }) async {
    final response = await NetworkRequester().get(
      path: Urls.CATEGORYLIST,
      api: () async => await getMakeList(),
      isLoader: isLoader,
    );
    if (response != null) {
      categoryList.value = getCategoryListFromJson(
        jsonEncode(response),
      );
    }
  }

  Rx<GetFacList> facList = GetFacList().obs;
  Future<void> getFacList({
    bool isLoader = true,
  }) async {
    final response = await NetworkRequester().get(
      path: Urls.FACLIST,
      api: () async => await getFacList(),
      isLoader: isLoader,
    );
    if (response != null) {
      facList.value = getFacListFromJson(
        jsonEncode(response),
      );
      log("responseeeeeurhiuewr ${facList.toJson()}");
    }
  }

  Rx<GetVendorList> vendorList = GetVendorList().obs;
  Future<void> getVendorList({
    bool isLoader = true,
  }) async {
    final response = await NetworkRequester().get(
      path: Urls.VENDORLIST,
      api: () async => await getVendorList(),
      isLoader: isLoader,
    );
    if (response != null) {
      vendorList.value = getVendorListFromJson(
        jsonEncode(response),
      );
    }
  }

  String? textValidation({
    required String? val,
    required String textFieldName,
    bool isNum = false,
  }) {
    if (val == null || val.isEmpty) {
      return "$textFieldName is required.";
    } else if (isNum) {
      if (!val.isNumericOnly) {
        return "$textFieldName should be numeric.";
      }
    } else {
      return null;
    }
    return null;
  }

  Rx<ShopListModel> shopList = ShopListModel().obs;
  Future<void> getShopList() async {
    final response = await NetworkRequester().get(
      api: () async => await getShopList(),
      path: Urls.SHOPLIST,
    );
    if (response != null) {
      shopList.value = shopListModelFromJson(jsonEncode(response));
    }
  }

  RxInt shopId = 0.obs;
  RxBool isOtherShopSelected = false.obs;

  void changeShopIds(int id) {
    shopId.value = id;
    log(shopId.value.toString());
  }

  RxString shopTitle = "".obs;

  void changeShopTitle(String title) {
    shopTitle.value = title;
  }

  final GlobalKey tooltipKey = GlobalKey();
  final GlobalKey rateTooltipKey = GlobalKey();
  final GlobalKey accumulatedTooltipKey = GlobalKey();
  final GlobalKey netBookTooltipKey = GlobalKey();

  OverlayEntry? _tooltipOverlay;

  void showTooltip(BuildContext context, GlobalKey key, String message) {
    _tooltipOverlay?.remove();
    _tooltipOverlay = null;

    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    final overlay = Overlay.of(context);

    final double tooltipWidth = screenWidth * 0.6;
    final double tooltipLeft = position.dx - tooltipWidth / 2;
    final double tooltipTop = position.dy - 50;

    _tooltipOverlay = OverlayEntry(
      builder: (context) => Positioned(
        top: tooltipTop,
        left: tooltipLeft.clamp(10, screenWidth - tooltipWidth - 10),
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 200),
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: Transform.scale(
                scale: 0.95 + (0.05 * value),
                child: child,
              ),
            ),
            child: Container(
              width: tooltipWidth,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.navyBlue,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_tooltipOverlay!);

    // Auto-remove after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      _tooltipOverlay?.remove();
      _tooltipOverlay = null;
    });
  }

  void calculateNoOfYearsMachineInUse(String date) {
    if (date.isEmpty) {
      noOfyearsMachineryInUse.value = "";
      return;
    }

    try {
      final startDate = DateFormat("yyyy-MM-dd").parse(date);
      final today = DateTime.now();

      final diffDays = today.difference(startDate).inDays;
      double diffYears = diffDays / 365;

      if (diffYears < 0) diffYears = 0;

      final yearsFormatted = diffYears.toStringAsFixed(2);
      log("${startDate} , ${today},${yearsFormatted}");
      noOfyearsMachineryInUse.value = yearsFormatted;
    } catch (e) {
      noOfyearsMachineryInUse.value = "";
    }
  }

  RxString rateOfDepreciation = "".obs;
  RxString accumulatedDepreciation = "".obs;
  RxString netBookValue = "".obs;

  void calculateDepreciationValues() {
    log("hjii");
    final double cost = double.tryParse(machineCost.text) ?? 0;
    final double codalLife = double.tryParse(codelLife.text) ?? 0;
    final double yearsInUseVal =
        double.tryParse(noOfyearsMachineryInUse.value) ?? 0;

    if (cost > 0 && codalLife > 0) {
      final depreciationRate = 100 / codalLife;
      rateOfDepreciation.value = depreciationRate.toStringAsFixed(2);

      double accumulated = 0;
      if (yearsInUseVal > codalLife) {
        accumulated = 0.95 * cost;
      } else {
        accumulated = (0.95 * cost) * (yearsInUseVal / codalLife);
      }
      accumulatedDepreciation.value = accumulated.toStringAsFixed(2);
      final netBook = cost - accumulated;
      netBookValue.value = netBook.toStringAsFixed(2);
    } else {
      rateOfDepreciation.value = "";
      accumulatedDepreciation.value = "";
      netBookValue.value = "";
    }
  }
}
