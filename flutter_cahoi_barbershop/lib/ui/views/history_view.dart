import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/history_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/box_info.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/components/list_history.dart';
import 'package:showcaseview/showcaseview.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  Size size = Size.zero;
  final user = locator<AuthenticationService>().user;
  ScrollController scrollController = ScrollController();

  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<HistoryModel>(
      onModelReady: (model) async {
        await model.changeTasksHistory();

        await model.changeSumSpent();

        scrollController.addListener(() async {
          if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              !model.isLoading) {
            await model.changeTasksHistory();
          }
        });
      },
      builder: (context, model, child) {
        return ShowCaseWidget(
          builder: Builder(builder: (context) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                title: Text(appLang(context)!.navi_home_history),
              ),
              floatingActionButton: Showcase(
                key: _globalKey,
                description:
                    '${appLang(context)!.desc_spent}: ${model.sumSpent ?? 0}K',
                child: FloatingActionButton.extended(
                  onPressed: () {
                    ShowCaseWidget.of(context)!.startShowCase([_globalKey]);
                  },
                  label: Text(
                    "${appLang(context)!.spent}: ${model.sumSpent ?? 0}K",
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            BoxInfo(
                              height: size.height * 0.1,
                              title: appLang(context)!.full_name,
                              content: "${user.name}",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BoxInfo(
                              height: size.height * 0.1,
                              title: "Email",
                              content: "${user.email}",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BoxInfo(
                              height: size.height * 0.1,
                              title: appLang(context)!.phone_number,
                              content: "${user.phoneNumber}",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.height * 0.6,
                        margin: const EdgeInsets.only(
                          bottom: 70,
                        ),
                        child: model.tasks.isEmpty
                            ? Center(
                                child: Text(
                                  appLang(context)!.warning_history,
                                ),
                              )
                            : ListHistory(
                                controller: scrollController,
                                tasks: model.tasks,
                                onCancelTask: (int taskId) async {
                                  await model.cancelTask(id: taskId);
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
