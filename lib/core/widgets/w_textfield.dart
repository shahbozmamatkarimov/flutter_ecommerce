import 'package:ecommerceapp/core/widgets/w_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/styles.dart';
import '../resources/app_icons.dart';

class WTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController controller;
  final bool isObscure;
  final Widget? prefixIcon;
  final List<TextInputFormatter> formatters;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLength;
  final int? maxLines;
  final String? errorText;
  final String? hint;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final Widget? suffixIcon;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final bool readOnly;
  final double hintFontSize;
  final EdgeInsets contentPadding;
  final String? label;
  final bool autoFocus;
  final Color? borderColor;
  final double borderRadius;
  final Color? fillColor;
  final bool? enabled;

  const WTextField({
    Key? key,
    this.focusNode,
    required this.controller,
    this.isObscure = false,
    this.prefixIcon,
    this.formatters = const [],
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
    this.maxLines = 1,
    this.errorText,
    this.hint,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.suffixIcon,
    this.onSubmitted,
    this.onChanged,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.readOnly = false,
    this.hintFontSize = 14,
    this.label,
    this.autoFocus = false,
    this.borderColor,
    this.borderRadius = 4,
    this.fillColor = AppColors.inputColor,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<WTextField> createState() => _WTextFieldState();
}

class _WTextFieldState extends State<WTextField> {
  bool toggle = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.label != null) ...{
              WLabel(label: widget.label!),
            } else ...{
              const SizedBox(),
            },
            const SizedBox(width: 12),
            if (widget.errorText != null) ...{
              Expanded(
                child: Text(
                  widget.errorText!,
                  style: Styles.getTextStyle(
                    fontSize: 12,
                    color: AppColors.danger,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            },
          ],
        ),
        Container(
          height: widget.maxLines == 1 ? 45 : null,
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: TextField(
            maxLines: widget.maxLines,
            readOnly: widget.readOnly,
            textAlign: widget.textAlign,
            focusNode: widget.focusNode,
            controller: widget.controller,
            onSubmitted: widget.onSubmitted,
            style: widget.textStyle ?? Styles.getTextStyle(),
            obscureText: widget.isObscure && !toggle,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            autofocus: widget.autoFocus,
            enabled: widget.enabled,
            decoration: InputDecoration(
              errorText: widget.errorText != null ? "" : null,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isObscure
                  ? IconButton(
                      icon: toggle
                          ? SvgPicture.asset(
                              AppIcons.removedEye,
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.c_07, BlendMode.srcIn),
                            )
                          : SvgPicture.asset(
                              AppIcons.eye,
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.c_07, BlendMode.srcIn),
                            ),
                      onPressed: () {
                        setState(() {
                          toggle = !toggle;
                        });
                      },
                    )
                  : widget.suffixIcon,
              filled: true,
              fillColor: widget.fillColor,
              border: getBorder(color: widget.borderColor),
              enabledBorder: getBorder(color: widget.borderColor),
              focusedBorder: getBorder(color: widget.borderColor),
              errorBorder: getBorder(color: AppColors.danger),
              contentPadding: widget.contentPadding,
              counterText: "",
              hintText: widget.hint,
              hintStyle: widget.textStyle ??
                  Styles.getTextStyle(
                    color: AppColors.c_a1,
                    letterSpacing: 1,
                    fontSize: widget.hintFontSize,
                  ),
              errorStyle:
                  Styles.getTextStyle(fontSize: 8, color: AppColors.danger),
            ),
            textInputAction: widget.textInputAction,
            cursorColor: AppColors.black,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.formatters,
          ),
        ),
      ],
    );
  }

  getBorder({Color? color}) => OutlineInputBorder(
        borderSide: BorderSide(color: color ?? AppColors.c_f2, width: 1),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      );
}