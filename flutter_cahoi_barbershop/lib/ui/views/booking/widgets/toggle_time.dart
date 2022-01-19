import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ToggleTime extends StatefulWidget {
  final DateTime timeStart;
  final DateTime timeEnd;
  final int duration;
  final int currentIndex;
  final Function(DateTime time, int index) onPressed;

  const ToggleTime({
    Key? key,
    required this.timeStart,
    required this.timeEnd,
    required this.duration,
    this.currentIndex = 0,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ToggleTimeState createState() => _ToggleTimeState();
}

class _ToggleTimeState extends State<ToggleTime> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView(
      children: _buildItemToggleTime(),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      gridDelegate: const SliverMasonryGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
    );
  }

  DateTime _getIndexTime(int index) {
    return widget.timeStart.add(
      Duration(minutes: index * widget.duration),
    );
  }

  int _getItemCount() {
    int itemCount = widget.timeEnd.difference(widget.timeStart).inMinutes ~/
        widget.duration;
    if (_getIndexTime(itemCount).compareTo(widget.timeEnd) <= 0) {
      itemCount += 1;
    }
    return itemCount;
  }

  List<Widget> _buildItemToggleTime() {
    List<Widget> items = [];

    for (int i = 0; i < _getItemCount(); i++) {
      if (i != widget.currentIndex) {
        items.add(
          OutlinedButton(
            onPressed: () => widget.onPressed(_getIndexTime(i), i),
            child: Text(
                "${_getIndexTime(i).hour}:${_getIndexTime(i).minute == 0 ? "00" : _getIndexTime(i).minute}"),
          ),
        );
      } else if (i == widget.currentIndex) {
        items.add(
          ElevatedButton(
            onPressed: () {},
            child: Text(
                "${_getIndexTime(i).hour}:${_getIndexTime(i).minute == 0 ? "00" : _getIndexTime(i).minute}"),
          ),
        );
      } else {
        items.add(
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey;
                  }
                  return null; // Use the component's default.
                },
              ),
            ),
            onPressed: null,
            child: Text(
                "${_getIndexTime(i).hour}:${_getIndexTime(i).minute == 0 ? "00" : _getIndexTime(i).minute}"),
          ),
        );
      }
    }
    return items;
  }
}
