import 'package:dialog_utils/dialog_utils.dart';
import 'package:flutter/material.dart';

class CustomDialogUtils extends DialogUtils {
  const CustomDialogUtils() : super.withStyle();

  @override
  Widget errorIcon(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.deepOrange.withValues(alpha: 0.15), shape: BoxShape.circle),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(Icons.warning_amber_rounded, size: 48, color: Colors.deepOrange),
      ),
    );
  }
}

class OverriddenDialogExamplesPage extends StatelessWidget {
  const OverriddenDialogExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => const CustomDialogUtils().showErrorDlg(
          context,
          title: 'Custom error icon',
          content: 'CustomDialogUtils overrides errorIcon and returns a widget.',
        ),
        child: const Text('Show overridden icon'),
      ),
    );
  }
}
