import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/rating.dart';
import 'package:flutter_cahoi_barbershop/core/models/task.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/history_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/button_login.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/loading_dialog.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/success_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RatingTaskView extends StatefulWidget {
  const RatingTaskView({Key? key}) : super(key: key);

  static String name = '/rating-task';

  @override
  State<RatingTaskView> createState() => _RatingTaskViewState();
}

class _RatingTaskViewState extends State<RatingTaskView> {
  Task? task;
  Rating? rating;
  late Size size;
  dynamic ratingCommunication = 0;
  dynamic ratingSkill = 0;
  dynamic ratingSecure = 0;
  dynamic ratingCheckout = 0;
  dynamic ratingAssessment = 0;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg != null) {
      task = arg as Task;
    }

    return BaseView<HistoryModel>(
      onModelReady: (model) async {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          LoadingDialog.show(context);
        });
        if (task != null) {
          rating = await model.checkRatingTask(taskId: task!.id);
        }

        LoadingDialog.dismiss(context);

        if (rating != null) {
          setState(() {
            ratingCommunication = rating!.communicationRate;
            ratingSkill = rating!.skillRate;
            ratingAssessment = rating!.assessment;
            ratingSecure = rating!.secure;
            ratingCheckout = rating!.checkout;
            commentController.text = rating?.comment ?? "";
          });
        }
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                    child: Text(
                      rating == null
                          ? appLang(context)!.please_review
                          : appLang(context)!.reviewed,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontFamily: fontBold,
                      ),
                    ),
                  ),
                ),
                Text(
                  appLang(context)!.comment_review,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  appLang(context)!.stylist,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontFamily: fontBold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: borderRadius8,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      _rowRating(
                        label: appLang(context)!.communicate,
                        initValue: ratingCommunication,
                        onChange: (point) {
                          ratingCommunication = point;
                        },
                      ),
                      _rowRating(
                        label: appLang(context)!.skill,
                        initValue: ratingSkill,
                        onChange: (point) {
                          ratingSkill = point;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  appLang(context)!.other,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontFamily: fontBold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: borderRadius8,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      _rowRating(
                        label: appLang(context)!.assessment,
                        initValue: ratingAssessment,
                        onChange: (point) {
                          ratingAssessment = point;
                        },
                      ),
                      _rowRating(
                        label: appLang(context)!.security,
                        initValue: ratingSecure,
                        onChange: (point) {
                          ratingSecure = point;
                        },
                      ),
                      _rowRating(
                        label: "Checkout",
                        initValue: ratingCheckout,
                        onChange: (point) {
                          ratingCheckout = point;
                        },
                      ),
                    ],
                  ),
                ),
                TextField(
                  maxLines: 3,
                  maxLength: 250,
                  controller: commentController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  readOnly: rating != null,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    hintText: appLang(context)!.suggestions,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 2),
                    ),
                  ),
                ),
                Visibility(
                  visible: rating == null,
                  child: Center(
                    child: BaseButton(
                      onPressed: () async {
                        LoadingDialog.show(context);
                        Map<String, dynamic> data = {
                          "task_id": task?.id,
                          "communication_rate": ratingCommunication,
                          "skill_rate": ratingSkill,
                          "assessment": ratingAssessment,
                          "secure": ratingSecure,
                          "checkout": ratingCheckout,
                          "comment": commentController.text.trim()
                        };

                        if (await model.saveRating(data: data)) {
                          LoadingDialog.dismiss(context);
                          SuccessDialog.show(context);
                        } else {
                          Fluttertoast.cancel();
                          Fluttertoast.showToast(
                              msg: appLang(context)!.has_error);
                        }
                      },
                      title: appLang(context)!.save,
                      height: 50,
                      width: size.width * 0.7,
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

  _rowRating({
    String label = "label",
    dynamic initValue = 0,
    required Function(double point) onChange,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          RatingBar(
            initialRating: double.parse("$initValue"),
            direction: Axis.horizontal,
            allowHalfRating: true,
            ignoreGestures: rating != null,
            itemCount: 5,
            ratingWidget: RatingWidget(
              full: const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              half: const Icon(
                Icons.star_half,
                color: Colors.yellow,
              ),
              empty: const Icon(
                Icons.star_border,
                color: Colors.yellow,
              ),
            ),
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: onChange,
          ),
        ],
      );
}
