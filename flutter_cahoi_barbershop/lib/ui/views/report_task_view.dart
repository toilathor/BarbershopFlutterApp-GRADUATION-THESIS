import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/stylist_model/report_task_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:image_picker/image_picker.dart';

class ReportTaskView extends StatefulWidget {
  const ReportTaskView({Key? key}) : super(key: key);

  @override
  State<ReportTaskView> createState() => _ReportTaskViewState();
}

class _ReportTaskViewState extends State<ReportTaskView> {
  late Size size;

  List<PickedFile> images = [];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<ReportTaskModel>(
      onModelReady: (model) async {
         await model.changeTask(taskId: 1);
      },
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                                borderRadius: BorderRadius.circular(
                                    size.height * 0.15),
                                child: Image.network(
                                  "${model.task?.customer?.avatar}",
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
                            '${model.task?.customer?.name}',
                            style: const TextStyle(fontFamily: fontBold),
                          ),
                        ),
                      ),
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
                      '*long press to delete',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.width,
                width: size.width,
                child: ListView.builder(
                  itemCount:
                      images.length < 4 ? images.length + 1 : images.length,
                  itemBuilder: (context, index) {
                    if (images.length < 4 && index == 0) {
                      return InkWell(
                        onTap: () {
                          showMenuPick();
                        },
                        child: Center(
                          child: Container(
                            height: images.isNotEmpty
                                ? size.width * 0.5
                                : size.width,
                            width: images.isNotEmpty
                                ? size.width * 0.5
                                : size.width,
                            child: const Icon(Icons.photo_camera),
                            decoration: const BoxDecoration(color: Colors.grey),
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
                child: InkWell(
                  onTap: () async {
                    model.reportTask(images: images);
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      body: const Text("Task successfully!"),
                      btnOkOnPress: () {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                      },
                    ).show();
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
                          'Success Task',
                          style: TextStyle(
                              fontFamily: fontBold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
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
              title: 'Delete',
              body: const Text("Do you want delete image from list image?"),
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
                },
                label: 'Gallery',
              ),
            ],
          ),
        );
      },
    );
  }
}
