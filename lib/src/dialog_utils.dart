import 'dart:async';
import 'package:flutter/material.dart';
import 'package:result_utils/result_utils.dart';
import 'dialog_utils_style.dart';

/// A reusable and extensible collection of commonly used dialogs.
class DialogUtils {
  /// Returns the shared application-wide dialog utility instance.
  ///
  /// Style comes from [ThemeData.extensions] when a [DialogUtilsStyle] is
  /// present, otherwise from [DialogUtilsStyle] defaults. Use [withStyle] for
  /// an independent instance that should ignore the theme.
  factory DialogUtils() => _singleton ??= const DialogUtils.withStyle();

  /// Creates an independent instance, primarily for subclassing or testing.
  const DialogUtils.withStyle({this.style});

  static DialogUtils? _singleton;

  /// Optional fixed style. If null, the style is read from the active theme.
  final DialogUtilsStyle? style;

  /// Resolves a pinned instance style, else the theme extension, else defaults.
  DialogUtilsStyle _style(BuildContext context) =>
      style ?? Theme.of(context).extension<DialogUtilsStyle>() ?? const DialogUtilsStyle();

  /// Returns the title style used by dialogs.
  TextStyle dialogTitleStyle(BuildContext context) =>
      _style(context).titleTextStyle ?? Theme.of(context).textTheme.titleMedium!;

  /// Returns the content style used by dialogs.
  TextStyle dialogContentStyle(BuildContext context) =>
      _style(context).contentTextStyle ?? Theme.of(context).textTheme.bodyMedium!;

  /// Returns the text style used by dialog buttons.
  TextStyle dialogButtonTextStyle(BuildContext context) =>
      _style(context).buttonTextStyle ?? Theme.of(context).textTheme.labelMedium!;

  /// Returns the style for default dialog buttons.
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

  Future<bool> _showDialog(
    BuildContext context, {
    required Widget icon,
    required String title,
    required String content,
    String okButtonText = 'OK',
    String? cancelButtonText,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          barrierColor: dialogBarrierColor(context),
          builder: (dialogContext) => AlertDialog(
            title: icon is SizedBox
                ? Text(title, style: dialogTitleStyle(dialogContext))
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      icon,
                      const SizedBox(height: 15),
                      Center(child: Text(title, style: dialogTitleStyle(dialogContext))),
                    ],
                  ),
            content: Text(content, style: dialogContentStyle(dialogContext)),
            shape: dialogShape(dialogContext),
            actions: [
              if (cancelButtonText != null)
                ElevatedButton(
                  style: defaultButtonStyle(dialogContext),
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(cancelButtonText),
                ),
              ElevatedButton(
                style: cancelButtonText == null ? defaultButtonStyle(dialogContext) : primaryButtonStyle(dialogContext),
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(okButtonText),
              ),
            ],
            actionsAlignment: MainAxisAlignment.end,
            actionsOverflowButtonSpacing: 10,
          ),
        ) ??
        false;
  }

  /// Shows an error dialog and returns whether OK was chosen.
  Future<bool> showErrorDlg(
    BuildContext context, {
    required String title,
    required String content,
    String okButtonText = 'OK',
    String? cancelButtonText,
  }) => _showDialog(
    context,
    icon: errorIcon(context),
    title: title,
    content: content,
    okButtonText: okButtonText,
    cancelButtonText: cancelButtonText,
  );

  /// Shows a success dialog and returns whether OK was chosen.
  Future<bool> showSuccessDlg(
    BuildContext context, {
    required String title,
    required String content,
    String okButtonText = 'OK',
    String? cancelButtonText,
  }) => _showDialog(
    context,
    icon: successIcon(context),
    title: title,
    content: content,
    okButtonText: okButtonText,
    cancelButtonText: cancelButtonText,
  );

  /// Shows a confirmation dialog and returns whether it was confirmed.
  Future<bool> showConfirmDlg(
    BuildContext context, {
    required String title,
    required String content,
    String cancelButtonText = 'Cancel',
    required String confirmButtonText,
  }) => _showDialog(
    context,
    icon: SizedBox(),
    title: title,
    content: content,
    okButtonText: confirmButtonText,
    cancelButtonText: cancelButtonText,
  );

  /// Shows an information dialog and returns whether OK was chosen.
  Future<bool> showInfoDlg(
    BuildContext context, {
    required String title,
    required String content,
    String okButtonText = 'OK',
    String? cancelButtonText,
  }) => _showDialog(
    context,
    icon: infoIcon(context),
    title: title,
    content: content,
    okButtonText: okButtonText,
    cancelButtonText: cancelButtonText,
  );

  /// Shows a progress dialog while [future] is running and returns its result.
  Future<FutureResult<T>> showWaitingDlg<T>({
    required BuildContext context,
    required Future<FutureResult<T>> Function() future,
    String message = 'Waiting for result...',
  }) async {
    final popContextCompleter = Completer<BuildContext>();
    BuildContext? popContext;
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierColor: dialogBarrierColor(context),
        builder: (dialogContext) {
          if (!popContextCompleter.isCompleted) {
            popContextCompleter.complete(dialogContext);
          }
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(message, style: dialogContentStyle(dialogContext)),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(_style(dialogContext).waitingDialogRadius)),
            ),
          );
        },
      ),
    );
    try {
      final result = await future();
      popContext = await popContextCompleter.future;
      return result;
    } finally {
      final dialogContext = popContext;
      if (dialogContext != null && dialogContext.mounted) {
        Navigator.of(dialogContext).pop();
      } else {
        debugPrint('dialog_utils.showWaitingDlg: popContext is null or not mounted.');
      }
    }
  }
}
