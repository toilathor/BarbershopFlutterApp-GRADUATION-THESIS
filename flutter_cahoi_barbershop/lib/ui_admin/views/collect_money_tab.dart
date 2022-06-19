import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/revenue.dart';
import 'package:flutter_cahoi_barbershop/core/services/locale_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/admin_model/collect_money_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:showcaseview/showcaseview.dart';

class CollectMoneyTab extends StatefulWidget {
  const CollectMoneyTab({Key? key}) : super(key: key);

  @override
  State<CollectMoneyTab> createState() => _CollectMoneyTabState();
}

class _CollectMoneyTabState extends State<CollectMoneyTab>
    with TickerProviderStateMixin {
  late Size size;

  bool isPercent = true;

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<CollectMoneyModel>(
      onModelReady: (model) async {
        await model.fetchTotalMonth();
        await model.changeRevenueMonth(true);
        await model.changeRevenueMonth(false);
        model.changeDataChart();
      },
      builder: (context, model, child) => DefaultTabController(
        length: 2,
        initialIndex: currentTab,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                isPercent = !isPercent;
              });
            },
            child: Icon(
              isPercent ? Icons.percent : Icons.numbers,
            ),
          ),
          body: SizedBox(
            height: size.height,
            child: Column(
              children: [
                Container(
                  color: primaryColor,
                  child: TabBar(
                    indicatorWeight: 5,
                    onTap: (index) {
                      setState(() {
                        currentTab = index;
                      });
                    },
                    tabs: const [
                      Tab(text: "Tháng này"),
                      Tab(text: "Tháng trước"),
                    ],
                  ),
                ),
                Visibility(
                  visible: currentTab == 0
                      ? model.dataChartFirst.isNotEmpty
                      : model.dataChartSecond.isNotEmpty,
                  child: PieChart(
                    dataMap: currentTab == 0
                        ? model.dataChartFirst
                        : model.dataChartSecond,
                    chartLegendSpacing: 5,
                    chartValuesOptions: ChartValuesOptions(
                      chartValueStyle: const TextStyle(
                        fontSize: 8,
                        color: Colors.black,
                      ),
                      chartValueBackgroundColor: Colors.white54,
                      showChartValueBackground: true,
                      showChartValuesInPercentage: !isPercent,
                      // showChartValues: true,
                    ),
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: currentTab == 0
                        ? model.revenueFirst.length
                        : model.revenueSecond.length,
                    itemBuilder: (context, index) {
                      final revenue = (currentTab == 0
                          ? model.revenueFirst[index]
                          : model.revenueSecond[index]);

                      String total = NumberFormat.currency(
                        locale: locator<LocaleService>().locale.countryCode,
                        name: "VND",
                        symbol: "₫",
                      ).format(revenue.totalRevenueMonth * 1000);

                      return RevenueTile(
                        revenue: revenue,
                        isShowPaid: currentTab == 1,
                        onPaid: currentTab == 1 && revenue.isPaid != 1
                            ? () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.QUESTION,
                                  title: "Xác nhận",
                                  desc: "Cơ sở này đã nộp đủ $total",
                                  btnOkOnPress: () async {
                                    await model.paid(
                                      revenueId: revenue.id,
                                    );
                                  },
                                  btnCancelOnPress: () {},
                                ).show();
                              }
                            : () {
                                Fluttertoast.cancel();
                                Fluttertoast.showToast(
                                  msg: "Chưa tới hạn nộp!",
                                );
                              },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RevenueTile extends StatelessWidget {
  RevenueTile({
    Key? key,
    required this.revenue,
    this.onPaid,
    this.isShowPaid = false,
  }) : super(key: key);

  final Revenue revenue;
  final bool isShowPaid;
  final Function()? onPaid;

  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String total = NumberFormat.currency(
      locale: locator<LocaleService>().locale.countryCode,
      name: "VND",
      symbol: "₫",
    ).format(revenue.totalRevenueMonth * 1000);

    return ShowCaseWidget(
      builder: Builder(builder: (context) {
        return ListTile(
          onTap: onPaid,
          onLongPress: () {
            ShowCaseWidget.of(context)!.startShowCase([_globalKey]);
          },
          leading: ClipRRect(
            child: Image.network("$localHost${revenue.facility!.image}"),
            borderRadius: borderRadius8,
          ),
          trailing: isShowPaid
              ? Showcase(
                  description: revenue.isPaid == 1
                      ? "Cơ sở này đã nộp tiền"
                      : "Nhấn vào để xác nhận cơ sở đã nộp tiền",
                  key: _globalKey,
                  child: Icon(
                    revenue.isPaid == 1 ? Icons.check : Icons.paid_outlined,
                    color: revenue.isPaid == 1 ? Colors.green : Colors.yellow,
                    shadows: [
                      Shadow(
                        color: revenue.isPaid == 1
                            ? Colors.lightGreen
                            : Colors.yellowAccent,
                        blurRadius: 4,
                        offset: Offset.zero,
                      ),
                    ],
                  ),
                )
              : null,
          title: Text(
            revenue.facility!.address.toString(),
            style: const TextStyle(
              fontFamily: fontBold,
            ),
          ),
          subtitle: Text(
            total,
          ),
        );
      }),
    );
  }
}
