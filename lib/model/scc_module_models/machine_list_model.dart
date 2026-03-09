import 'dart:convert';

MachineListing machineListingFromJson(String str) =>
    MachineListing.fromJson(json.decode(str));

String machineListingToJson(MachineListing data) => json.encode(data.toJson());

class MachineListing {
  bool? success;
  String? message;
  Datam? data;

  MachineListing({this.success, this.message, this.data});

  MachineListing.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Datam.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Datam {
  MachinesList? machinesList;

  Datam({this.machinesList});

  Datam.fromJson(Map<String, dynamic> json) {
    machinesList = json['Machines List'] != null
        ? new MachinesList.fromJson(json['Machines List'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.machinesList != null) {
      data['Machines List'] = this.machinesList!.toJson();
    }
    return data;
  }
}

class MachinesList {
  num? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  num? from;
  num? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  num? perPage;
  dynamic prevPageUrl;
  num? to;
  num? total;

  MachinesList(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  MachinesList.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  num? id;
  String? machineCode;
  String? name;
  String? itemCode;
  String? machineImage;
  String? status;
  String? make;
  String? location;
  num? manumenance;
  String? dateOfCommissioning;
  num? warranty;
  String? workingStatus;
  num? manumenenceCount;
  String? manumaineceOn;
  dynamic manumenenceRemainingDays;
  String? warrantyStatus;
  String? statusIndex;
  String? wrokingstatusIndex;

  bool? ifDcRequestRaisedFor;
  RequestDetails? requestDetails; // new model

  Data({
    this.id,
    this.machineCode,
    this.name,
    this.itemCode,
    this.machineImage,
    this.status,
    this.make,
    this.location,
    this.manumenance,
    this.dateOfCommissioning,
    this.warranty,
    this.workingStatus,
    this.manumenenceCount,
    this.manumaineceOn,
    this.manumenenceRemainingDays,
    this.warrantyStatus,
    this.statusIndex,
    this.wrokingstatusIndex,
    this.ifDcRequestRaisedFor,
    this.requestDetails,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    machineCode = json['machine_code'];
    name = json['name'];
    itemCode = json['item_code'];
    machineImage = json['machine_image'];
    status = json['status'];
    make = json['make'];
    location = json['location'];
    manumenance = json['manumenance'];
    dateOfCommissioning = json['date_of_commissioning'];
    warranty = json['warranty'];
    workingStatus = json['working_status'];
    manumenenceCount = json['maintenence_count'];
    manumaineceOn = json['maintainece_on'];
    manumenenceRemainingDays = json['maintenence_remaining_days'];
    warrantyStatus = json['warrantyStatus'];
    statusIndex = json['statusIndex'];
    wrokingstatusIndex = json['wrokingstatusIndex'];
    ifDcRequestRaisedFor = json['if_dc_request_raised_for'];
    requestDetails =
        json['request_details'] != null && json['request_details'] is Map
            ? RequestDetails.fromJson(json['request_details'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['machine_code'] = machineCode;
    data['name'] = name;
    data['item_code'] = itemCode;
    data['machine_image'] = machineImage;
    data['status'] = status;
    data['make'] = make;
    data['location'] = location;
    data['manumenance'] = manumenance;
    data['date_of_commissioning'] = dateOfCommissioning;
    data['warranty'] = warranty;
    data['working_status'] = workingStatus;
    data['maintenence_count'] = manumenenceCount;
    data['maintainece_on'] = manumaineceOn;
    data['maintenence_remaining_days'] = manumenenceRemainingDays;
    data['warrantyStatus'] = warrantyStatus;
    data['statusIndex'] = statusIndex;
    data['wrokingstatusIndex'] = wrokingstatusIndex;
    data['if_dc_request_raised_for'] = ifDcRequestRaisedFor;
    if (requestDetails != null) {
      data['request_details'] = requestDetails!.toJson();
    }
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }

  
}

class RequestDetails {
  int? id;
  int? machineId;
  String? requestType;
  int? requestRaisedBy;
  int? actionBy;
  String? status;
  String? supportAttachment;
  String? requestByRemarks;
  String? actionByRemarks;
  String? actionedAt;
  String? createdAt;
  String? updatedAt;

  RequestDetails({
    this.id,
    this.machineId,
    this.requestType,
    this.requestRaisedBy,
    this.actionBy,
    this.status,
    this.supportAttachment,
    this.requestByRemarks,
    this.actionByRemarks,
    this.actionedAt,
    this.createdAt,
    this.updatedAt,
  });

  RequestDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    machineId = json['machine_id'];
    requestType = json['request_type'];
    requestRaisedBy = json['request_raised_by'];
    actionBy = json['action_by'];
    status = json['status'];
    supportAttachment = json['support_attachment'];
    requestByRemarks = json['request_by_remarks'];
    actionByRemarks = json['action_by_remarks'];
    actionedAt = json['actioned_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['machine_id'] = machineId;
    data['request_type'] = requestType;
    data['request_raised_by'] = requestRaisedBy;
    data['action_by'] = actionBy;
    data['status'] = status;
    data['support_attachment'] = supportAttachment;
    data['request_by_remarks'] = requestByRemarks;
    data['action_by_remarks'] = actionByRemarks;
    data['actioned_at'] = actionedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


