import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/image_db.dart';
import 'package:flutter_cahoi_barbershop/core/models/task.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/history_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListHistory extends StatefulWidget {
  const ListHistory(
      {Key? key,
      required this.controller,
      this.tasks = const [],
      required this.onCancelTask})
      : super(key: key);

  final ScrollController controller;
  final List<Task> tasks;
  final Function(int taskId) onCancelTask;

  @override
  State<ListHistory> createState() => _ListHistoryState();
}

class _ListHistoryState extends State<ListHistory> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.controller,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      physics: const BouncingScrollPhysics(parent: ClampingScrollPhysics()),
      itemCount: widget.tasks.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return HistoryTile(
          task: widget.tasks[index],
          onCancelTask: widget.onCancelTask,
        );
      },
    );
  }
}

class HistoryTile extends StatefulWidget {
  const HistoryTile({Key? key, required this.task, required this.onCancelTask})
      : super(key: key);
  final Task task;
  final Function(int taskId) onCancelTask;

  @override
  State<HistoryTile> createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: size.width * 0.85,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCoupleText(
                      first: 'Giờ: ',
                      last: "${widget.task.time?.time}",
                    ),
                    _buildCoupleText(
                      first: 'Ngày: ',
                      last: "${widget.task.date}",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Đ.g kĩ năng: ',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: RatingBarIndicator(
                                  rating: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Đ.g Giao tiếp: ',
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Expanded(
                                child: RatingBarIndicator(
                                  rating: 4,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          _buildCoupleText(
                            first: "Stylist: ",
                            last: "${widget.task.stylist!.user?.name}",
                          ),
                          _buildCoupleText(
                            first: "Cơ sở: ",
                            last: "${widget.task.stylist?.facility?.address}",
                          )
                        ],
                      ),
                    ),
                    _getStatus()
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child:
                    widget.task.image != null && widget.task.image!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: widget.task.image!
                                  .map(
                                    (e) => Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          _showBottomSheetImage(e);
                                        },
                                        child: Image.network(
                                          "$localHost/${e.link}",
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, _, __) =>
                                              Container(),
                                          height: double.infinity,
                                          width: double.infinity,
                                          cacheHeight: 500,
                                          cacheWidth: 500,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        : Center(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  color: Colors.grey.shade500,
                                ),
                                Expanded(
                                  child: Text(
                                    "Vì bạn chưa đến nên chưa có ảnh, "
                                    "nhớ tới đúng giờ nhé!",
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
              ),
              SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Visibility(
                                visible: widget.task.status == 1,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    _shareImage(task: widget.task);
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                  ),
                                  label: const Text(
                                    "Chia sẻ",
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.info_outline,
                                ),
                                label: const Text(
                                  "Chi tiết",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.task.status != 1,
                        child: TextButton(
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              title: "Hủy lịch",
                              body: const Text(
                                "Bạn có chắc chắn muốn hủy lịch không",
                                style: TextStyle(
                                  fontFamily: fontBold,
                                ),
                              ),
                              btnOkOnPress: () {
                                widget.onCancelTask(widget.task.id ?? 0);
                              },
                              btnCancelOnPress: () {},
                              dialogType: DialogType.QUESTION,
                            ).show();
                          },
                          child: const Text(
                            'Hủy lịch',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.task.status != 0,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Tôi muốn xóa ảnh!',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoupleText({required String first, required String last}) {
    return RichText(
      text: TextSpan(
        text: first,
        style: const TextStyle(
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: last,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: fontBold,
            ),
          )
        ],
      ),
    );
  }

  _getStatus() {
    return Column(
      children: [
        Icon(
          widget.task.status == 1 ? Icons.check_circle : Icons.info,
          color: widget.task.status == 1 ? Colors.green : Colors.yellow,
        ),
        Text(
          widget.task.status == 1 ? 'Đã xong' : "Đang chờ",
        )
      ],
    );
  }

  void _showBottomSheetImage(ImageDB e) {
    showBottomSheet(
        context: context,
        builder: (_) {
          return Center(
            child: Image.network(
              "$localHost${e.link}",
              fit: BoxFit.cover,
              errorBuilder: (context, _, __) => Container(),
            ),
          );
        });
  }

  void _shareImage({required Task task}) {
    MUser user = locator<AuthenticationService>().user;
    TextEditingController captionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 65,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: borderRadiusCircle,
                    child: Image.network(
                      '${user.avatar}',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${user.name}',
                    style: const TextStyle(
                      fontFamily: fontBold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            TextField(
              maxLines: 3,
              maxLength: 250,
              controller: captionController,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: "Bạn có đang nghĩ gì...?",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                cacheExtent: 5000,
                itemCount: task.image!.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 8,
                    borderRadius: borderRadius12,
                    child: ClipRRect(
                      borderRadius: borderRadius12,
                      child: Image.network(
                        "$localHost/${task.image![index].link}",
                        errorBuilder: (context, _, __) => Container(),
                      ),
                    ),
                  ),
                ),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    var res = await locator<HistoryModel>()
                        .sharePost(task: task, caption: captionController.text);
                    if (res) {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.SUCCES,
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                              title: "Successful!")
                          .show();
                    } else {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              btnOkOnPress: () {},
                              title: "Error!")
                          .show();
                    }
                  },
                  child: const Text(
                    "Chia sẻ ngay",
                    style: TextStyle(
                      fontFamily: fontBold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
