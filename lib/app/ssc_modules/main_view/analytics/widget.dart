import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/custom_sized_box.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/decorated_box.dart';
import '../../../../theme/app_colors.dart';

Widget body({
  double height = 20,
  double width = 20,
}) {
  List<FlSpot> leftData = [
    const FlSpot(10, 5),
    const FlSpot(1, 10),
    const FlSpot(2, 15),
    const FlSpot(3, 20),
  ];

  List<FlSpot> rightData = [
    const FlSpot(10, 30),
    const FlSpot(1, 5),
    const FlSpot(2, 5),
    const FlSpot(3, 4),
  ];
  return decoratedBox(
    width: width,
    children: [
      customSizedBox(height: 28),
      largeText(
        title: "Analytics",
        fontSize: 26,
        fontWeight: FontWeight.w500,
        fontColor: AppColors.black,
      ),
      customSizedBox(height: 19),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customCard(
                    height: height,
                    width: width,
                    title: "Total Hours\nLoss",
                    value: "150",
                  ),
                  customCard(
                    height: height,
                    width: width,
                    title: "Total\nIssue",
                    value: "95",
                  ),
                  customCard(
                    height: height,
                    width: width,
                    title: "Ticket\nRaised",
                    value: "95",
                  ),
                ],
              ),
              customSizedBox(height: 11),
              customCard(
                height: height,
                width: width,
                title: "Ticket\nResolved",
                value: "75",
              ),
              customSizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 36,
                  left: 9,
                  right: 13,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.3,
                    color: AppColors.graphGrey,
                  ),
                  borderRadius: BorderRadius.circular(
                    12.5,
                  ),
                ),
                height: height * 0.5,
                width: width - 40,
                child: Column(
                  children: [
                    Row(
                      children: [
                        customSizedBox(
                          width: 15,
                        ),
                        largeText(
                          title: "Monthly Ticket Raised",
                          fontSize: 16,
                          fontColor: AppColors.black,
                        ),
                        const Spacer(),
                        Container(
                          height: 11,
                          width: 11,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: AppColors.lightOrange,
                          ),
                        ),
                        customSizedBox(width: 5),
                        smallText(
                          title: "Previous Year",
                          fontSize: 12,
                          fontColor: AppColors.black,
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 35,
                        ),
                        child: LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    TextStyle style = TextStyle(
                                        color: AppColors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily: "Outfit");
                                    Widget text;
                                    switch (value.toInt()) {
                                      case 1:
                                        text = Text('Jan', style: style);
                                        break;

                                      case 3:
                                        text = Text('Mar', style: style);
                                        break;

                                      case 5:
                                        text = Text('May', style: style);
                                        break;

                                      case 7:
                                        text = Text('Jul', style: style);
                                        break;

                                      case 9:
                                        text = Text('Sep', style: style);
                                        break;

                                      case 11:
                                        text = Text('Nov', style: style);
                                        break;

                                      default:
                                        text = Text('', style: style);
                                        break;
                                    }
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: text,
                                    );
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: const Border(
                                bottom: BorderSide(
                                  color: AppColors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                            gridData: FlGridData(
                              drawVerticalLine: false,
                              drawHorizontalLine: true,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: AppColors.black.withOpacity(0.2),
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  const FlSpot(1, 1),
                                  const FlSpot(2, 12),
                                  const FlSpot(3, 3),
                                  const FlSpot(4, 4),
                                  const FlSpot(8, 14),
                                  const FlSpot(9, 9),
                                  const FlSpot(10, 17),
                                  const FlSpot(11, 11),
                                  const FlSpot(12, 25),
                                ],
                                isCurved: true,
                                barWidth: 2,
                                color: AppColors.navyBlue,
                                dotData: FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: const LinearGradient(
                                    colors: <Color>[
                                      AppColors.navyBlue,
                                      AppColors.white,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                              LineChartBarData(
                                spots: [
                                  const FlSpot(1, 5),
                                  const FlSpot(4, 13),
                                  const FlSpot(6, 6),
                                  const FlSpot(7, 7),
                                  const FlSpot(10, 1),
                                  const FlSpot(12, 5),
                                ],
                                isCurved: true,
                                barWidth: 2,
                                color: AppColors.lightOrange,
                                dotData: FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              customSizedBox(height: 15),
            ],
          ),
        ),
      )
    ],
  );
}

Widget customCard({
  required String title,
  required String value,
  double height = 20,
  double width = 20,
}) {
  return Container(
    height: height * 0.22,
    width: width * 0.28,
    padding: const EdgeInsets.symmetric(
      horizontal: 15.81,
      vertical: 24.81,
    ),
    decoration: BoxDecoration(
      color: AppColors.lightPurple,
      borderRadius: BorderRadius.circular(7),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smallText(
          title: title,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontColor: AppColors.black,
        ),
        smallText(
          title: value,
          fontSize: 33,
          fontWeight: FontWeight.w600,
          fontColor: AppColors.navyBlue,
        ),
      ],
    ),
  );
}
