import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3DgIESUpGqAea4PmxIkJcNOtzgbSQrX8',
    appId: '1:646397277659:android:c68c64e477c190158963fe',
    messagingSenderId: '646397277659',
    projectId: 'flutter-8c223',
    databaseURL:
        'https://flutter-8c223-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-8c223.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0ynMTjBBl1Y75r8S1qez2h_4BV1AkSTI',
    appId: '1:646397277659:ios:90ca6fa96e2e02148963fe',
    messagingSenderId: '646397277659',
    projectId: 'flutter-8c223',
    databaseURL:
        'https://flutter-8c223-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-8c223.appspot.com',
    iosClientId:
        '646397277659-t74oujlp34cvqbpik0ba72eqa0tt2dds.apps.googleusercontent.com',
    iosBundleId: 'com.example.fireter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0ynMTjBBl1Y75r8S1qez2h_4BV1AkSTI',
    appId: '1:646397277659:ios:90ca6fa96e2e02148963fe',
    messagingSenderId: '646397277659',
    projectId: 'flutter-8c223',
    databaseURL:
        'https://flutter-8c223-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-8c223.appspot.com',
    iosClientId:
        '646397277659-t74oujlp34cvqbpik0ba72eqa0tt2dds.apps.googleusercontent.com',
    iosBundleId: 'com.example.fireter',
  );
}
