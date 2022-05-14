import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/screen_arguments.dart';
import 'package:flutter_cahoi_barbershop/core/models/task.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/stylist_model/report_task_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';

class ShowTaskView extends StatefulWidget {
  const ShowTaskView({Key? key}) : super(key: key);

  @override
  State<ShowTaskView> createState() => _ShowTaskViewState();
}

class _ShowTaskViewState extends State<ShowTaskView> {
  late Size size;
  late Task task;
  late ScreenArguments arguments;
  double total = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    arguments = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    task = arguments.data;

    return BaseView<ReportTaskModel>(
      onModelReady: (model) async {
        for (var element in task.products!) {
          total += element.price;
        }

        await model.changeTask(taskId: task.id ?? 0);
      },
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 50),
            physics: const BouncingScrollPhysics(
              parent: ClampingScrollPhysics(),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.23,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        child: Material(
                          elevation: 8.0,
                          child: SizedBox(
                            height: size.height * 0.15,
                            width: size.width,
                            child: Image.asset(
                              "assets/bg_cahoibarbershop.jpg",
                              fit: BoxFit.fitWidth,
                              color: Colors.black.withOpacity(0.7),
                              colorBlendMode: BlendMode.colorBurn,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        height: size.height * 0.15,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(size.height * 0.15),
                          child: Image.network(
                            "${model.task?.customer?.avatar}",
                            errorBuilder: (context, error, stackTrace) =>
                                Container(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                  child: FittedBox(
                    child: Text(
                      model.task?.customer?.name ?? "No Name",
                      style: const TextStyle(fontFamily: fontBold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Task ${task.status! == 1 ? "Successfully" : "Await"}",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: fontBold,
                      color: task.status! == 1 ? Colors.green : Colors.amber,
                    ),
                  ),
                ),
                const Divider(),
                _buildTileBill(title: "Time:", content: "${task.time?.time}"),
                const Divider(),
                _buildTileBill(title: "Date:", content: "${task.date}"),
                const Divider(),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "Note: ${task.notes ?? "NONE"}",
                    style: const TextStyle(
                      fontFamily: fontBold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Product Use",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: fontBold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Column(
                  children: task.products!
                      .map(
                        (e) => _buildTileBill(
                          title: e.name,
                          content: "\$${e.price}",
                        ),
                      )
                      .toList(),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: fontBold,
                            color: Colors.red.shade500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "\$$total",
                          style: const TextStyle(
                            fontFamily: fontBold,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width,
                  width: size.width,
                  child: ListView.builder(
                    itemCount: task.image!.length,
                    itemBuilder: (context, index) => _buildImage(
                      source: task.image![index].link!,
                    ),
                    cacheExtent: 5000,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage({required String source}) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 8,
          borderRadius: borderRadius12,
          child: ClipRRect(
            borderRadius: borderRadius12,
            child: SizedBox(
              child: Image.network(
                "$localHost/$source",
                height: size.width,
                width: size.width,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTileBill({required String title, required String content}) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: fontBold,
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
