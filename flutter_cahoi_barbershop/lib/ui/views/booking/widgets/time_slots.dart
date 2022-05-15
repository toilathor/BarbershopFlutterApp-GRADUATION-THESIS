import 'package:date_format/date_format.dart' as format_date;
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/time_slot.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';

class TimeSlots extends StatefulWidget {
  const TimeSlots({
    Key? key,
    this.currentTimeSlot,
    required this.onPressed,
    this.timeSlots = const [],
  }) : super(key: key);

  final TimeSlot? currentTimeSlot;
  final Function(TimeSlot timeSlot) onPressed;
  final List<TimeSlot> timeSlots;

  @override
  _TimeSlotsState createState() => _TimeSlotsState();
}

class _TimeSlotsState extends State<TimeSlots> {
  Size size = Size.zero;

  String dateTemp = "2020-02-02 ";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return widget.timeSlots.isEmpty
        ? Center(
            child: Image.asset(
              'assets/not_item.png',
            ),
          )
        : GridView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.timeSlots.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 4,
            ),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: widget.timeSlots[index].isSelected ?? false
                  ? null
                  : () {
                      widget.onPressed(widget.timeSlots[index]);
                    },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 245),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: widget.currentTimeSlot == widget.timeSlots[index]
                      ? primaryColor
                      : null,
                  border: Border.all(
                    color: widget.timeSlots[index].isSelected ?? false
                        ? primaryColor.withOpacity(0.1)
                        : primaryColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    format_date.formatDate(
                      DateTime.parse(
                          "$dateTemp${widget.timeSlots[index].time}"),
                      [HH, ':', nn],
                    ).toString(),
                    style: TextStyle(
                      color: _getColorText(widget.timeSlots[index]),
                      fontFamily: fontBold,
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Color _getColorText(TimeSlot timeSlot) {
    if (timeSlot.isSelected ?? false) {
      return primaryColor.withOpacity(0.1);
    } else {
      return (widget.currentTimeSlot != timeSlot ? primaryColor : Colors.white);
    }
  }
}
