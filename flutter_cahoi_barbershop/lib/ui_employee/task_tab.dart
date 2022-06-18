import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/screen_arguments.dart';
import 'package:flutter_cahoi_barbershop/core/models/task.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/stylist_model/report_task_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/server_config.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/components/custom_dropdown.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/loading_dialog.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/no_item.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({Key? key}) : super(key: key);

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  Size size = Size.zero;
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  int indexFilDay = 0;
  int typeTask = 0;

  Future loadData(ReportTaskModel model) async {
    await model.changeTasks(
      searchController.text.isEmpty ? null : searchController.text,
      addDay: indexFilDay,
      type: typeTask,
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BaseView<ReportTaskModel>(
      onModelReady: (model) async {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          LoadingDialog.show(context);
        });

        await model.changeTasks('');

        scrollController.addListener(() async {
          if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              !model.isLoading) {
            loadData(model);
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
                      await model.changeTasks(searchController.text.isEmpty
                          ? null
                          : searchController.text);
                    });
                  }
                },
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
              height: 50,
              width: size.width,
              child: _buildFilter(
                onFilterDay: (value) {
                  setState(() {
                    indexFilDay = filDay.indexOf(value);
                  });
                  model.resetData();
                  loadData(model);
                },
                onFilterType: (String value) {
                  setState(() {
                    typeTask = filTypeTask.indexOf(value);
                  });
                  model.resetData();
                  loadData(model);
                },
              ),
            ),
            Expanded(
              child: model.tasks.isEmpty
                  ? const NoItemWidget()
                  : ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: model.tasks.length,
                      itemBuilder: (context, index) => _buildTaskTile(
                        model.tasks[index],
                        onReload: () async {
                          model.resetData();
                          await model.changeTasks('');
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
          color:
              task.status! != 1 ? Colors.amber.shade100 : Colors.green.shade100,
          borderRadius: BorderRadius.circular(12.0),
          child: InkWell(
            onTap: () async {
              if (task.status != 1) {
                dynamic res = await Navigator.pushNamed(
                  context,
                  '/report-task',
                  arguments: ScreenArguments(
                    "",
                    task,
                  ),
                );

                if (res != null && res) {
                  Timer(const Duration(microseconds: 500), () {
                    onReload();
                  });
                }
              } else {
                Navigator.pushNamed(
                  context,
                  '/show-task',
                  arguments: ScreenArguments(
                    "",
                    task,
                  ),
                );
              }
            },
            borderRadius: BorderRadius.circular(12.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: borderRadiusCircle,
                    child: Image.network(
                      task.customer?.avatar != null
                          ? "$localHost${task.customer?.avatar}"
                          : avatarDefault,
                      fit: BoxFit.cover,
                    ),
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

  Widget _buildFilter({
    required Function(String value) onFilterDay,
    required Function(String value) onFilterType,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: CustomStringDropDown(
            onChanged: onFilterType,
            values: filTypeTask,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: CustomStringDropDown(
            onChanged: onFilterDay,
            values: filDay,
          ),
        ),
      ],
    );
  }
}
