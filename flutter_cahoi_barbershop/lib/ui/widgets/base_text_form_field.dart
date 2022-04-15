import 'package:flutter/material.dart';

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
  }) : super(key: key);

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
      cursorColor: Colors.black,
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLength: widget.maxLength,
      autocorrect: true,
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
