import 'package:flutter/material.dart';
// this primary textfilled where we use this in all over the app
class PrimaryTextFilled extends StatelessWidget {
  const PrimaryTextFilled({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.keyboardType,
    this.maxLines,
    this.autofocus,
    this.prefixText,
    this.maxLength,
    this.readOnly,
    this.focusNode,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final bool? autofocus;
  final bool? readOnly;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      readOnly: readOnly ?? false,
      autofocus: autofocus ?? false,
      controller: controller,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      maxLines: maxLines ?? null,
      maxLength: maxLength,
      decoration: InputDecoration(
          prefixText: prefixText,
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          // border: buildOutlineInputBorder(),
          errorBorder: buildOutlineInputBorder(),
          focusedErrorBorder: buildOutlineInputBorder()),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal.shade500),
    borderRadius: BorderRadius.circular(15),
  );
}
