import 'package:flutter_test/flutter_test.dart';

import 'package:dialog_utils_example/main.dart';

void main() {
  testWidgets('shows both dialog example pages', (WidgetTester tester) async {
    await tester.pumpWidget(const DialogUtilsExampleApp());

    expect(find.text('Show error dialog'), findsOneWidget);
    expect(find.text('Override icon'), findsOneWidget);

    await tester.tap(find.text('Override icon'));
    await tester.pumpAndSettle();
    expect(find.text('Show overridden icon'), findsOneWidget);
  });
}
