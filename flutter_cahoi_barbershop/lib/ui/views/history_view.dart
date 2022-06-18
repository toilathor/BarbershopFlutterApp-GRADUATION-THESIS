import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/history_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/box_info.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/components/list_history.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  Size size = Size.zero;
  final user = locator<AuthenticationService>().user;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<HistoryModel>(
      onModelReady: (model) async {
        await model.changeTasksHistory();
        scrollController.addListener(() async {
          if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              !model.isLoading) {
            await model.changeTasksHistory();
          }
        });
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: borderRadiusCircle,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      user.avatar != null
                          ? "$localHost${user.avatar}"
                          : avatarDefault,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: Icon(
                          Icons.error,
                        ),
                      ),
                      fit: BoxFit.cover,
                      height: size.height * 0.06,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
                // height: size.height,
                width: size.width,
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
                    SizedBox(
                      height: size.height * 0.6,
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
          ),
        );
      },
    );
  }
}
