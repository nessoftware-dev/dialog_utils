import 'package:dialog_utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:result_utils/result_utils.dart';

class DialogExamplesPage extends StatelessWidget {
  const DialogExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => DialogUtils().showErrorDlg(
                context,
                title: 'Error',
                content: 'This dialog uses DialogUtilsStyle from ThemeData.',
              ),
              child: const Text('Show error dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => DialogUtils().showSuccessDlg(
                context,
                title: 'Saved',
                content: 'The document was saved successfully.',
              ),
              child: const Text('Show success dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => DialogUtils().showConfirmDlg(
                context,
                title: 'Delete document?',
                content: 'This action cannot be undone.',
                confirmButtonTxt: 'Delete',
              ),
              child: const Text('Show confirmation dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  DialogUtils().showInfoDlg(context, title: 'Info', content: 'This is an informational dialog.'),
              child: const Text('Show information dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final result = await DialogUtils().showWaitingDlg<String>(
                  context: context,
                  future: () async {
                    await Future<void>.delayed(const Duration(seconds: 2));
                    return FutureResult.success('Finished successfully');
                  },
                );
                if (context.mounted && !result.hasError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.value ?? 'Finished')));
                }
              },
              child: const Text('Show waiting dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
