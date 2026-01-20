// Email Service ยังไม่สำเร็จ - ต้องตั้งค่า SMTP server จริง
class EmailService {
  // ส่ง email ผลการตรวจ
  Future<void> sendTestResultEmail({
    required String recipientEmail,
    required String recipientName,
    required String leftEyeResult,
    required String rightEyeResult,
    required bool isRisk,
    required String testDate,
  }) async {
    try {
      // TODO: ตั้งค่า Gmail credentials ใน .env
      // const emailAddress = String.fromEnvironment('EMAIL_ADDRESS');
      // const emailPassword = String.fromEnvironment('EMAIL_PASSWORD');
      
      // ตอนนี้เป็นเพียง placeholder
      print('Email would be sent to: $recipientEmail');
      print('Test Date: $testDate');
      print('Left Eye: $leftEyeResult, Right Eye: $rightEyeResult');
      print('Status: ${isRisk ? 'At Risk' : 'Normal'}');
      
      // TODO: Implement actual SMTP send using mailer package
      // final smtpServer = gmail(emailAddress, emailPassword);
      // await send(message, [smtpServer]);
    } catch (e) {
      throw Exception('Error sending email: $e');
    }
  }
}
