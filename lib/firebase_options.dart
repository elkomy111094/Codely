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
    apiKey: 'AIzaSyAXriwllack6hn_QCFqJ6-dkmcE_SNAW6E',
    appId: '1:829735852026:web:44d2741b8569afa1dcb643',
    messagingSenderId: '829735852026',
    projectId: 'smartshopper-34a3f',
    authDomain: 'smartshopper-34a3f.firebaseapp.com',
    storageBucket: 'smartshopper-34a3f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYj8-MES0MUshNCbBVsNj6mVZIY23MtS4',
    appId: '1:829735852026:android:58c4658346576a31dcb643',
    messagingSenderId: '829735852026',
    projectId: 'smartshopper-34a3f',
    storageBucket: 'smartshopper-34a3f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAC3fg_wvktuc9X3j8Je7M4PgPX1rjDf8w',
    appId: '1:829735852026:ios:cddbcae12eb4c8dcdcb643',
    messagingSenderId: '829735852026',
    projectId: 'smartshopper-34a3f',
    storageBucket: 'smartshopper-34a3f.appspot.com',
    iosBundleId: 'com.example.smartShoperMaster',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAC3fg_wvktuc9X3j8Je7M4PgPX1rjDf8w',
    appId: '1:829735852026:ios:894d950872a0c2afdcb643',
    messagingSenderId: '829735852026',
    projectId: 'smartshopper-34a3f',
    storageBucket: 'smartshopper-34a3f.appspot.com',
    iosBundleId: 'com.example.smartShoperMaster.RunnerTests',
  );
}
