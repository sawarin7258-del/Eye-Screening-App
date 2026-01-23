class TestResult {
  final int? localId;        // 🔑 สำหรับ SQLite
  final String id;           // 🔥 Firestore ID
  final String userId;
  final String leftEyeResult;
  final String rightEyeResult;
  final bool isRisk;
  final String testDate;
  final DateTime timestamp;
  final bool isDeleted;

  TestResult({
    this.localId,
    required this.id,
    required this.userId,
    required this.leftEyeResult,
    required this.rightEyeResult,
    required this.isRisk,
    required this.testDate,
    required this.timestamp,
    this.isDeleted = false,
  });

  // 🔹 SQLite: Map → Object
  factory TestResult.fromSqlite(Map<String, dynamic> map) {
    return TestResult(
      localId: map['localId'],
      id: map['id'],
      userId: map['userId'],
      leftEyeResult: map['leftEyeResult'],
      rightEyeResult: map['rightEyeResult'],
      isRisk: map['isRisk'] == 1,
      testDate: map['testDate'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      isDeleted: map['isDeleted'] == 1,
    );
  }

  // 🔹 SQLite: Object → Map
  Map<String, dynamic> toSqlite() {
    return {
      'id': id,
      'userId': userId,
      'leftEyeResult': leftEyeResult,
      'rightEyeResult': rightEyeResult,
      'isRisk': isRisk ? 1 : 0,
      'testDate': testDate,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'isDeleted': isDeleted ? 1 : 0,
    };
  }

  // 🔹 Firestore (ของเดิมคุณ)
  factory TestResult.fromMap(Map<String, dynamic> map, String id) {
    return TestResult(
      id: id,
      userId: map['userId'] ?? '',
      leftEyeResult: map['leftEyeResult'] ?? '',
      rightEyeResult: map['rightEyeResult'] ?? '',
      isRisk: map['isRisk'] ?? false,
      testDate: map['testDate'] ?? '',
      timestamp: map['timestamp']?.toDate() ?? DateTime.now(),
      isDeleted: map['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'leftEyeResult': leftEyeResult,
      'rightEyeResult': rightEyeResult,
      'isRisk': isRisk,
      'testDate': testDate,
      'timestamp': timestamp,
      'isDeleted': isDeleted,
    };
  }
}
