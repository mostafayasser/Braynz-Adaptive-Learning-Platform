import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    this.controller,
    this.keyboardType,
    this.obscure = false,
    this.prefixIcon,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final bool obscure;
  final Icon prefixIcon;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(35),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Color(0xFF3C096C),
        width: 1,
      ));
  final noBorder = InputBorder.none;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscure,
      decoration: InputDecoration(
        disabledBorder: noBorder,
        enabledBorder: noBorder,
        focusedBorder: border,
        errorBorder: noBorder,
        border: noBorder,
        focusColor: Color(0xFF3C096C),
        prefixIcon: prefixIcon,

        /* labelText: labelText,
                            labelStyle: TextStyle(fontSize: 14.0), */
        hintText: hintText,
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
