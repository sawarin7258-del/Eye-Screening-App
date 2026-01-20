import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (Platform.isAndroid) {
      return android;
    }
    throw UnsupportedError(
      'This Firebase configuration is only supported on Android.',
    );
  }

  // ✅ Android (ค่าจริงของคุณ)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwYiWdU8Vz-vJ9R9hknlammTh4aMValr8',
    appId: '1:512193286712:android:a0023aeb81c1af06118ccd',
    messagingSenderId: '512193286712',
    projectId: 'eye-screening-app-fd399',
    storageBucket: 'eye-screening-app-fd399.firebasestorage.app',
  );
}
