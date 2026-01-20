import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // ลงทะเบียนด้วย email และ password
  Future<UserCredential?> registerWithEmail(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      // สร้าง user
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // อัปเดต display name (แยกออกมาเพื่อป้องกัน type error)
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(displayName.trim());
        await user.reload(); // รีโหลดข้อมูลใหม่
        user = _firebaseAuth.currentUser; // ดึงข้อมูลล่าสุด
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = 'เกิดข้อผิดพลาด';
      
      switch (e.code) {
        case 'weak-password':
          message = 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
          break;
        case 'email-already-in-use':
          message = 'อีเมลนี้ถูกใช้งานแล้ว';
          break;
        case 'invalid-email':
          message = 'รูปแบบอีเมลไม่ถูกต้อง';
          break;
        default:
          message = e.message ?? 'เกิดข้อผิดพลาด';
      }
      
      throw Exception(message);
    } catch (e) {
      throw Exception('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  // เข้าสู่ระบบด้วย email และ password
  Future<UserCredential?> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = 'เกิดข้อผิดพลาด';
      
      switch (e.code) {
        case 'user-not-found':
          message = 'ไม่พบบัญชีนี้';
          break;
        case 'wrong-password':
          message = 'รหัสผ่านไม่ถูกต้อง';
          break;
        case 'invalid-email':
          message = 'รูปแบบอีเมลไม่ถูกต้อง';
          break;
        case 'user-disabled':
          message = 'บัญชีนี้ถูกปิดการใช้งาน';
          break;
        case 'invalid-credential':
          message = 'อีเมลหรือรหัสผ่านไม่ถูกต้อง';
          break;
        default:
          message = e.message ?? 'เกิดข้อผิดพลาด';
      }
      
      throw Exception(message);
    } catch (e) {
      throw Exception('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  // ออกจากระบบ
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('ไม่สามารถออกจากระบบได้: ${e.toString()}');
    }
  }

  // ตรวจสอบสถานะการเข้าสู่ระบบ
  Stream<User?> get authStateChanges =>
      _firebaseAuth.authStateChanges();

  // รับข้อมูลผู้ใช้ปัจจุบัน
  User? get currentUser => _firebaseAuth.currentUser;
}