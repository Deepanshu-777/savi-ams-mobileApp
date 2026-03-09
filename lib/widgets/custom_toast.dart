import 'package:fluttertoast/fluttertoast.dart';

import '../theme/app_colors.dart';

Future<void> customToast({
  String msg = "      Ticket Acknowledged!     ",
}) {
  return Fluttertoast.showToast(
    msg: msg,
    backgroundColor: AppColors.navyBlue,
    textColor: AppColors.white,
    fontSize: 14,
    gravity: ToastGravity.BOTTOM,
  );
}
