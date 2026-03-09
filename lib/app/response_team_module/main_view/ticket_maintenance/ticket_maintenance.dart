import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/decorated_box.dart';
import '../../../ssc_modules/main_view/home/widget.dart';
import 'ticket_maintenance_controller.dart';
import 'widgets.dart';

class TicketMaintenanceView extends GetView<TicketMaintenanceController> {
  const TicketMaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Column(
        children: [
          homeAppBar(),
          decoratedBox(
            width: width,
            padding: const EdgeInsets.only(
              top: 30,
            ),
            children: ticketSection(
              width: width,
              height: height,
            ),
          ),
        ],
      ),
    );
  }
}
