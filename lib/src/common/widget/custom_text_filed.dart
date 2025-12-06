import 'package:flutter/material.dart';

import '../extension/context_extension.dart';
import '../util/dimension.dart';

class CustomTextFiled extends StatefulWidget {
  const CustomTextFiled({
    super.key,
    this.fillColor,
    this.borderColor,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.height,
    this.borderWidth = 1.3,
    this.borderRadius = Dimension.rAll8,
    this.style,
    this.validator,
    this.contentPadding,
    this.enabledBorderColor,
    this.focusColor,
    this.hintStyle,
    this.hintText,
    this.labelStyle,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.cursorColor,
    this.action,
    this.keyboardType,
  });
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final Color? borderColor;
  final double? height;
  final double borderWidth;
  final BorderRadius borderRadius;
  final String? Function(String?)? validator;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final Color? focusColor;
  final Color? enabledBorderColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final Color? cursorColor;
  final Widget? action;
  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  ValueNotifier<bool> isFocused = ValueNotifier(false);
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: RepaintBoundary(
          child: SizedBox(
            height: widget.height,
            child: FocusScope(
              onFocusChange: (value) {
                isFocused.value = value;
              },
              child: ValueListenableBuilder(
                valueListenable: isFocused,
                builder: (context, value, child) => TextFormField(
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  onTap: widget.onTap,
                  onFieldSubmitted: widget.onSubmitted,
                  focusNode: widget.focusNode,
                  validator: widget.validator,
                  keyboardType: widget.keyboardType,
                  style: widget.style ?? context.textTheme.nunitoW400s16,
                  cursorColor: widget.cursorColor ?? context.color.primary,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: isFocused.value
                        ? (widget.focusColor ?? context.color.background)
                        : (widget.fillColor ?? context.color.cardBackground),
                    contentPadding: widget.contentPadding,
                    hoverColor: context.color.transparent,
                    suffixIcon: widget.suffixIcon,
                    prefixIcon: widget.prefixIcon,
                    hintText: widget.hintText,
                    hintStyle: widget.hintStyle ?? context.textTheme.nunitoW400s16,
                    labelText: widget.labelText,
                    labelStyle: widget.labelStyle ?? context.textTheme.nunitoW400s16,
                    border: _getBorder(context),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.borderColor ?? context.color.primary,
                        width: widget.borderWidth,
                      ),
                      borderRadius: widget.borderRadius,
                    ),
                    enabledBorder: _getBorder(context),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      if (widget.action != null) ...[widget.action!],
    ],
  );

  OutlineInputBorder _getBorder(BuildContext context) => OutlineInputBorder(
    borderSide: BorderSide(color: widget.enabledBorderColor ?? context.color.transparent, width: widget.borderWidth),
    borderRadius: widget.borderRadius,
  );
}
