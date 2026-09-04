import 'package:dialog_utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class CustomDialogUtils extends DialogUtils {
  const CustomDialogUtils()
    : super.withStyle(
        style: const DialogUtilsStyle(titleTextStyle: TextStyle(fontSize: 24), errorIconColor: Colors.orange),
      );

  @override
  Widget errorIcon(BuildContext context) => const Padding(padding: EdgeInsets.all(8), child: Icon(Icons.warning));
}

void main() {
  test('DialogUtils returns a reusable singleton instance', () {
    expect(identical(DialogUtils(), DialogUtils()), isTrue);
  });

  test('style values configure defaults', () {
    const dialogUtils = DialogUtils.withStyle(style: DialogUtilsStyle(iconSize: 48, infoIconColor: Colors.indigo));

    final icon = dialogUtils.infoIcon(FakeBuildContext()) as Icon;

    expect(icon.icon, Icons.info);
    expect(icon.size, 48);
    expect(icon.color, Colors.indigo);
  });

  testWidgets('singleton reads DialogUtilsStyle from ThemeData', (tester) async {
    double? resolvedIconSize;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: const [DialogUtilsStyle(iconSize: 52, infoIconColor: Colors.indigo)]),
        home: Builder(
          builder: (context) {
            resolvedIconSize = (DialogUtils().infoIcon(context) as Icon).size;
            return const SizedBox();
          },
        ),
      ),
    );

    expect(resolvedIconSize, 52);
  });

  test('style and icon methods can be overridden', () {
    const dialogUtils = CustomDialogUtils();

    final titleStyle = dialogUtils.dialogTitleStyle(FakeBuildContext());
    final icon = dialogUtils.errorIcon(FakeBuildContext());

    expect(titleStyle.fontSize, 24);
    expect(icon, isA<Padding>());
  });
}

class FakeBuildContext implements BuildContext {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
