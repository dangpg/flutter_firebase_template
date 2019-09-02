# flutter_firebase_template

Ready to use project template for incorporating Firebase within a Flutter project.


__Features:__
* Authentication (FirebaseAuth)
  * Login with Email and Password
  * Logout
* Registration
* Firestore
  * CRUD operations
* Firebase storage
* Intact archictecture powered by Provider
* Navigation system
* Unit testing
  * Mock service implementations powered by dependency injection
* Settings system powered by shared preferences
  * Internatalization
  * Theming (light/dark theme)

## i18n

Generate i18n.arb template file (based on Intl.messages in app_localizations.dart)
`flutter pub run intl_translation:extract_to_arb --output-dir=lib/i18n lib/ui/app_localizations.dart`

Generate messages.dart files (based on intl_*.arb files)
`flutter pub run intl_translation:generate_from_arb --output-dir=lib/i18n --no-use-deferred-loading lib/ui/app_localizations.dart lib/i18n/intl_*.arb`

## Getting Started

1. Create new Firebase project ([Firebase Console](https://console.firebase.google.com/))
2. Add Firebase to your Android/iOS app (Register app name. Found in `android/app/build.gradle`)
3. Save google-services.json to `android/app`

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
