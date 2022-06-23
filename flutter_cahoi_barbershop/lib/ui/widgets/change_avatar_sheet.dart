import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/story_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/success_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ChangeAvatarSheet extends StatefulWidget {
  const ChangeAvatarSheet({Key? key, required this.image}) : super(key: key);

  final PickedFile image;

  @override
  State<ChangeAvatarSheet> createState() => _ChangeAvatarSheetState();
}

class _ChangeAvatarSheetState extends State<ChangeAvatarSheet> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<StoryModel>(
      builder: (context, model, child) => Center(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: size.width,
                  width: size.width,
                  child: Image.file(
                    File(widget.image.path),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: size.width,
                  width: size.width,
                  color: Colors.black.withOpacity(0.8),
                ),
                Container(
                  height: size.width,
                  width: size.width,
                  child: ClipRRect(
                    borderRadius: borderRadiusCircle,
                    child: Image.file(
                      File(widget.image.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                var res = await model.changeAvatar(widget.image);
                if (res) {
                  SuccessDialog.show(
                    context,
                    title: appLang(context)!.successful,
                    btnOkOnPress: () => Navigator.pop(context),
                  );
                } else {
                  Fluttertoast.showToast(msg: appLang(context)!.has_error);
                }
              },
              child: Text(
                appLang(context)!.complete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
