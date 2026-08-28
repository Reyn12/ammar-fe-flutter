import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ammar_fe_flutter/helper/validator.dart';
import 'package:ammar_fe_flutter/resources/app_typography.dart';
import 'package:ammar_fe_flutter/resources/resources.dart';

class CustomTextField<T> extends StatefulWidget {
  final String name;
  final String? initialValue;
  final String? label;
  final Widget? labelWidget;
  final String? labelHelper;
  final Color? textColor;
  final String hint;
  final Color? hintColor;
  final TextInputType keyboardType;
  final TextInputAction action;
  final int minLine;
  final int? maxLength;
  final int? maxLine;
  final bool isRequired;
  final bool isPassword;
  final bool isObscure;
  final String obscureCharacter;
  final Widget? prefix;
  final String? prefixText;
  final Color? prefixTextColor;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final List<FormFieldValidator<String>>? validators;
  final T Function(String?)? valueTransformer;
  final bool? enabled;
  final bool? readOnly;
  final bool? showCursor;
  final bool? showFocus;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final double? labelFontSize;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmitted;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double radius;
  final InputBorder? disabledBorder;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final Widget? counter;
  final TextStyle? counterStyle;
  final EdgeInsets? contentPadding;
  final BoxConstraints? suffixIconConstraints;
  final Widget? labelSuffix;

  const CustomTextField({
    super.key,
    this.enabled = true,
    required this.name,
    this.initialValue,
    this.label,
    this.labelWidget,
    this.labelHelper,
    this.textColor,
    required this.hint,
    this.hintColor,
    this.keyboardType = TextInputType.text,
    this.action = TextInputAction.next,
    this.minLine = 1,
    this.maxLine,
    this.validator,
    this.validators,
    this.valueTransformer,
    this.isRequired = true,
    this.isPassword = false,
    this.isObscure = false,
    this.obscureCharacter = "*",
    this.prefix,
    this.prefixText,
    this.prefixTextColor,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.readOnly,
    this.onTap,
    this.showCursor,
    this.showFocus,
    this.textStyle,
    this.labelFontSize,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.fillColor,
    this.borderColor,
    this.maxLength,
    this.disabledBorder,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.counter,
    this.counterStyle,
    this.contentPadding,
    this.suffixIconConstraints,
    this.borderRadius,
    this.radius = 12,
    this.labelSuffix,
  });

  factory CustomTextField.dropdown({
    required String name,
    required String label,
    String? labelHelper,
    required String hint,
    Color? hintColor,
    String? initialValue,
    TextEditingController? controller,
    TextInputAction action = TextInputAction.next,
    T Function(String?)? valueTransformer,
    List<FormFieldValidator<String>>? validators,
    VoidCallback? onTap,
    bool isRequired = true,
    EdgeInsets? contentPadding,
    Color? iconColor,
    Color? fillColor,
    void Function(String?)? onChanged,
  }) => CustomTextField(
    name: name,
    label: label,
    labelHelper: labelHelper,
    hint: hint,
    hintColor: hintColor,
    action: TextInputAction.next,
    isRequired: isRequired,
    suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, color: iconColor),
    readOnly: true,
    initialValue: initialValue,
    controller: controller,
    showCursor: false,
    onTap: onTap,
    showFocus: false,
    validators: validators,
    valueTransformer: valueTransformer,
    onChanged: onChanged,
    fillColor: fillColor,
  );

  factory CustomTextField.password({
    required String name,
    String? label,
    String? labelHelper,
    required String hint,
    String? initialValue,
    String obscureCharacter = "*",
    TextInputAction action = TextInputAction.next,
    TextEditingController? controller,
    T Function(String?)? valueTransformer,
    List<FormFieldValidator<String>>? validators,
    void Function(String?)? onChanged,
  }) => CustomTextField(
    name: name,
    label: label,
    labelHelper: labelHelper,
    hint: hint,
    initialValue: initialValue,
    controller: controller,
    isPassword: true,
    isRequired: true,
    isObscure: true,
    obscureCharacter: obscureCharacter,
    keyboardType: TextInputType.visiblePassword,
    action: action,
    validators: validators,
    valueTransformer: valueTransformer,
    onChanged: onChanged,
  );

  factory CustomTextField.search({
    required String name,
    required String hint,
    String? initialValue,
    TextEditingController? controller,
    void Function(String?)? onChanged,
    void Function(String?)? onSubmitted,
    Widget? suffixIcon,
  }) => CustomTextField(
    name: name,
    hint: hint,
    initialValue: initialValue,
    controller: controller,
    isRequired: false,
    action: TextInputAction.search,
    fillColor: AppColors.neutral10,
    onChanged: onChanged,
    onSubmitted: onSubmitted,
    prefixIcon: const Icon(
      Icons.search,
      size: 20,
      color: AppColors.textColor50,
    ),
    suffixIcon: suffixIcon,
  );

  factory CustomTextField.inputMessage({
    required String name,
    String hint = 'Balas Komentar',
    String? initialValue,
    TextEditingController? controller,
    void Function(String?)? onChanged,
    void Function(String?)? onSubmitted,
    VoidCallback? onTapSend,
  }) {
    final borderRadius = BorderRadius.circular(12);

    return CustomTextField(
      name: name,
      hint: hint,
      hintColor: AppColors.neutral50,
      textColor: AppColors.neutral100,
      initialValue: initialValue,
      controller: controller,
      isRequired: false,
      action: TextInputAction.send,
      fillColor: AppColors.neutral10,
      radius: 12,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: AppColors.neutral50, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: AppColors.neutral50, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: AppColors.neutral100, width: 1),
      ),
      suffixIcon: GestureDetector(
        onTap: onTapSend,
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Icon(
            Icons.send,
            size: 24,
            color: AppColors.primary,
          ),
        ),
      ),
      suffixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 24),
    );
  }

  factory CustomTextField.multiline({
    required String name,
    String? label,
    String? labelHelper,
    required String hint,
    String? initialValue,
    TextInputAction action = TextInputAction.next,
    T Function(String?)? valueTransformer,
    List<FormFieldValidator<String>>? validators,
    void Function(String?)? onChanged,
    int minLine = 3,
    int maxLine = 5,
    int maxLength = 200,
    double? labelFontSize,
    bool isRequired = true,
    double radius = 8,
    TextStyle? textStyle,
    TextStyle? counterStyle,
    Widget? counter,
    EdgeInsets? contentPadding,
  }) {
    return CustomTextField(
      name: name,
      label: label,
      labelHelper: labelHelper,
      labelFontSize: labelFontSize,
      hint: hint,
      textStyle: textStyle,
      initialValue: initialValue,
      isRequired: isRequired,
      action: action,
      validators: validators,
      valueTransformer: valueTransformer,
      onChanged: onChanged,
      minLine: minLine,
      maxLine: maxLine,
      maxLength: maxLength,
      radius: radius,
      keyboardType: TextInputType.multiline,
      counterStyle: counterStyle,
      counter: counter,
      contentPadding:
          contentPadding ?? const EdgeInsets.fromLTRB(12, 12, 4, 12),
    );
  }

  @override
  State<CustomTextField<T>> createState() => _CustomTextFieldState<T>();
}

class _CustomTextFieldState<T> extends State<CustomTextField<T>> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      initialValue: widget.initialValue,
      name: widget.name,
      valueTransformer: widget.valueTransformer,
      validator:
          widget.validator ??
          Validator.list([
            if (widget.isRequired) Validator.required(),
            ...?widget.validators,
          ]),
      builder: (field) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null || widget.labelWidget != null) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.labelWidget != null
                      ? widget.labelWidget!
                      : RichText(
                          text: TextSpan(
                            text: widget.label ?? '',
                            style: AppTypography.bodyRegularL.copyWith(
                              color: AppColors.neutral100,
                              fontSize: widget.labelFontSize,
                            ),
                            children: [
                              if (widget.isRequired)
                                TextSpan(
                                  text: ' *',
                                  style: AppTypography.bodyRegularL.copyWith(
                                    color: AppColors.error,
                                    fontSize: widget.labelFontSize,
                                  ),
                                ),
                            ],
                          ),
                        ),
                  if (widget.labelHelper != null) ...[
                    const SizedBox(width: 4),
                    Text(
                      widget.labelHelper ?? '',
                      style: AppTypography.bodyRegularS.copyWith(
                        color: AppColors.textColor40,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  if (widget.labelSuffix != null) ...[
                    const Spacer(),
                    widget.labelSuffix!,
                  ],
                ],
              ),
              const SizedBox(height: 8),
            ],
            FormBuilderTextField(
              onTap: widget.onTap,
              initialValue: widget.initialValue,
              maxLength: widget.maxLength,
              name: '${widget.name}_field',
              controller: widget.controller,
              style:
                  widget.textStyle ??
                  AppTypography.bodyRegularL.copyWith(
                    color:
                        widget.textColor ??
                        ((widget.enabled == false)
                            ? AppColors.textColor50
                            : field.hasError
                            ? AppColors.error
                            : AppColors.neutral100),
                  ),
              readOnly: (widget.enabled == false)
                  ? true
                  : (widget.readOnly ?? false),
              enabled: widget.enabled ?? true,
              showCursor: (widget.enabled == false)
                  ? false
                  : (widget.showCursor ?? true),
              keyboardType: widget.keyboardType,
              textInputAction: widget.action,
              obscureText: _obscure,
              obscuringCharacter: widget.obscureCharacter,
              onChanged: (value) {
                field.didChange(value);
                widget.onChanged?.call(value);
              },
              onSubmitted: (value) {
                field.didChange(value);
                widget.onSubmitted?.call(value);
              },
              maxLines: widget.maxLine ?? widget.minLine,
              minLines: widget.minLine,
              decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 0, height: 0),
                hintText: widget.hint,
                hintStyle:
                    widget.textStyle?.copyWith(
                      color: widget.hintColor ?? AppColors.neutral80,
                    ) ??
                    AppTypography.bodyRegularL.copyWith(
                      color: widget.hintColor ?? AppColors.neutral80,
                    ),
                counter: widget.counter,
                counterStyle:
                    widget.counterStyle ??
                    AppTypography.bodyRegularM.copyWith(
                      color: AppColors.textColor90,
                    ),
                contentPadding: widget.contentPadding,
                suffixIconConstraints: widget.suffixIconConstraints,
                filled: widget.fillColor != null,
                fillColor:
                    widget.fillColor ??
                    ((widget.enabled == false)
                        ? AppColors.neutral30
                        : field.hasError
                        ? AppColors.errorSurface
                        : widget.fillColor),
                prefix: widget.prefix,
                prefixIcon:
                    widget.prefixIcon ??
                    (widget.prefixText != null
                        ? Container(
                            width: 49,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: AppColors.neutral30,
                              border: Border.all(
                                color: AppColors.neutral50,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.prefixText ?? '',
                                style:
                                    widget.textStyle ??
                                    AppTypography.bodyRegularL.copyWith(
                                      color:
                                          widget.prefixTextColor ??
                                          AppColors.neutral100,
                                    ),
                              ),
                            ),
                          )
                        : null),
                suffix: widget.suffix,
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscure = !_obscure;
                          });
                        },
                        child: Icon(
                          _obscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                          color: AppColors.textColor70,
                        ),
                      )
                    : widget.suffixIcon,
                disabledBorder:
                    widget.disabledBorder ??
                    OutlineInputBorder(
                      borderRadius:
                          widget.borderRadius ??
                          BorderRadius.circular(widget.radius),
                      borderSide: BorderSide(
                        color: widget.borderColor ?? AppColors.neutral50,
                        width: 1,
                      ),
                    ),
                border:
                    widget.border ??
                    OutlineInputBorder(
                      borderRadius:
                          widget.borderRadius ??
                          BorderRadius.circular(widget.radius),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                enabledBorder:
                    widget.enabledBorder ??
                    OutlineInputBorder(
                      borderRadius:
                          widget.borderRadius ??
                          BorderRadius.circular(widget.radius),
                      borderSide: const BorderSide(
                        color: AppColors.neutral50,
                        width: 1,
                      ),
                    ),
                errorBorder:
                    widget.errorBorder ??
                    OutlineInputBorder(
                      borderRadius:
                          widget.borderRadius ??
                          BorderRadius.circular(widget.radius),
                      borderSide: const BorderSide(
                        color: AppColors.error,
                        width: 1,
                      ),
                    ),
                focusedErrorBorder:
                    widget.focusedErrorBorder ??
                    OutlineInputBorder(
                      borderRadius:
                          widget.borderRadius ??
                          BorderRadius.circular(widget.radius),
                      borderSide: const BorderSide(
                        color: AppColors.error,
                        width: 1,
                      ),
                    ),
                focusedBorder:
                    widget.focusedBorder ??
                    OutlineInputBorder(
                      borderRadius:
                          widget.borderRadius ??
                          BorderRadius.circular(widget.radius),
                      borderSide: BorderSide(
                        color: widget.showFocus == false
                            ? AppColors.neutral50
                            : AppColors.primary,
                        width: 1,
                      ),
                    ),
              ),
            ),
            Visibility(
              visible: field.hasError,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const SizedBox(width: 4),
                      Text(
                        field.errorText.toString(),
                        style: AppTypography.bodyRegularM.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
