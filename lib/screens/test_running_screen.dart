import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import '../services/camera_service.dart';

class TestRunningScreen extends StatefulWidget {
  final File? imageFile;

  const TestRunningScreen({super.key, this.imageFile});

  @override
  State<TestRunningScreen> createState() => _TestRunningScreenState();
}

class _TestRunningScreenState extends State<TestRunningScreen> {
  final CameraService _cameraService = CameraService();
  late DateTime _testStartTime;
  late Timer _timer;
  String _currentTime = '';
  int _elapsedSeconds = 0;
  bool _isAnalyzing = true;
  Map<String, dynamic>? _analysisResult;

  @override
  void initState() {
    super.initState();
    _testStartTime = DateTime.now();
    _startTimer();
    _analyzeEye();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedSeconds = DateTime.now().difference(_testStartTime).inSeconds;
          _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
        });
      }
    });
  }

  Future<void> _analyzeEye() async {
    try {
      if (widget.imageFile != null) {
        final result = await _cameraService.analyzeEyeImage(widget.imageFile!);
        if (mounted) {
          setState(() {
            _analysisResult = result;
            _isAnalyzing = false;
          });

          // ไปหน้าผล หลังจากวิเคราะห์เสร็จ
          await Future.delayed(const Duration(seconds: 2));
          if (mounted) {
            Navigator.pushReplacementNamed(
              context,
              _analysisResult!['isRisk']
                  ? '/result-risk'
                  : '/result-normal',
              arguments: _analysisResult,
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isAnalyzing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        title: const Text(
          'กำลังทำการตรวจ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // เวลาปัจจุบัน
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'เวลา',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _currentTime,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            // Loading indicator
            if (_isAnalyzing) ...[
              const CircularProgressIndicator(
                color: Colors.cyan,
                strokeWidth: 4,
              ),
              const SizedBox(height: 32),
              const Text(
                'กำลังวิเคราะห์...',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'เวลาที่ผ่านไป: $_elapsedSeconds วินาที',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ] else ...[
              const Icon(
                Icons.check_circle,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              const Text(
                'วิเคราะห์เสร็จแล้ว',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 48),
            // Test image preview
            if (widget.imageFile != null)
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    widget.imageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}