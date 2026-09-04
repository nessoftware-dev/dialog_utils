part of 'dialog_utils.dart';

extension DialogUtilsDialogs on DialogUtils {
  Future<bool> _showDialog(
    BuildContext context, {
    required Widget icon,
    required String title,
    required String content,
    String okButtonText = 'OK',
    String? cancelButtonTxt,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          barrierColor: dialogBarrierColor(context),
          builder: (dialogContext) => AlertDialog(
            title: Column(
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
              ElevatedButton(
                style: cancelButtonTxt == null ? primaryButtonStyle(dialogContext) : defaultButtonStyle(dialogContext),
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(okButtonText),
              ),
              if (cancelButtonTxt != null)
                ElevatedButton(
                  style: defaultButtonStyle(dialogContext),
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(cancelButtonTxt),
                ),
            ],
            actionsAlignment: MainAxisAlignment.end,
          ),
        ) ??
        false;
  }

  /// Shows an error dialog and returns whether its primary action was chosen.
  Future<bool> showErrorDlg(
    BuildContext context, {
    required String title,
    required String content,
    String okButtonText = 'OK',
    String? cancelButtonTxt,
  }) => _showDialog(
    context,
    icon: errorIcon(context),
    title: title,
    content: content,
    okButtonText: okButtonText,
    cancelButtonTxt: cancelButtonTxt,
  );

  /// Shows a success dialog and returns whether its primary action was chosen.
  Future<bool> showSuccessDlg(
    BuildContext context, {
    required String title,
    required String content,
    String okButtonText = 'OK',
    String? cancelButtonTxt,
  }) => _showDialog(
    context,
    icon: successIcon(context),
    title: title,
    content: content,
    okButtonText: okButtonText,
    cancelButtonTxt: cancelButtonTxt,
  );

  /// Shows a confirmation dialog and returns the user's choice.
  Future<bool> showConfirmDlg(
    BuildContext context, {
    required String title,
    required String content,
    String cancelButtonTxt = 'Cancel',
    required String confirmButtonTxt,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          barrierColor: dialogBarrierColor(context),
          builder: (dialogContext) => AlertDialog(
            title: Text(title, style: dialogTitleStyle(dialogContext)),
            content: Text(content, style: dialogContentStyle(dialogContext)),
            shape: dialogShape(dialogContext),
            actions: [
              ElevatedButton(
                style: defaultButtonStyle(dialogContext),
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(cancelButtonTxt),
              ),
              ElevatedButton(
                style: primaryButtonStyle(dialogContext),
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(confirmButtonTxt),
              ),
            ],
          ),
        ) ??
        false;
  }

  /// Shows an information dialog with an OK action.
  Future<bool> showInfoDlg(
    BuildContext context, {
    required String title,
    required String content,
    String okButtonText = 'OK',
    String? cancelButtonTxt,
  }) => _showDialog(
    context,
    icon: infoIcon(context),
    title: title,
    content: content,
    okButtonText: okButtonText,
    cancelButtonTxt: cancelButtonTxt,
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
