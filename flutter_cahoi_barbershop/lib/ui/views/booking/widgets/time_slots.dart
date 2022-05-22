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
    required this.selectedDate,
  }) : super(key: key);

  final TimeSlot? currentTimeSlot;
  final Function(TimeSlot timeSlot) onPressed;
  final List<TimeSlot> timeSlots;
  final DateTime selectedDate;

  @override
  _TimeSlotsState createState() => _TimeSlotsState();
}

class _TimeSlotsState extends State<TimeSlots> {
  Size size = Size.zero;

  String dateTemp = "2020-02-02";

  @override
  void initState() {
    final day = widget.selectedDate.day.toString().padLeft(2, "0");
    final month = widget.selectedDate.month.toString().padLeft(2, "0");
    final year = widget.selectedDate.year;

    dateTemp = "$year-$month-$day";

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
              onTap: canSelect(widget.timeSlots[index])
                  ? () {
                      widget.onPressed(widget.timeSlots[index]);
                    }
                  : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 245),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: widget.currentTimeSlot == widget.timeSlots[index]
                      ? primaryColor
                      : null,
                  border: Border.all(
                    color: !canSelect(widget.timeSlots[index])
                        ? primaryColor.withOpacity(0.1)
                        : primaryColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    format_date.formatDate(
                      DateTime.parse(
                          "$dateTemp ${widget.timeSlots[index].time}"),
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
    if (!canSelect(timeSlot)) {
      return primaryColor.withOpacity(0.1);
    } else {
      return (widget.currentTimeSlot != timeSlot ? primaryColor : Colors.white);
    }
  }

  bool canSelect(TimeSlot timeSlot) {
    DateTime dateTime = DateTime.parse("$dateTemp ${timeSlot.time}");

    // print();
    if (format_date
            .formatDate(widget.selectedDate, fDate)
            .compareTo(format_date.formatDate(DateTime.now(), fDate)) ==
        0) {
      if (dateTime.isAfter(DateTime.now()) && !(timeSlot.isSelected ?? false)) {
        return true;
      } else {
        return false;
      }
    } else {
      if (!(timeSlot.isSelected ?? false)) {
        return true;
      } else {
        return false;
      }
    }
  }
}
