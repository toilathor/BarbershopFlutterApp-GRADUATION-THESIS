import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';

class CustomStringDropDown extends StatefulWidget {
  const CustomStringDropDown({
    Key? key,
    required this.values,
    required this.onChanged,
  }) : super(key: key);

  final List<String> values;
  final Function(String value) onChanged;

  @override
  State<CustomStringDropDown> createState() => _CustomStringDropDownState();
}

class _CustomStringDropDownState extends State<CustomStringDropDown> {
  late String currentValue;

  @override
  void initState() {
    currentValue = widget.values.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: borderRadius20,
        color: Colors.deepPurpleAccent.shade100,
      ),
      child: DropdownButton<String>(
        borderRadius: borderRadius20,
        underline: Container(),
        dropdownColor: Colors.deepPurpleAccent.shade200,
        style: const TextStyle(
          fontFamily: fontBold,
        ),
        items: widget.values
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: !e.contains(currentValue) ? Colors.white70 : null,
                    shadows: !e.contains(currentValue)
                        ? null
                        : [
                            const Shadow(
                              color: Colors.grey,
                              blurRadius: 100,
                              offset: Offset.zero,
                            ),
                          ],
                  ),
                ),
              ),
            )
            .toList(),
        // selectedItemBuilder: (_) => widget.values
        //     .map(
        //       (e) => DropdownMenuItem<String>(
        //         value: e,
        //         child: Text(
        //           e,
        //           style: const TextStyle(color: Colors.red),
        //         ),
        //       ),
        //     )
        //     .toList(),
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            currentValue = value ?? "None";
          });
          widget.onChanged(value ?? "None");
        },
        value: currentValue,
      ),
    );
  }
}
