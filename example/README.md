# dialog_utils example

This is the runnable example application for the `dialog_utils` package.

## Run

From this directory, choose an available Flutter device and run:

```bash
flutter pub get
flutter run
```

You can also select a specific platform:

```bash
flutter run -d chrome
flutter run -d macos
flutter run -d windows
flutter run -d linux
```

Android and iOS devices or emulators are available through `flutter devices`.

## What It Demonstrates

- The **Simple** tab uses `DialogUtils()` directly.
- The **Override icon** tab uses `CustomDialogUtils` and overrides `errorIcon`.
- `DialogUtilsStyle` is configured through `ThemeData.extensions`.
- `ElevatedButtonThemeData` is configured alongside the dialog theme.
- The simple tab demonstrates information and waiting dialogs.
- The waiting dialog runs a delayed `FutureResult.success` operation.

The waiting dialog accepts a callback returning `FutureResult<T>`:

```dart
final result = await DialogUtils().showWaitingDlg<String>(
	context: context,
	future: () async {
		final value = await loadData();
		return FutureResult.success(value);
	},
);

if (result.hasError) {
	// Handle result.error.
} else {
	// Use result.value.
}
```

## Test

Run the example smoke test with:

```bash
flutter test
```