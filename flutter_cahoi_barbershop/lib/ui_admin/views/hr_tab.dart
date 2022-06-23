import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/screen_arguments.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/admin_model/hr_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/loading_dialog.dart';

class HRTab extends StatefulWidget {
  const HRTab({Key? key}) : super(key: key);

  @override
  State<HRTab> createState() => _HRTabState();
}

class _HRTabState extends State<HRTab> {
  Size size = Size.zero;
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BaseView<HRModel>(
      onModelReady: (model) async {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          LoadingDialog.show(context);
        });

        scrollController.addListener(() async {
          if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              !model.isLoading) {
            await model.changeUsers(
                searchController.text.isEmpty ? null : searchController.text);
          }
        });

        await model.changeUsers(
            searchController.text.isEmpty ? null : searchController.text);

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
                      await model.changeUsers(searchController.text.isEmpty
                          ? null
                          : searchController.text);
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: model.users.isEmpty
                  ? Center(
                      child: Image.asset(
                        'assets/not_item.png',
                        height: size.width * 0.5,
                        // width: ,
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        model.resetData();
                        await model.changeUsers(searchController.text);
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: model.users.length,
                        itemBuilder: (context, index) => _buildUserTile(
                          model.users[index],
                          onReload: () async {
                            model.resetData();
                            await model.changeUsers('');
                          },
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  _buildUserTile(MUser user, {required Function() onReload}) => Container(
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
                '/edit-user',
                arguments: ScreenArguments(
                  "",
                  user,
                ),
              );

              if (res != null && res) {
                Timer(const Duration(microseconds: 100), () {
                  logger.d("ok");
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
                    borderRadius: borderRadiusCircle,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        user.avatar != null
                            ? "$localHost${user.avatar}"
                            : avatarDefault,
                        fit: BoxFit.cover,
                      ),
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
                        "${user.name}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${user.roles != null ? user.roles![0].name : "None"}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 16,
                        ),
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
