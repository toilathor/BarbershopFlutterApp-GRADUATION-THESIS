import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/facility.dart';
import 'package:flutter_cahoi_barbershop/core/models/screen_arguments.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/admin_model/hr_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/box_info.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/button_login.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/loading_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditUserView extends StatefulWidget {
  const EditUserView({Key? key}) : super(key: key);

  @override
  State<EditUserView> createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  late ScreenArguments arguments;
  late MUser user;
  bool isEdit = false;
  late Size size;
  bool isReload = false;
  bool canSelectFacility = false;
  Roles currentRole = Roles(id: 0, name: '');
  Facility? currentFacilityTemp;

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    user = arguments.data;
    size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (isReload) {
          Navigator.pop(context, isReload);
        }

        return true;
      },
      child: BaseView<HRModel>(
        onModelReady: (model) async {
          await model.changeRoles();
          if (model.roles.isNotEmpty) {
            if (user.roles != null && user.roles!.isNotEmpty) {
              currentRole = model.roles.firstWhere(
                (element) => element.id == user.roles![0].id,
              );
            }
          }
          await model.changeFacilities();

          await model.findFacility(user: user);

          if (model.currentFacility != null) {
            canSelectFacility = true;
            currentFacilityTemp = model.currentFacility;
          }
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Visibility(
                  visible: !isEdit,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isEdit = true;
                      });
                    },
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
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
                                    borderRadius: borderRadiusCircle,
                                    child: Image.network(
                                      "${user.avatar}",
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
                                '${user.name}',
                                style: const TextStyle(fontFamily: fontBold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                BoxInfo(
                                  height: size.height * 0.1,
                                  title: "Email",
                                  content: user.email,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                BoxInfo(
                                  height: size.height * 0.1,
                                  title: "Số điện thoại",
                                  content: user.phoneNumber,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Expanded(
                                      child: Center(
                                        child: Text(
                                          "Vai trò",
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Expanded(
                                      flex: 2,
                                      child: _buildDDRole(model.roles,
                                          facility: model.currentFacility),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Visibility(
                                        visible: canSelectFacility,
                                        child: const Center(
                                          child: Text(
                                            "Cơ sở",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Expanded(
                                      flex: 2,
                                      child: _buildDDFacility(
                                        model.facilities,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isEdit,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BaseButton(
                        height: 60,
                        width: double.infinity,
                        onPressed: () async {
                          LoadingDialog.show(context);

                          final res = await model.syncRoleForUser(
                              user: user,
                              role: currentRole,
                              facility: currentFacilityTemp);
                          if (res) {
                            setState(() {
                              isEdit = false;
                              isReload = true;
                            });
                            Fluttertoast.showToast(msg: 'Thành công!');
                          } else {
                            Fluttertoast.showToast(msg: 'Lỗi!');
                          }

                          isReload = true;
                          LoadingDialog.dismiss(context);
                        },
                        title: "Lưu",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDDRole(List<Roles> roles, {required Facility? facility}) {
    return IgnorePointer(
      ignoring: !isEdit,
      child: DropdownButton<Roles>(
        isExpanded: true,
        elevation: 8,
        borderRadius: BorderRadius.circular(8.0),
        items: roles
            .map(
              (e) => DropdownMenuItem<Roles>(
                child: Text(
                  "${e.name}",
                ),
                value: e,
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            currentRole = value!;
            if (value.name!.contains('stylist')) {
              setState(() {
                canSelectFacility = true;
                currentFacilityTemp = facility;
              });
            } else {
              setState(() {
                canSelectFacility = false;
                currentFacilityTemp = null;
              });
            }
          });
        },
        focusColor: Colors.red,
        value: currentRole,
        style: TextStyle(
          color: isEdit ? Colors.deepPurple : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildDDFacility(List<Facility> facilities) {
    return Visibility(
      visible: currentFacilityTemp != null && facilities.isNotEmpty,
      child: IgnorePointer(
        ignoring: !isEdit,
        child: DropdownButton<Facility>(
          isExpanded: true,
          elevation: 8,
          borderRadius: BorderRadius.circular(8.0),
          items: facilities
              .map(
                (e) => DropdownMenuItem<Facility>(
                  child: Text(
                    "${e.address}",
                  ),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              setState(() {
                currentFacilityTemp = value!;
              });
            });
          },
          focusColor: Colors.red,
          value: currentFacilityTemp,
          style: TextStyle(
            color: isEdit ? Colors.deepPurple : Colors.grey,
          ),
        ),
      ),
    );
  }
}
