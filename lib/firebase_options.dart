// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCo6pm30bCITRlwZpabT3LYGQHu9n4866A',
    appId: '1:601666053928:web:2e50a96aa9075b87c6521d',
    messagingSenderId: '601666053928',
    projectId: 'make-linkup',
    authDomain: 'make-linkup.firebaseapp.com',
    storageBucket: 'make-linkup.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSDTWjgqaoERGNkiWlU3DOKC0a0_NuM6Q',
    appId: '1:601666053928:android:c50a745109ac61b1c6521d',
    messagingSenderId: '601666053928',
    projectId: 'make-linkup',
    storageBucket: 'make-linkup.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBa9hbINfJ41zUJA_BnuLCyh3ug22Le2g4',
    appId: '1:601666053928:ios:ac02f27c09ed986ac6521d',
    messagingSenderId: '601666053928',
    projectId: 'make-linkup',
    storageBucket: 'make-linkup.appspot.com',
    iosClientId: '601666053928-37aq4he48eaj3bf1g063abq7lrqeutpc.apps.googleusercontent.com',
    iosBundleId: 'com.example.linkupApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBa9hbINfJ41zUJA_BnuLCyh3ug22Le2g4',
    appId: '1:601666053928:ios:b5d0c19a82495ba0c6521d',
    messagingSenderId: '601666053928',
    projectId: 'make-linkup',
    storageBucket: 'make-linkup.appspot.com',
    iosClientId: '601666053928-bqvshue2b39qj5qbt61inb8tqiqgbcv3.apps.googleusercontent.com',
    iosBundleId: 'com.example.linkupApp.RunnerTests',
  );
}
