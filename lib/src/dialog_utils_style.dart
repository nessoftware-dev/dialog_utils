import 'package:flutter/material.dart';

/// Theme values used by [DialogUtils].
///
/// Add an instance to [ThemeData.extensions] to configure dialogs throughout
/// an application. Values not set here fall back to the active Material theme.
class DialogUtilsStyle extends ThemeExtension<DialogUtilsStyle> {
  /// Creates the dialog theme extension.
  const DialogUtilsStyle({
    this.titleTextStyle,
    this.contentTextStyle,
    this.buttonTextStyle,
    this.defaultButtonBackgroundColor = Colors.white,
    this.defaultButtonForegroundColor,
    this.buttonBorderColor,
    this.primaryButtonBackgroundColor,
    this.primaryButtonForegroundColor,
    this.errorIconColor = Colors.red,
    this.successIconColor = Colors.green,
    this.infoIconColor = Colors.blue,
    this.iconSize = 40,
    this.barrierOpacity = 0.7,
    this.dialogRadius = 5,
    this.waitingDialogRadius = 15,
    this.buttonMinimumSize = const Size(100, 40),
  });

  /// Text style used for dialog titles.
  final TextStyle? titleTextStyle;

  /// Text style used for dialog content.
  final TextStyle? contentTextStyle;

  /// Text style used for dialog buttons.
  final TextStyle? buttonTextStyle;

  /// Background color of secondary buttons.
  final Color defaultButtonBackgroundColor;

  /// Optional foreground color of secondary buttons.
  final Color? defaultButtonForegroundColor;

  /// Optional border color of secondary buttons.
  final Color? buttonBorderColor;

  /// Optional background color of primary buttons.
  final Color? primaryButtonBackgroundColor;

  /// Optional foreground color of primary buttons.
  final Color? primaryButtonForegroundColor;

  /// Default error icon color.
  final Color errorIconColor;

  /// Default success icon color.
  final Color successIconColor;

  /// Default information icon color.
  final Color infoIconColor;

  /// Default size passed to the built-in icons.
  final double iconSize;

  /// Opacity of the modal barrier.
  final double barrierOpacity;

  /// Corner radius of standard dialogs.
  final double dialogRadius;

  /// Corner radius of waiting dialogs.
  final double waitingDialogRadius;

  /// Minimum size of dialog buttons.
  final Size buttonMinimumSize;

  /// Returns a copy with the supplied values replaced.
  /// Interpolates this style with another style during theme transitions.
  @override
  DialogUtilsStyle copyWith({
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
    TextStyle? buttonTextStyle,
    Color? defaultButtonBackgroundColor,
    Color? defaultButtonForegroundColor,
    Color? buttonBorderColor,
    Color? primaryButtonBackgroundColor,
    Color? primaryButtonForegroundColor,
    Color? errorIconColor,
    Color? successIconColor,
    Color? infoIconColor,
    double? iconSize,
    double? barrierOpacity,
    double? dialogRadius,
    double? waitingDialogRadius,
    Size? buttonMinimumSize,
  }) {
    return DialogUtilsStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      defaultButtonBackgroundColor:
          defaultButtonBackgroundColor ?? this.defaultButtonBackgroundColor,
      defaultButtonForegroundColor:
          defaultButtonForegroundColor ?? this.defaultButtonForegroundColor,
      buttonBorderColor: buttonBorderColor ?? this.buttonBorderColor,
      primaryButtonBackgroundColor:
          primaryButtonBackgroundColor ?? this.primaryButtonBackgroundColor,
      primaryButtonForegroundColor:
          primaryButtonForegroundColor ?? this.primaryButtonForegroundColor,
      errorIconColor: errorIconColor ?? this.errorIconColor,
      successIconColor: successIconColor ?? this.successIconColor,
      infoIconColor: infoIconColor ?? this.infoIconColor,
      iconSize: iconSize ?? this.iconSize,
      barrierOpacity: barrierOpacity ?? this.barrierOpacity,
      dialogRadius: dialogRadius ?? this.dialogRadius,
      waitingDialogRadius: waitingDialogRadius ?? this.waitingDialogRadius,
      buttonMinimumSize: buttonMinimumSize ?? this.buttonMinimumSize,
    );
  }

  @override
  DialogUtilsStyle lerp(covariant DialogUtilsStyle? other, double t) {
    if (other == null) {
      return this;
    }
    return DialogUtilsStyle(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t),
      contentTextStyle: TextStyle.lerp(
        contentTextStyle,
        other.contentTextStyle,
        t,
      ),
      buttonTextStyle: TextStyle.lerp(
        buttonTextStyle,
        other.buttonTextStyle,
        t,
      ),
      defaultButtonBackgroundColor: Color.lerp(
        defaultButtonBackgroundColor,
        other.defaultButtonBackgroundColor,
        t,
      )!,
      defaultButtonForegroundColor: Color.lerp(
        defaultButtonForegroundColor,
        other.defaultButtonForegroundColor,
        t,
      ),
      buttonBorderColor: Color.lerp(
        buttonBorderColor,
        other.buttonBorderColor,
        t,
      ),
      primaryButtonBackgroundColor: Color.lerp(
        primaryButtonBackgroundColor,
        other.primaryButtonBackgroundColor,
        t,
      ),
      primaryButtonForegroundColor: Color.lerp(
        primaryButtonForegroundColor,
        other.primaryButtonForegroundColor,
        t,
      ),
      errorIconColor: Color.lerp(errorIconColor, other.errorIconColor, t)!,
      successIconColor: Color.lerp(
        successIconColor,
        other.successIconColor,
        t,
      )!,
      infoIconColor: Color.lerp(infoIconColor, other.infoIconColor, t)!,
      iconSize: _lerpDouble(iconSize, other.iconSize, t),
      barrierOpacity: _lerpDouble(barrierOpacity, other.barrierOpacity, t),
      dialogRadius: _lerpDouble(dialogRadius, other.dialogRadius, t),
      waitingDialogRadius: _lerpDouble(
        waitingDialogRadius,
        other.waitingDialogRadius,
        t,
      ),
      buttonMinimumSize: Size.lerp(
        buttonMinimumSize,
        other.buttonMinimumSize,
        t,
      )!,
    );
  }

  static double _lerpDouble(double a, double b, double t) => a + (b - a) * t;
}
