import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/discount.dart';
import 'package:flutter_cahoi_barbershop/core/models/task.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/stylist_model/report_task_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/fail_dialog.dart';

class AddVoucherView extends StatefulWidget {
  const AddVoucherView({Key? key}) : super(key: key);

  static String name = "add-voucher";

  @override
  State<AddVoucherView> createState() => _AddVoucherViewState();
}

class _AddVoucherViewState extends State<AddVoucherView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Task task = ModalRoute.of(context)!.settings.arguments as Task;

    return BaseView<ReportTaskModel>(
      onModelReady: (model) async {
        await model.changeDiscount('');
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Thêm Voucher"),
        ),
        body: Column(
          children: [
            Container(
              height: 40,
              margin: const EdgeInsets.all(12.0),
              child: CupertinoSearchTextField(
                placeholder: "Nhập code giảm giá",
                controller: searchController,
                onChanged: (value) async {
                  if (!model.isLoading) {
                    model.changeIsLoading();
                    Timer(const Duration(seconds: 1), () async {
                      model.resetData();
                      await model.changeDiscount(
                        searchController.text.isEmpty
                            ? null
                            : searchController.text,
                      );
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: model.discounts.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.QUESTION,
                      title: "Sử dụng Voucher",
                      desc: 'Áp dụng Voucher "${model.discounts[index].name}"'
                          ' vào hóa đơn?',
                      btnOkOnPress: () async {
                        var res = await model.addDiscountTask(
                          discount: model.discounts[index],
                          taskId: task.id,
                        );

                        if (res) {
                          Navigator.pop(context, model.discounts[index]);
                        } else {
                          FailDialog.show(context,
                              btnOkOnPress: () {},
                              title: 'Không thế thêm voucher này!');
                        }
                      },
                      btnCancelOnPress: () {},
                    ).show();
                  },
                  child: DiscountTile(
                    discount: model.discounts[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiscountTile extends StatelessWidget {
  const DiscountTile({Key? key, required this.discount}) : super(key: key);

  final Discount discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 10.0,
      ),
      child: Material(
        borderRadius: borderRadius8,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      discount.name ?? "",
                      style: const TextStyle(
                        fontFamily: fontBold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "- ${(discount.reduction ?? 0) * 100}%",
                      style: const TextStyle(
                          fontFamily: fontBold,
                          color: Colors.red,
                          fontSize: 16,
                          shadows: [
                            Shadow(
                              offset: Offset.zero,
                              blurRadius: 3,
                              color: Colors.red,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  discount.description ?? "",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
