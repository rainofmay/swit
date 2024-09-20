import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';

class CustomTextFormField extends StatelessWidget {
  final double? fieldWidth;
  final String? defaultText;
  final String? hintText;
  final bool isPasswordField;
  final bool? isEnabled; // 텍스트필드 활성화 여부
  final int? maxLines;
  final int? maxLength;
  final bool isReadOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final Widget? prefix;
  final Icon? prefixIcon;
  final Widget? suffixWidget;
  final Icon? suffixIcon;
  final Widget? counter;
  final String? labelText;
  final Color? prefixIconColor;
  final void Function(String)? onChanged;
  final String? errorText;
  final bool hasError;
  final bool autofocus;
  final GestureTapCallback? onTap;
  final Widget? titleIcon;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final InputBorder? inputBorder;
  const CustomTextFormField(
      {this.fieldWidth,
        this.defaultText,
        this.hintText,
        this.isPasswordField = false,
        this.isEnabled,
        this.maxLines,
        required this.isReadOnly,
        this.keyboardType,
        this.textInputAction,
        this.controller,
        this.validator,
        this.prefix,
        this.prefixIcon,
        this.suffixWidget,
        this.labelText,
        this.counter,
        this.suffixIcon,
        this.prefixIconColor,
        this.onChanged,
        this.errorText,
        this.hasError = false,
        this.maxLength,
        this.autofocus = false,
        this.onTap,
        this.titleIcon,
        this.hintStyle,
        this.inputBorder,
        this.textStyle,
        super.key,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fieldWidth,
      child: TextFormField(
        onTap: onTap,
        style: textStyle,
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
          border: inputBorder,
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: ColorBox.primaryColor),
          // ),
          // enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: ColorBox.grey.withOpacity(0.5)),
          // ),
          // errorBorder: hasError
          //     ? UnderlineInputBorder(
          //   borderSide: BorderSide(color: ColorBox.darkRed),
          // )
          //     : null,
          // focusedErrorBorder: hasError
          //     ? UnderlineInputBorder(
          //   borderSide: BorderSide(color: ColorBox.darkRed, width: 1),
          // )
          //     : null,
          errorText: hasError ? errorText : null,
          errorStyle: TextStyle(color: ColorBox.pink[600]),
          isDense: true,
          contentPadding: const EdgeInsets.all(8),
          prefixIconColor: prefixIconColor,
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffix: suffixWidget,
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintText: hintText,
          hintStyle: hintStyle ?? TextStyle(color: ColorBox.grey.withOpacity(0.5)),
          counter: counter,
          labelStyle: TextStyle(color: ColorBox.grey.withOpacity(0.5)),
        ),
        obscureText: isPasswordField,
      ),
    );
  }
}