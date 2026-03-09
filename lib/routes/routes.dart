// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  static const SPLASH = "/";
  static const ONBOARDING = "/onBoarding";
  static const LOGIN = "/login";
  static const SIGNUP = "/signUp";
  static const MAINVIEW = "/mainView";
  static const HOME = "/home";
  static const TOTALMACHINES = "/totalMachines";
  static const TOTALTICKETS = "/totalTickets";
  static const MACHINEDETAILS = "/machineDetails";
  static const RAISETICKET = "/raiseTicket";
  static const TICKETRAISED = "/ticketRaised";
  static const SETTINGS = "/settings";
  static const BARCODESCANNER = "/barCodeScanner";
  static const ANALYTICS = "/analytics";
  static const FORGOTPASSWORD = "/forgot_password";
  static const OTPVERIFICATION = "/otp_verfication";
  static const CHANGEPASSWORD = "/change_password";
  static const ADDMACHINE = "/add_machine";
  static const NOTIFICATIONS = "/notifications";
  static const TICKETREQUESTS = "/ticket_requests";

  static const MACHINECONDEMNREQUEST = "/machine_condemn_request";
  // Response team routes

  static const RESPONSEMAINVIEW = "/response_main_view";
  static const RESPONSEHOMEVIEW = "/response_home_view";
  static const SCHEDULEDMAINTENANCE = "/scheduled_maintenance";
  static const TICKETMAINTENANCE = "/ticket_maintenance";
  static const RTICKETDETAIL = "/ticket_detail";
  static const MAINTENANCEDETAIL = "/maintenance_detail";
  static const TICKETRESOLVEFORM = "/ticket-resolve-form";
  static const REMARK = "/remark";
  static const RESMACHINELIST = "/res_machine_list";
  static const RESMACHINEDETAILS = "/res_machine_details";
  static const RESBARCODESCANNER = "/res_bar_code_scanner";
}
