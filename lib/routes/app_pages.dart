import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/home/response_home.dart';
import 'package:rail_weld/app/response_team_module/main_view/maintenance/maintenance.dart';
import 'package:rail_weld/app/response_team_module/main_view/maintenance/maintenance_binding.dart';
import 'package:rail_weld/app/response_team_module/main_view/res_machine_list/res_machine_list.dart';
import 'package:rail_weld/app/response_team_module/main_view/response_main_view.dart';
import 'package:rail_weld/app/response_team_module/maintenance_detail/maintenance_detail.dart';
import 'package:rail_weld/app/response_team_module/remark/remark.dart';
import 'package:rail_weld/app/response_team_module/res_machine_details/res_machine_details.dart';
import 'package:rail_weld/app/response_team_module/res_machine_details/res_machine_details_binding.dart';
import 'package:rail_weld/app/response_team_module/ticket_resolve_form/ticket_resolve_form.dart';
import 'package:rail_weld/app/response_team_module/ticket_resolve_form/ticket_resolve_form_binding.dart';
import 'package:rail_weld/app/ssc_modules/add_machine/add_machine_binding.dart';
import 'package:rail_weld/app/ssc_modules/bar_code_scanner/bar_code_scanner.dart';
import 'package:rail_weld/app/ssc_modules/change_password/change_password.dart';
import 'package:rail_weld/app/ssc_modules/forgot_password/forgot_password.dart';
import 'package:rail_weld/app/ssc_modules/machine_details/machine_details.dart';
import 'package:rail_weld/app/ssc_modules/machine_details/machine_details_binding.dart';
import 'package:rail_weld/app/ssc_modules/main_view/analytics/analytics.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_binding.dart';
import 'package:rail_weld/app/ssc_modules/main_view/machine_condemn_request/machine_condemn_request.dart';
import 'package:rail_weld/app/ssc_modules/main_view/machine_condemn_request/machine_condemn_request_binding.dart';
import 'package:rail_weld/app/ssc_modules/main_view/main_view.dart';
import 'package:rail_weld/app/ssc_modules/main_view/main_view_binding.dart';
import 'package:rail_weld/app/ssc_modules/login/login.dart';
import 'package:rail_weld/app/ssc_modules/login/login_binding.dart';
import 'package:rail_weld/app/ssc_modules/main_view/ticket_request/ticket_request.dart';
import 'package:rail_weld/app/ssc_modules/main_view/ticket_request/ticket_request_binding.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/total_machines.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/total_machines_binding.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_tickets/total_tickets.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_tickets/total_ticlets_binding.dart';
import 'package:rail_weld/app/ssc_modules/on_boarding/on_boarding_binding.dart';
import 'package:rail_weld/app/ssc_modules/raise_ticket/raise_ticket.dart';
import 'package:rail_weld/app/ssc_modules/raise_ticket/raise_ticket_binding.dart';
import 'package:rail_weld/app/ssc_modules/settings/settings.dart';
import 'package:rail_weld/app/ssc_modules/sign_up/sign_up.dart';
import 'package:rail_weld/app/ssc_modules/sign_up/sign_up_binding.dart';
import 'package:rail_weld/app/ssc_modules/splash/splash_binding.dart';
import 'package:rail_weld/app/ssc_modules/ticket_raised/ticket_raised.dart';
import 'package:rail_weld/app/ssc_modules/ticket_raised/ticket_raised_binding.dart';

import '../app/response_team_module/main_view/home/response_home_binding.dart';
import '../app/response_team_module/main_view/res_bar_code_scanner/res_bar_code_scanner.dart';
import '../app/response_team_module/main_view/res_bar_code_scanner/res_bar_code_scanner_binding.dart';
import '../app/response_team_module/main_view/res_machine_list/res_machine_list_binding.dart';
import '../app/response_team_module/main_view/response_main_view_binding.dart';
import '../app/response_team_module/main_view/ticket_maintenance/ticket_maintenance.dart';
import '../app/response_team_module/main_view/ticket_maintenance/ticket_maintenance_binding.dart';
import '../app/response_team_module/maintenance_detail/maintenance_detail_binding.dart';
import '../app/response_team_module/remark/remark_binding.dart';
import '../app/response_team_module/ticket_detail/ticket_detail.dart';
import '../app/response_team_module/ticket_detail/ticket_detail_binding.dart';
import '../app/ssc_modules/OTP_verfication/OTP_verfication.dart';
import '../app/ssc_modules/OTP_verfication/OTP_verfication_binding.dart';
import '../app/ssc_modules/add_machine/add_machine.dart';
import '../app/ssc_modules/bar_code_scanner/bar_code_scanner_binding.dart';
import '../app/ssc_modules/change_password/change_password_binding.dart';
import '../app/ssc_modules/forgot_password/forgot_password_binding.dart';
import '../app/ssc_modules/main_view/analytics/analytics_binding.dart';
import '../app/ssc_modules/notifications/notifications.dart';
import '../app/ssc_modules/notifications/notifications_binding.dart';
import '../app/ssc_modules/on_boarding/on_boarding.dart';
import '../app/ssc_modules/settings/settings_binding.dart';
import '../app/ssc_modules/splash/splash.dart';

part 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.MAINVIEW,
      page: () => const MainView(),
      binding: MainViewBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.TOTALMACHINES,
      page: () => const TotalMachinesView(),
      binding: TotalMachinesBinding(),
    ),
    GetPage(
      name: Routes.TOTALTICKETS,
      page: () => const TotalTicketsView(),
      binding: TotalTicketsBinding(),
    ),
    GetPage(
      name: Routes.TICKETREQUESTS,
      page: () => const TicketRequestView(),
      binding: TicketRequestBinding(),
    ),
    GetPage(
      name: Routes.MACHINECONDEMNREQUEST,
      page: () => const MachineCondemnRequestView(),
      binding: MachineCondemnRequestBinding(),
    ),
    GetPage(
      name: Routes.MACHINEDETAILS,
      page: () => const MachineDetailsView(),
      binding: MachineDetailsBinding(),
    ),
    GetPage(
      name: Routes.RAISETICKET,
      page: () => const RaiseTicketView(),
      binding: RaiseTicketBinding(),
    ),
    GetPage(
      name: Routes.TICKETRAISED,
      page: () => const TicketRaisedView(),
      binding: TicketRaisedBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.BARCODESCANNER,
      page: () => const BarCodeScannerView(),
      binding: BarCodeScannerBinding(),
    ),
    GetPage(
      name: Routes.ANALYTICS,
      page: () => const AnalyticsView(),
      binding: AnalyticsBinding(),
    ),
    GetPage(
      name: Routes.FORGOTPASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.OTPVERIFICATION,
      page: () => const OTPVerificationView(),
      binding: OTPVerificationBinding(),
    ),
    GetPage(
      name: Routes.RESPONSEMAINVIEW,
      page: () => const ResponseMainView(),
      binding: ResponseMainViewBinding(),
    ),
    GetPage(
      name: Routes.RESPONSEHOMEVIEW,
      page: () => const ResponseHomeView(),
      binding: ResponseHomeBinding(),
    ),
    GetPage(
      name: Routes.TICKETMAINTENANCE,
      page: () => const TicketMaintenanceView(),
      binding: TicketMaintenanceBinding(),
    ),
    GetPage(
      name: Routes.RTICKETDETAIL,
      page: () => const RTicketDetailView(),
      binding: RTicketDetailBinding(),
    ),
    GetPage(
      name: Routes.MAINTENANCEDETAIL,
      page: () => const MaintenanceDetailView(),
      binding: MaintenanceDetailBinding(),
    ),
    GetPage(
      name: Routes.REMARK,
      page: () => const RemarkView(),
      binding: RemarkBinding(),
    ),
    GetPage(
      name: Routes.TICKETRESOLVEFORM,
      page: () => const TicketResolveFormView(),
      binding: TicketResolveFormBinding(),
    ),
    GetPage(
      name: Routes.CHANGEPASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: Routes.SCHEDULEDMAINTENANCE,
      page: () => const MaintenanceView(),
      binding: MaintenanceBinding(),
    ),
    GetPage(
      name: Routes.ADDMACHINE,
      page: () => const AddMachineView(),
      binding: AddMachineBinding(),
    ),
    GetPage(
      name: Routes.RESMACHINELIST,
      page: () => const ResMachineListView(),
      binding: ResMachineListBinding(),
    ),
    GetPage(
      name: Routes.RESMACHINEDETAILS,
      page: () => const ResMachineDetailsView(),
      binding: ResMachineDetailsBinding(),
    ),
    GetPage(
      name: Routes.RESBARCODESCANNER,
      page: () => const ResBarCodeScannerView(),
      binding: ResBarCodeScannerBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
  ];
}
