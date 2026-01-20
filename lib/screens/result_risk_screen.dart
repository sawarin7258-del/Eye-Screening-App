import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/firestore_service.dart';
import '../services/email_service.dart';
import '../services/auth_service.dart';

class ResultRiskScreen extends StatefulWidget {
  final Map<String, dynamic>? resultData;

  const ResultRiskScreen({super.key, this.resultData});

  @override
  State<ResultRiskScreen> createState() => _ResultRiskScreenState();
}

class _ResultRiskScreenState extends State<ResultRiskScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final EmailService _emailService = EmailService();
  final AuthService _authService = AuthService();
  bool _isSendingEmail = false;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _saveTestResult();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });
  }

  Future<void> _saveTestResult() async {
    final currentUser = _authService.currentUser;
    if (currentUser != null && widget.resultData != null) {
      final now = DateTime.now();
      final testDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);

      await _firestoreService.saveTestResult(
        userId: currentUser.uid,
        leftEyeResult: widget.resultData!['acuity'] ?? '20/40',
        rightEyeResult: widget.resultData!['acuity'] ?? '20/40',
        isRisk: widget.resultData!['isRisk'] ?? true,
        testDate: testDate,
      );
    }
  }

  Future<void> _sendEmailReport() async {
    final currentUser = _authService.currentUser;
    if (currentUser != null && currentUser.email != null && widget.resultData != null) {
      setState(() => _isSendingEmail = true);

      try {
        final now = DateTime.now();
        final testDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);

        await _emailService.sendTestResultEmail(
          recipientEmail: currentUser.email!,
          recipientName: currentUser.displayName ?? 'ผู้ใช้',
          leftEyeResult: widget.resultData!['acuity'] ?? '20/40',
          rightEyeResult: widget.resultData!['acuity'] ?? '20/40',
          isRisk: true,
          testDate: testDate,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ส่งรายงานไปยัง email เรียบร้อยแล้ว')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isSendingEmail = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text(
          'ผลการตรวจ - เสี่ยง',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 80,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'ผลการตรวจ: เสี่ยงสูง',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ทัศนวิสัยของคุณ: ${widget.resultData?['acuity'] ?? '20/40'}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade300, width: 2),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '⚠️ พบความผิดปกติของดวงตา',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${widget.resultData?['details'] ?? 'ตรวจพบความผิดปกติของการมองเห็น'}\n\nแนะนำให้ปรึกษาจักษุแพทย์อย่างเร่งด่วน',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${widget.resultData?['recommendation'] ?? 'ปรึกษาแพทย์ตาอย่างเร่งด่วน'}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.red,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _isSendingEmail ? null : _sendEmailReport,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: _isSendingEmail
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.email),
                      label: Text(
                        _isSendingEmail
                            ? 'กำลังส่ง...'
                            : 'ส่งรายงานไปยัง Email',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                              (route) => false,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.red.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'หน้าหลัก',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/history');
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'ประวัติ',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}