import 'dart:async';
import 'package:flutter/material.dart';
import 'package:result_utils/result_utils.dart';
import 'dialog_utils_style.dart';

part 'dialog_utils_legacy.dart';
part 'dialog_utils_methods.dart';

/// A reusable and extensible collection of commonly used dialogs.
class DialogUtils {
  /// Returns the shared application-wide dialog utility instance.
  ///
  /// The optional [style] is used when the singleton is first created. For
  /// theme-based configuration, add [DialogUtilsStyle] to [ThemeData.extensions].
  factory DialogUtils({DialogUtilsStyle? style}) {
    return _singleton ??= DialogUtils._(style);
  }

  /// Creates an independent instance, primarily for subclassing or testing.
  const DialogUtils.withStyle({this.style});

  DialogUtils._(this.style);

  static DialogUtils? _singleton;

  /// Optional fixed style. If null, the style is read from the active theme.
  final DialogUtilsStyle? style;

  /// Resolves the instance style or the nearest theme style.
  DialogUtilsStyle _style(BuildContext context) =>
      style ?? Theme.of(context).extension<DialogUtilsStyle>() ?? const DialogUtilsStyle();

  /// Returns the title style used by dialogs.
  TextStyle dialogTitleStyle(BuildContext context) =>
      _style(context).titleTextStyle ?? Theme.of(context).textTheme.titleLarge!;

  /// Returns the content style used by dialogs.
  TextStyle dialogContentStyle(BuildContext context) =>
      _style(context).contentTextStyle ?? Theme.of(context).textTheme.bodyLarge!;

  /// Returns the text style used by dialog buttons.
  TextStyle dialogButtonTextStyle(BuildContext context) =>
      _style(context).buttonTextStyle ?? Theme.of(context).textTheme.labelLarge!;

  /// Returns the style for secondary dialog buttons.
  ButtonStyle defaultButtonStyle(BuildContext context) => _buttonStyle(context);

  /// Returns the style for primary dialog buttons.
  ButtonStyle primaryButtonStyle(BuildContext context) => _buttonStyle(context, primary: true);

  ButtonStyle _buttonStyle(BuildContext context, {bool primary = false}) {
    final colorScheme = Theme.of(context).colorScheme;
    final dialogStyle = _style(context);
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: primary
          ? dialogStyle.primaryButtonBackgroundColor ?? colorScheme.inversePrimary
          : dialogStyle.defaultButtonBackgroundColor,
      foregroundColor: primary
          ? dialogStyle.primaryButtonForegroundColor ?? colorScheme.primary
          : dialogStyle.defaultButtonForegroundColor ?? colorScheme.inversePrimary,
      minimumSize: dialogStyle.buttonMinimumSize,
      side: primary ? null : BorderSide(width: 1, color: dialogStyle.buttonBorderColor ?? colorScheme.inversePrimary),
      textStyle: dialogButtonTextStyle(context),
    );
    return Theme.of(context).elevatedButtonTheme.style?.merge(buttonStyle) ?? buttonStyle;
  }

  /// Returns the icon widget used by error dialogs.
  Widget errorIcon(BuildContext context) =>
      Icon(Icons.error, size: _style(context).iconSize, color: _style(context).errorIconColor);

  /// Returns the icon widget used by success dialogs.
  Widget successIcon(BuildContext context) =>
      Icon(Icons.check, size: _style(context).iconSize, color: _style(context).successIconColor);

  /// Returns the icon widget used by information dialogs.
  Widget infoIcon(BuildContext context) =>
      Icon(Icons.info, size: _style(context).iconSize, color: _style(context).infoIconColor);

  /// Returns the modal barrier color used by dialogs.
  Color dialogBarrierColor(BuildContext context) => Colors.black.withValues(alpha: _style(context).barrierOpacity);

  /// Returns the shape used by standard dialogs.
  ShapeBorder dialogShape(BuildContext context) =>
      RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_style(context).dialogRadius)));
}
