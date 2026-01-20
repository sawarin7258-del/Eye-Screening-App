import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // บันทึกผลการตรวจ
  Future<void> saveTestResult({
    required String userId,
    required String leftEyeResult,
    required String rightEyeResult,
    required bool isRisk,
    required String testDate,
  }) async {
    try {
      await _db.collection('users').doc(userId).collection('test_results').add({
        'leftEyeResult': leftEyeResult,
        'rightEyeResult': rightEyeResult,
        'isRisk': isRisk,
        'testDate': testDate,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error saving test result: $e');
    }
  }

  // ดึงประวัติการตรวจ
  Future<List<Map<String, dynamic>>> getTestHistory(String userId) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('test_results')
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception('Error fetching test history: $e');
    }
  }

  // บันทึกข้อมูลผู้ใช้
  Future<void> saveUserData({
    required String userId,
    required String email,
    required String displayName,
  }) async {
    try {
      await _db.collection('users').doc(userId).set({
        'email': email,
        'displayName': displayName,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error saving user data: $e');
    }
  }

  // ดึงข้อมูลผู้ใช้
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc =
          await _db.collection('users').doc(userId).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }
}
