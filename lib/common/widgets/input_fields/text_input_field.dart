import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/widgets/buttons/icon_button.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/constants/sizes.dart';

class IdocItTextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText, hintText, errorText, helperText;
  final Widget? prefixIcon, suffixIcon;
  final bool isEnabled, isAutofocused, isValidField, isOnError, isProcessing;
  final bool isOptionalField, isProtectedField;
  final bool withClearButton;
  final bool allowSpaces;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? formatters;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode autovalidateMode;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int maxLength, maxLines;
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final Function(bool)? onFocusChange;
  final VoidCallback? onClear;

  const IdocItTextInputField({
    Key? key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.isEnabled = true,
    this.isAutofocused = false,
    this.isValidField = false,
    this.isOnError = false,
    this.isProcessing = false,
    this.isOptionalField = false,
    this.isProtectedField = false,
    this.withClearButton = true,
    this.allowSpaces = true,
    this.focusNode,
    this.keyboardType = TextInputType.visiblePassword,
    this.inputAction = TextInputAction.done,
    this.autofillHints,
    this.formatters,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.maxLengthEnforcement,
    this.maxLength = 64,
    this.maxLines = 1,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.onFocusChange,
    this.onClear,
  }) : assert(maxLength >= 0),
       assert(maxLines >= 1),
       super(key: key);

  @override
  State<IdocItTextInputField> createState() => _IdocItTextInputFieldState();
}

class _IdocItTextInputFieldState extends State<IdocItTextInputField> with WidgetsBindingObserver {
  final _textFieldKey = GlobalKey();
  final _prefixIconKey = GlobalKey();
  final _suffixIconKey = GlobalKey();

  double _textFieldSize = 0.0;
  double _prefixIconSize = 0.0;
  double _suffixIconSize = 0.0;

  bool _isFocused = false;
  bool _isProtected = false;
  bool _isFieldEmpty = true;
  bool _isInit = false;

  static const _defaultInfoSectionDuration = Duration(milliseconds: 300);
  static const _defaultLabelDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleWidgetSize();
      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        setState(() {
          _isInit = true;
        });
      });
    });

    _isProtected = widget.isProtectedField;
    _hintTextHandler();
    widget.controller.addListener(_hintTextHandler);
  }

  @override
  void didUpdateWidget(covariant IdocItTextInputField oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleWidgetSize();
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.controller.removeListener(_hintTextHandler);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      _handleWidgetSize();
    });
  }

  void _handleWidgetSize() {
    if (!mounted) return;
    if (widget.labelText == null && widget.hintText == null) {
      return;
    }

    final textFieldContext = _textFieldKey.currentContext;
    final prefixContext = _prefixIconKey.currentContext;
    final suffixContext = _suffixIconKey.currentContext;

    final textFieldRenderSize = textFieldContext?.size?.width ?? 0.0;
    final prefixRenderSize = prefixContext?.size?.width ?? 0.0;
    final suffixRenderSize = suffixContext?.size?.width ?? 0.0;

    if (_textFieldSize != textFieldRenderSize && textFieldRenderSize > 0.0) {
      setState(() {
        _textFieldSize = textFieldRenderSize;
      });
    }

    if (_prefixIconSize != prefixRenderSize && (prefixRenderSize > 0.0 || widget.prefixIcon == null)) {
      setState(() {
        _prefixIconSize = prefixRenderSize;
      });
    }

    if (_suffixIconSize != suffixRenderSize && (suffixRenderSize > 0.0 || widget.suffixIcon == null)) {
      setState(() {
        _suffixIconSize = suffixRenderSize;
      });
    }
  }

  void _hintTextHandler() {
    final isEmpty = widget.controller.value.text.isEmpty;
    if (_isFieldEmpty != isEmpty) {
      setState(() {
        _isFieldEmpty = isEmpty;
      });
    }
  }

  void _onToggleObscureHandler() {
    setState(() {
      _isProtected = !_isProtected;
    });
  }

  void _onChangedHandler(String value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  void _onClearFieldHandler() {
    widget.controller.clear();
    if (widget.onClear != null) {
      widget.onClear!();
    }
  }

  void _onFocusChangeHandler(bool value) async {
    setState(() {
      _isFocused = value;
    });

    if (widget.onFocusChange != null) {
      widget.onFocusChange!(value);
    }
  }

  TextStyle _getLabelTextStyle() {
    final isLabelShown = _isFocused || widget.controller.text.isNotEmpty;
    final defaultTextStyle = Theme.of(
      context,
    ).inputDecorationTheme.hintStyle!.copyWith(fontSize: 11.0, fontWeight: FontWeight.w400, height: 1.0);

    /// On error
    if (isLabelShown && widget.errorText != null) {
      return defaultTextStyle.copyWith(color: Theme.of(context).inputDecorationTheme.errorStyle?.color);
    }

    /// On focused
    if (isLabelShown && _isFocused) {
      return defaultTextStyle.copyWith(color: ColorConstants.green500);
    }

    /// On disabled
    if (isLabelShown) {
      return defaultTextStyle.copyWith(color: ColorConstants.black200);
    }

    /// On unfocused
    return Theme.of(context).inputDecorationTheme.hintStyle!;
  }

  Color? _getServiceIconColor({bool isProtectedIcon = false}) {
    /// On disabled
    if (!widget.isEnabled && !isProtectedIcon) {
      return ColorConstants.black200;
    }

    /// On disabled protected
    if (_isProtected && isProtectedIcon) {
      return Theme.of(context).inputDecorationTheme.hintStyle?.color;
    }

    /// On error
    if (widget.errorText != null) {
      return Theme.of(context).inputDecorationTheme.errorStyle?.color;
    }

    /// On focused
    return ColorConstants.green500;
  }

  Widget _buildErrorWidget() {
    return AnimatedContainer(
      alignment: Alignment.centerLeft,
      duration: _defaultInfoSectionDuration,
      padding: EdgeInsets.symmetric(vertical: _isFocused ? 0.0 : 10.0, horizontal: _isFocused ? 0.0 : 12.0),
      decoration: BoxDecoration(
        color: _isFocused ? null : ColorConstants.red500.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: AnimatedDefaultTextStyle(
        duration: _defaultInfoSectionDuration,
        style: Theme.of(context).inputDecorationTheme.errorStyle!.copyWith(
          fontSize: _isFocused ? null : 14.0,
          height: _isFocused ? null : 16.0 / 14.0,
        ),
        child: IdocItText(
          isVerticalCentered: false,
          text: widget.errorText!,
          maxLines: Theme.of(context).inputDecorationTheme.errorMaxLines,
        ),
      ),
    );
  }

  Widget _buildHelperWidget() {
    return IdocItText(
      text: widget.helperText!,
      style: Theme.of(context).inputDecorationTheme.helperStyle,
      maxLines: Theme.of(context).inputDecorationTheme.helperMaxLines,
    );
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).inputDecorationTheme.labelStyle;
    final suffixIconBottomPadding = (labelStyle?.fontSize ?? 0.0) * (labelStyle?.height ?? 0.0);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Focus(
              onFocusChange: _onFocusChangeHandler,
              child: TextFormField(
                key: _textFieldKey,
                controller: widget.controller,
                enabled: widget.isEnabled,
                obscureText: _isProtected,
                autofocus: widget.isAutofocused,
                focusNode: widget.focusNode,
                keyboardType: widget.keyboardType,
                textInputAction: widget.inputAction,
                style: Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(
                  decorationThickness: 0.0,
                  color: widget.isEnabled
                      ? null
                      : Theme.of(context).inputDecorationTheme.disabledBorder?.borderSide.color,
                ),
                decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon != null
                      ? SizedBox(key: _prefixIconKey, child: widget.prefixIcon)
                      : null,
                  suffixIcon: Padding(
                    key: _suffixIconKey,
                    padding: EdgeInsets.only(bottom: (widget.maxLines - 1) * suffixIconBottomPadding, right: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (widget.isProtectedField)
                          IdocItImageButton(
                            image: SvgPicture.asset(
                              ImageConstants.icTextFieldEye,
                              color: _getServiceIconColor(isProtectedIcon: true),
                            ),
                            callback: _onToggleObscureHandler,
                          ),
                        if (widget.isValidField) ...[
                          const SizedBox(width: 4.0),
                          IdocItImageButton(
                            image: SvgPicture.asset(ImageConstants.icTextFieldOk, color: _getServiceIconColor()),
                            callback: () {},
                          ),
                        ],
                        if (widget.isProcessing) ...[
                          const SizedBox(width: 4.0),
                          IdocItLoadingIndicator(color: _getServiceIconColor()),
                        ],
                        if (widget.suffixIcon != null) widget.suffixIcon!,
                        if (widget.withClearButton && !_isFieldEmpty && _isFocused) ...[
                          const SizedBox(width: 4.0),
                          IdocItImageButton(
                            image: SvgPicture.asset(ImageConstants.icTextFieldClose),
                            callback: _onClearFieldHandler,
                          ),
                        ],
                      ],
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(minHeight: SizeConstants.defaultIconSize),
                  suffixIconConstraints: const BoxConstraints(minHeight: SizeConstants.defaultIconSize),
                  enabledBorder: widget.errorText != null || widget.isOnError
                      ? Theme.of(context).inputDecorationTheme.errorBorder
                      : null,
                  focusedBorder: widget.errorText != null || widget.isOnError
                      ? Theme.of(context).inputDecorationTheme.errorBorder
                      : null,
                  fillColor: _isFocused ? const Color(0xFF04100D) : null,
                ),
                inputFormatters: [
                  ...widget.formatters ?? [],
                  if (!widget.allowSpaces) FilteringTextInputFormatter.deny(RegExp(r'[\r\n\t\f\v ]')),
                  LengthLimitingTextInputFormatter(widget.maxLength),
                ],
                cursorColor: widget.errorText == null
                    ? Theme.of(context).inputDecorationTheme.enabledBorder?.borderSide.color
                    : Theme.of(context).inputDecorationTheme.errorBorder?.borderSide.color,
                cursorWidth: 1.0,
                validator: widget.validator,
                autovalidateMode: widget.autovalidateMode,
                maxLengthEnforcement: widget.maxLengthEnforcement,
                maxLines: widget.maxLines,
                autofillHints: widget.autofillHints,
                onChanged: _onChangedHandler,
                onEditingComplete: widget.onEditingComplete,
                onTap: widget.onTap,
              ),
            ),
            if (widget.errorText != null) ...[const SizedBox(height: 6.0), _buildErrorWidget()],
            if (widget.helperText != null && widget.errorText == null) ...[
              const SizedBox(height: 6.0),
              _buildHelperWidget(),
            ],
          ],
        ),
        if (widget.hintText != null && widget.labelText == null)
          _InputFieldHint(
            hintText: widget.hintText!,
            isOptionalField: widget.isOptionalField,
            isFieldEmpty: _isFieldEmpty,
            textFieldSize: _textFieldSize,
            prefixIconSize: _prefixIconSize,
            suffixIconSize: _suffixIconSize,
            duration: _defaultLabelDuration,
            onTap: () {
              widget.focusNode?.requestFocus();
            },
          ),
        if (widget.labelText != null) ...[
          _InputFieldLabel(
            labelText: widget.labelText!,
            isLabelShownOnTop: _isFocused || !_isFieldEmpty,
            isOptionalField: widget.isOptionalField,
            isInit: _isInit,
            textFieldSize: _textFieldSize,
            prefixIconSize: _prefixIconSize,
            suffixIconSize: _suffixIconSize,
            duration: _defaultLabelDuration,
            textStyle: _getLabelTextStyle(),
            onTap: () {
              widget.focusNode?.requestFocus();
            },
            isOnTopPosition: true,
          ),
          _InputFieldLabel(
            labelText: widget.labelText!,
            isLabelShownOnTop: _isFocused || !_isFieldEmpty,
            isOptionalField: widget.isOptionalField,
            isInit: _isInit,
            textFieldSize: _textFieldSize,
            prefixIconSize: _prefixIconSize,
            suffixIconSize: _suffixIconSize,
            duration: _defaultLabelDuration,
            textStyle: _getLabelTextStyle(),
            onTap: () {
              widget.focusNode?.requestFocus();
            },
            isOnTopPosition: false,
          ),
        ],
      ],
    );
  }
}

class _InputFieldLabel extends StatefulWidget {
  final String labelText;
  final bool isLabelShownOnTop, isOptionalField, isInit;
  final double textFieldSize, prefixIconSize, suffixIconSize;
  final Duration duration;
  final TextStyle textStyle;
  final VoidCallback onTap;
  final bool isOnTopPosition;

  const _InputFieldLabel({
    Key? key,
    required this.labelText,
    required this.isLabelShownOnTop,
    required this.isOptionalField,
    required this.isInit,
    required this.textFieldSize,
    required this.prefixIconSize,
    required this.suffixIconSize,
    required this.duration,
    required this.textStyle,
    required this.onTap,
    required this.isOnTopPosition,
  }) : super(key: key);

  @override
  State<_InputFieldLabel> createState() => _InputFieldLabelState();
}

class _InputFieldLabelState extends State<_InputFieldLabel> {
  double _getLabelCollapsedTextSize() {
    final labelCollapsedPainter = TextPainter(
      text: TextSpan(
        text: widget.labelText + (widget.isOptionalField ? '*' : ''),
        style: Theme.of(
          context,
        ).inputDecorationTheme.hintStyle?.copyWith(fontSize: 11.0, fontWeight: FontWeight.w400, height: 1.0),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0.0, maxWidth: double.maxFinite);

    return labelCollapsedPainter.size.width;
  }

  double _getLabelExpandedTextSize() {
    final labelExpandedPainter = TextPainter(
      text: TextSpan(
        text: widget.labelText + (widget.isOptionalField ? '*' : ''),
        style: Theme.of(context).inputDecorationTheme.hintStyle,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0.0, maxWidth: double.maxFinite);

    return labelExpandedPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    final defaultBorderSize = Theme.of(context).inputDecorationTheme.border?.borderSide.width ?? 1.0;
    final defaultTopPosition = SizeConstants.defaultPadding - defaultBorderSize;
    final defaultLeftPosition = widget.prefixIconSize > 0.0 ? widget.prefixIconSize : 16.0;
    final defaultRightPosition = widget.suffixIconSize > 0.0 ? widget.suffixIconSize + 8.0 : 16.0;
    final maxLabelWidth = widget.textFieldSize - defaultLeftPosition - defaultRightPosition;

    if (widget.isOnTopPosition) {
      return Positioned(
        top: 0.0,
        left: 12.0,
        width: _getLabelCollapsedTextSize() + 8.0 > 0 ? _getLabelCollapsedTextSize() + 8.0 : null,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedOpacity(
            duration: widget.isInit ? widget.duration : Duration.zero,
            opacity: widget.isLabelShownOnTop ? 1.0 : 0.0,
            child: Container(
              height: 10.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4.0),
                  bottomRight: Radius.circular(4.0),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
        ),
      );
    }

    final currentLabelWidth = widget.isLabelShownOnTop
        ? _getLabelCollapsedTextSize() + 2.0
        : _getLabelExpandedTextSize() + 2.0;
    final labelWidth = currentLabelWidth > maxLabelWidth ? maxLabelWidth : currentLabelWidth;

    return AnimatedPositioned(
      duration: widget.isInit ? widget.duration : Duration.zero,
      top: widget.isLabelShownOnTop ? -3.0 : defaultTopPosition,
      left: widget.isLabelShownOnTop ? 16.0 : defaultLeftPosition,
      width: labelWidth > 0 ? labelWidth : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: widget.isInit ? widget.duration : Duration.zero,
          style: widget.textStyle,
          child: IdocItRichText(
            span: TextSpan(
              text: widget.labelText,
              children: [
                if (widget.isOptionalField)
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      height: 1.0,
                      color: widget.isLabelShownOnTop ? ColorConstants.red500 : ColorConstants.red500.withOpacity(0.5),
                    ),
                  ),
              ],
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}

class _InputFieldHint extends StatefulWidget {
  final String hintText;
  final bool isOptionalField, isFieldEmpty;
  final double textFieldSize, prefixIconSize, suffixIconSize;
  final Duration duration;
  final VoidCallback onTap;

  const _InputFieldHint({
    Key? key,
    required this.hintText,
    required this.isOptionalField,
    required this.isFieldEmpty,
    required this.textFieldSize,
    required this.prefixIconSize,
    required this.suffixIconSize,
    required this.duration,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_InputFieldHint> createState() => _InputFieldHintState();
}

class _InputFieldHintState extends State<_InputFieldHint> {
  double _getHintTextSize() {
    final labelCollapsedPainter = TextPainter(
      text: TextSpan(
        text: widget.hintText + (widget.isOptionalField ? '*' : ''),
        style: Theme.of(context).inputDecorationTheme.hintStyle,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0.0, maxWidth: double.maxFinite);

    return labelCollapsedPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    final defaultLeftPosition = widget.prefixIconSize > 0.0 ? widget.prefixIconSize : 16.0;
    final defaultRightPosition = widget.suffixIconSize > 0.0 ? widget.suffixIconSize + 8.0 : 16.0;

    final maxHintWidth = widget.textFieldSize - defaultLeftPosition - defaultRightPosition;
    final hintWidth = 80.0; // _getHintTextSize() > maxHintWidth ? maxHintWidth : _getHintTextSize();

    return Positioned(
      top: SizeConstants.defaultPadding,
      left: defaultLeftPosition,
      width: hintWidth > 0 ? hintWidth : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
          duration: widget.duration,
          opacity: widget.isFieldEmpty ? 1.0 : 0.0,
          child: IdocItRichText(
            span: TextSpan(
              text: widget.hintText,
              children: [
                if (widget.isOptionalField)
                  TextSpan(
                    text: '*',
                    style: TextStyle(height: 1.0, color: ColorConstants.red500.withOpacity(0.5)),
                  ),
              ],
              style: Theme.of(context).inputDecorationTheme.hintStyle,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
