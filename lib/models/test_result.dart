class TestResult {
  final String id;
  final String userId;
  final String leftEyeResult;
  final String rightEyeResult;
  final bool isRisk;
  final String testDate;
  final DateTime timestamp;
  final bool isDeleted;

  TestResult({
    required this.id,
    required this.userId,
    required this.leftEyeResult,
    required this.rightEyeResult,
    required this.isRisk,
    required this.testDate,
    required this.timestamp,
    this.isDeleted = false,
  });

  factory TestResult.fromMap(Map<String, dynamic> map, String id) {
    return TestResult(
      id: id,
      userId: map['userId'] ?? '',
      leftEyeResult: map['leftEyeResult'] ?? '',
      rightEyeResult: map['rightEyeResult'] ?? '',
      isRisk: map['isRisk'] ?? false,
      testDate: map['testDate'] ?? '',
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as dynamic).toDate()
          : DateTime.now(),
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
