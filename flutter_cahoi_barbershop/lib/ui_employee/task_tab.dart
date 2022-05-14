import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/screen_arguments.dart';
import 'package:flutter_cahoi_barbershop/core/models/task.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/stylist_model/report_task_model.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/loading_dialog.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({Key? key}) : super(key: key);

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  Size size = Size.zero;
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BaseView<ReportTaskModel>(
      onModelReady: (model) async {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          LoadingDialog.show(context);
        });

        await model.changeTasksToday('');

        scrollController.addListener(() async {
          if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              !model.isLoading) {
            await model.changeTasksToday(
                searchController.text.isEmpty ? null : searchController.text);
          }
        });
        LoadingDialog.dismiss(context);
      },
      builder: (context, model, child) {
        return Column(
          children: [
            Container(
              height: 40,
              margin: const EdgeInsets.all(12.0),
              child: CupertinoSearchTextField(
                controller: searchController,
                onChanged: (value) async {
                  if (!model.isLoading) {
                    model.changeIsLoading();
                    Timer(const Duration(seconds: 1), () async {
                      model.resetData();
                      await model.changeTasksToday(searchController.text.isEmpty
                          ? null
                          : searchController.text);
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: model.tasks.isEmpty
                  ? Center(
                      child: Image.asset(
                        'assets/not_item.png',
                        height: size.width * 0.5,
                        // width: ,
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: model.tasks.length,
                      itemBuilder: (context, index) => _buildTaskTile(
                        model.tasks[index],
                        onReload: () async {
                          model.resetData();
                          await model.changeTasksToday('');
                        },
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  _buildTaskTile(Task task, {required Function() onReload}) => Container(
        height: size.height * 0.1,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        width: size.width,
        child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(12.0),
          child: InkWell(
            onTap: () async {
              dynamic res = await Navigator.pushNamed(
                context,
                '/report-task',
                arguments: ScreenArguments(
                  "",
                  task,
                ),
              );

              if (res != null && res) {
                Timer(const Duration(microseconds: 100), () {
                  onReload();
                });
              }
            },
            borderRadius: BorderRadius.circular(12.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network("${task.customer?.avatar}"),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${task.customer?.name}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${task.date} ${task.time?.time}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
