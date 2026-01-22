import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/test_start_screen.dart';
import 'screens/test_running_screen.dart';
import 'screens/test_error_screen.dart';
import 'screens/result_normal_screen.dart';
import 'screens/result_risk_screen.dart';
import 'screens/history_screen.dart';
import 'screens/knowledge_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/trash_history_screen.dart';

import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // ✅ Initialize Firebase
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('✅ Firebase initialized successfully');
    }
  } catch (e) {
    print('❌ Firebase initialization error: $e');
  }

  runApp(const EyeScreeningApp());
}

class EyeScreeningApp extends StatelessWidget {
  const EyeScreeningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eye Screening App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'Prompt',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/test-start': (context) => const TestStartScreen(),
        '/test-running': (context) {
          final File? imageFile =
              ModalRoute.of(context)?.settings.arguments as File?;
          return TestRunningScreen(imageFile: imageFile);
        },
        '/test-error': (context) => const TestErrorScreen(),
        '/result-normal': (context) {
          final Map<String, dynamic>? resultData =
              ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>?;
          return ResultNormalScreen(resultData: resultData);
        },
        '/result-risk': (context) {
          final Map<String, dynamic>? resultData =
              ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>?;
          return ResultRiskScreen(resultData: resultData);
        },
        '/history': (context) => const HistoryScreen(),
        '/knowledge': (context) => const KnowledgeScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/trash': (context) => const TrashHistoryScreen(),
      },
    );
  }
}
