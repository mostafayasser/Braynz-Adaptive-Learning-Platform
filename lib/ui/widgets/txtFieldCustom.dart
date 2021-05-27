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
    this.hasBorder = true,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool hasBorder;
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Color(0xFF707070),
        width: 1,
      ));
  final noBorder = InputBorder.none;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        disabledBorder: hasBorder ? border : noBorder,
        enabledBorder: hasBorder ? border : noBorder,
        focusedBorder: hasBorder ? border : noBorder,
        errorBorder: hasBorder ? border : noBorder,
        border: hasBorder ? border : noBorder,
        /* labelText: labelText,
                            labelStyle: TextStyle(fontSize: 14.0), */
        hintText: hintText,
        hintStyle: TextStyle(
            fontFamily: "Montserrat-Medium",
            color: Color(0xFF707070),
            fontSize: 18.0,
            fontWeight: FontWeight.w400),
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
