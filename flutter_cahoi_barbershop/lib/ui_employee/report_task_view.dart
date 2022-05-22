import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/screen_arguments.dart';
import 'package:flutter_cahoi_barbershop/core/models/task.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/stylist_model/report_task_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';

class ReportTaskView extends StatefulWidget {
  const ReportTaskView({Key? key}) : super(key: key);

  @override
  State<ReportTaskView> createState() => _ReportTaskViewState();
}

class _ReportTaskViewState extends State<ReportTaskView> {
  late Size size;
  List<PickedFile> images = [];
  late Task task;
  late ScreenArguments arguments;
  bool status = false;
  double total = 0;

  bool isReload = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    arguments = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    task = arguments.data;

    if (task.status != null && task.status == 1) {
      status = true;
    } else {
      status = false;
    }

    return WillPopScope(
      onWillPop: () async {
        if (isReload) {
          Navigator.pop(context, true);
        }
        return true;
      },
      child: BaseView<ReportTaskModel>(
        onModelReady: (model) async {
          for (var element in task.products!) {
            total += element.price;
          }

          if (task.status != null && task.status == 1) {
            status = true;
          } else {
            status = false;
          }

          await model.changeTask(taskId: task.id ?? 0);
        },
        builder: (context, model, child) => SafeArea(
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
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
                                  borderRadiusCircle,
                                  child: Image.network(
                                    "${model.task?.customer?.avatar}",
                                    errorBuilder:
                                        (context, error, stackTrace) =>
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
                            status ? "Xong" : "Đang đợi",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: fontBold,
                              color: status ? Colors.green : Colors.amber,
                            ),
                          ),
                        ),
                        const Divider(),
                        _buildTileBill(
                            title: "Giờ:", content: "${task.time?.time}"),
                        const Divider(),
                        _buildTileBill(title: "Ngày:", content: "${task.date}"),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  "Ghi chú:",
                                  style: TextStyle(
                                    fontFamily: fontBold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  task.notes ?? "NONE",
                                  style: const TextStyle(
                                    fontFamily: fontBold,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Dịch vụ sử dụng",
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
                                  "Tổng",
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
                                  "$total""K",
                                  style: const TextStyle(
                                    fontFamily: fontBold,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: images.isNotEmpty,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.centerLeft,
                    height: 28,
                    child: const FittedBox(
                      child: Text(
                        '*nhấn giữ để xóa',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.5,
                  width: size.width,
                  child: ListView.builder(
                    cacheExtent: 5000,
                    itemCount:
                        images.length < 4 ? images.length + 1 : images.length,
                    itemBuilder: (context, index) {
                      if (images.length < 4 && index == 0) {
                        return InkWell(
                          onTap: () {
                            showMenuPick();
                          },
                          borderRadius: borderRadius20,
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Container(
                                margin: const EdgeInsets.all(8.0),
                                child: const Icon(Icons.photo_camera),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: borderRadius20,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return _buildChooseImage(
                        index: images.length < 4 ? index - 1 : index,
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: size.width,
                  child: Visibility(
                    visible: images.isNotEmpty,
                    child: InkWell(
                      onTap: () async {
                        LoadingDialog.show(context);
                        var res = await model.reportTask(
                          images: images,
                          taskId: task.id ?? 0,
                        );
                        LoadingDialog.dismiss(context);
                        if (res == true) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            animType: AnimType.BOTTOMSLIDE,
                            body: const Text("Hoàn thành!"),
                            btnOkOnPress: () {
                              Navigator.pop(context, true);
                            },
                          ).show();
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.BOTTOMSLIDE,
                            body: const Text("Lỗi!"),
                            btnOkOnPress: () {},
                          ).show();
                        }
                      },
                      child: Container(
                        color: Colors.green.shade400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.send),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Xong',
                              style: TextStyle(
                                fontFamily: fontBold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChooseCamera(
      {Function()? onTap, required Icon icon, required String label}) {
    return Expanded(
      child: InkWell(
        borderRadius: borderRadius12,
        onTap: onTap,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: borderRadius12,
            color: Colors.black12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: fontBold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChooseImage({required int index}) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: borderRadius12,
          onLongPress: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.QUESTION,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Xóa',
              body: const Text("Bạn có muốn xóa ảnh này?"),
              btnOkOnPress: () {
                setState(() {
                  images.removeAt(index);
                });
              },
            ).show();
          },
          child: Material(
            elevation: 8,
            borderRadius: borderRadius12,
            child: ClipRRect(
              borderRadius: borderRadius12,
              child: SizedBox(
                height: size.width,
                width: size.width,
                child: Image.file(
                  File(images[index].path),
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showMenuPick() {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius20,
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              _buildChooseCamera(
                icon: const Icon(
                  Icons.camera,
                  color: Colors.grey,
                ),
                onTap: () async {
                  var imagePicked =
                      // ignore: invalid_use_of_visible_for_testing_member
                      await ImagePicker.platform.pickImage(
                    source: ImageSource.camera,
                  );

                  if (imagePicked != null) {
                    // getting a directory path for saving
                    // Directory appDocDir = await getApplicationSupportDirectory();
                    // String? appDocPath = appDocDir.path;

                    // File fileTemp = File(imagePicked.path);
                    //
                    // await fileTemp.copy('/data/user/0/image1.png');
                    // print('$appDocPath/image1.png');
                    setState(() {
                      images.add(imagePicked);
                    });
                  }
                },
                label: 'Camera',
              ),
              const SizedBox(
                width: 10,
              ),
              _buildChooseCamera(
                icon: const Icon(
                  Icons.collections_sharp,
                  color: Colors.grey,
                ),
                onTap: () async {
                  var imagePicked =
                      // ignore: invalid_use_of_visible_for_testing_member
                      await ImagePicker.platform.pickMultiImage();
                  if (imagePicked != null) {
                    setState(() {
                      if (images.isEmpty) {
                        images += imagePicked.take(4 - images.length).toList();
                      } else {
                        images = imagePicked.take(4).toList();
                      }
                    });
                  }
                  Navigator.pop(context);
                },
                label: 'Thư viện',
              ),
            ],
          ),
        );
      },
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
