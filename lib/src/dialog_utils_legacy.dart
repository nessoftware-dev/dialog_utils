part of 'dialog_utils.dart';

/// Returns the default style for secondary dialog buttons.
ButtonStyle defaultDlgButtonStyle([BuildContext? context]) {
  if (context != null) {
    return DialogUtils().defaultButtonStyle(context);
  }
  final style = DialogUtils().style ?? const DialogUtilsStyle();
  final colorScheme = ThemeData().colorScheme;
  return ElevatedButton.styleFrom(
    backgroundColor: style.defaultButtonBackgroundColor,
    foregroundColor: colorScheme.inversePrimary,
    minimumSize: style.buttonMinimumSize,
    side: BorderSide(width: 1, color: colorScheme.inversePrimary),
    shadowColor: Colors.transparent,
    elevation: 0,
  );
}

/// Returns the default style for primary dialog buttons.
ButtonStyle primaryDlgButtonStyle([BuildContext? context]) {
  if (context != null) {
    return DialogUtils().primaryButtonStyle(context);
  }
  final style = DialogUtils().style ?? const DialogUtilsStyle();
  final colorScheme = ThemeData().colorScheme;
  return ElevatedButton.styleFrom(
    backgroundColor: colorScheme.inversePrimary,
    foregroundColor: colorScheme.primary,
    minimumSize: style.buttonMinimumSize,
    shadowColor: Colors.transparent,
    elevation: 0,
  );
}

/// Shows an error dialog using the shared default instance.
Future<bool> showErrorDlg(
  BuildContext context, {
  required String title,
  required String content,
  String okButtonText = 'OK',
  String? cancelButtonTxt,
}) => DialogUtils().showErrorDlg(
  context,
  title: title,
  content: content,
  okButtonText: okButtonText,
  cancelButtonTxt: cancelButtonTxt,
);

/// Shows a success dialog using the shared default instance.
Future<bool> showSuccessDlg(
  BuildContext context, {
  required String title,
  required String content,
  String okButtonText = 'OK',
  String? cancelButtonTxt,
}) => DialogUtils().showSuccessDlg(
  context,
  title: title,
  content: content,
  okButtonText: okButtonText,
  cancelButtonTxt: cancelButtonTxt,
);

/// Shows a confirmation dialog using the shared default instance.
Future<bool> showConfirmDlg(
  BuildContext context, {
  required String title,
  required String content,
  String cancelButtonTxt = 'Cancel',
  required String confirmButtonTxt,
}) => DialogUtils().showConfirmDlg(
  context,
  title: title,
  content: content,
  cancelButtonTxt: cancelButtonTxt,
  confirmButtonTxt: confirmButtonTxt,
);

/// Shows an information dialog using the shared default instance.
Future<void> showInfoDlg(BuildContext context, {required String title, required String content}) =>
    DialogUtils().showInfoDlg(context, title: title, content: content);

/// Shows a progress dialog using the shared default instance.
Future<FutureResult<T>> showWaitingDlg<T>({
  required BuildContext context,
  required Future<FutureResult<T>> Function() future,
  String message = 'Einen Moment bitte...',
}) => DialogUtils().showWaitingDlg(context: context, future: future, message: message);
