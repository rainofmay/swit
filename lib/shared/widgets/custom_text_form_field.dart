import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';

class CustomTextFormField extends StatelessWidget {
  final double fieldWidth;
  final String? defaultText;
  final String? hintText;
  final bool isPasswordField;
  final bool? isEnabled; // 텍스트필드 활성화 여부
  final int? maxLines;
  final int? maxLength;
  final bool isReadOnly;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final Widget? prefix;
  final Icon? prefixIcon;
  final Widget? suffixWidget;
  final Icon? suffixIcon;
  final Widget? counter;
  final String? labelText;
  final Color? prefixIconColor;
  final Color? textColor;
  final void Function(String)? onChanged;
  final String? errorText;
  final bool hasError;
  final bool autofocus;
  final GestureTapCallback? onTap;
  final Widget? titleIcon;
  const CustomTextFormField(
      {required this.fieldWidth,
        this.defaultText,
        this.hintText,
        required this.isPasswordField,
        this.isEnabled,
        this.maxLines,
        required this.isReadOnly,
        required this.keyboardType,
        required this.textInputAction,
        this.controller,
        this.validator,
        this.prefix,
        this.prefixIcon,
        this.suffixWidget,
        this.labelText,
        this.counter,
        this.suffixIcon,
        this.prefixIconColor,
        this.textColor,
        this.onChanged,
        this.errorText,
        this.hasError = false,
        this.maxLength,
        this.autofocus = false,
        this.onTap,
        this.titleIcon,
        super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fieldWidth,
      child: TextFormField(
        onTap: onTap,
        style: TextStyle(color: textColor),
        initialValue: defaultText,
        maxLength: maxLength,
        validator: validator != null ? (value) => validator!(value) : null,
        onChanged: onChanged,
        controller: controller,
        autofocus: autofocus,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        enabled: isEnabled,
        readOnly: isReadOnly,
        maxLines: maxLines,
        cursorColor: ColorBox.primaryColor,
        decoration: InputDecoration(
          icon: titleIcon,
          counterText: "",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorBox.primaryColor),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorBox.grey.withOpacity(0.5)),
          ),
          errorText: hasError ? errorText : null,
          errorStyle: TextStyle(color: ColorBox.pink[600]),
          errorBorder: hasError
              ? UnderlineInputBorder(
            borderSide: BorderSide(color: ColorBox.darkRed),
          )
              : null,
          focusedErrorBorder: hasError
              ? UnderlineInputBorder(
            borderSide: BorderSide(color: ColorBox.darkRed, width: 1),
          )
              : null,
          isDense: true,
          contentPadding: const EdgeInsets.all(10),
          prefixIconColor: prefixIconColor,
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffix: suffixWidget,
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: ColorBox.grey.withOpacity(0.5)),
          counter: counter,
          labelStyle: TextStyle(color: ColorBox.grey.withOpacity(0.5)),
        ),
        obscureText: isPasswordField,
      ),
    );
  }
}