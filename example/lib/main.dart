import 'package:flutter/material.dart';
// import 'package:dialog_utils/dialog_utils.dart';

import 'dialog_examples_page.dart';
import 'dialog_examples_page_ext.dart';

void main() {
  runApp(const DialogUtilsExampleApp());
}

class DialogUtilsExampleApp extends StatelessWidget {
  const DialogUtilsExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.teal);

    return MaterialApp(
      title: 'Dialog Utils Example',
      theme: ThemeData(
        colorScheme: colorScheme,
        /* optional declare you own dialog utils theme
        extensions: const [
          DialogUtilsStyle(
            titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            contentTextStyle: TextStyle(fontSize: 17),
            buttonTextStyle: TextStyle(fontSize: 16),
            errorIconColor: Colors.deepOrange,
            successIconColor: Colors.teal,
            infoIconColor: Colors.indigo,
            iconSize: 48,
            dialogRadius: 16,
            buttonMinimumSize: Size(120, 50),
          ),
        ], */
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
      home: const DialogExamplesNavigationPage(),
    );
  }
}

class DialogExamplesNavigationPage extends StatelessWidget {
  const DialogExamplesNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dialog Utils'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Simple'),
              Tab(text: 'Override icon'),
            ],
          ),
        ),
        body: const TabBarView(children: [DialogExamplesPage(), OverriddenDialogExamplesPage()]),
      ),
    );
  }
}
