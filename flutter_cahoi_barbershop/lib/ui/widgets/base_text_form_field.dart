import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';

class BaseTextFormField extends StatefulWidget {
  const BaseTextFormField({
    Key? key,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintText,
    this.maxLength,
    this.textInputAction,
    this.validator,
    this.textInputFormatter = '',
  }) : super(key: key);

  final String textInputFormatter;

  final TextEditingController? controller;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String>? onFieldSubmitted;

  final String? hintText;

  final int? maxLength;

  final TextInputAction? textInputAction;

  final FormFieldValidator<String>? validator;

  @override
  State<BaseTextFormField> createState() => _BaseTextFormFieldState();
}

class _BaseTextFormFieldState extends State<BaseTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 36,
      ),
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(widget.textInputFormatter),
        ),
      ],
      cursorColor: headerColor1,
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLength: widget.maxLength,
      autocorrect: true,
      cursorRadius: const Radius.circular(10),
      decoration: InputDecoration(
        hintText: widget.hintText,
        counterText: "",
        hintStyle: TextStyle(
          fontSize: 36,
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
    );
  }
}
