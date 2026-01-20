import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleStartup();
  }

  Future<void> _handleStartup() async {
    try {
      // ให้ splash แสดงอย่างน้อยนิดหนึ่ง
      await Future.delayed(const Duration(seconds: 1));

      // 🔑 รอ Firebase Auth คืนค่า state จริง
      final user =
          await FirebaseAuth.instance.authStateChanges().first;

      if (!mounted) return;

      if (user != null) {
        debugPrint('✅ User logged in → /home');
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        debugPrint('⚠️ No user → /login');
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      debugPrint('❌ Splash error: $e');

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.cyan.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.visibility,
                size: 80,
                color: Colors.cyan.shade700,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Eye Screening App',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'ตรวจสายตาออนไลน์',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              color: Colors.cyan,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
