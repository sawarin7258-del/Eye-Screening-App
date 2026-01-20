import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _imagePicker = ImagePicker();

  // เปิดกล้องและถ่ายรูป
  Future<File?> takePicture() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );

      if (photo != null) {
        return File(photo.path);
      }
      return null;
    } catch (e) {
      throw Exception('Error taking picture: $e');
    }
  }

  // เลือกรูปจากแกลลารี่
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      throw Exception('Error picking image: $e');
    }
  }

  // วิเคราะห์ภาพตา (การจำลองการวิเคราะห์ด้วย AI)
  Future<Map<String, dynamic>> analyzeEyeImage(File imageFile) async {
    try {
      // จำลองการวิเคราะห์ด้วย AI
      // ในการใช้งานจริง จะต้องส่งไปยัง API ที่เป็นจริง
      
      await Future.delayed(const Duration(seconds: 3));

      // สร้างผลลัพธ์แบบสุ่ม
      final isRisk = DateTime.now().millisecond % 3 == 0;
      final acuity = '${20 + (DateTime.now().millisecond % 40)}/20';

      return {
        'acuity': acuity,
        'isRisk': isRisk,
        'details': isRisk
            ? 'ตรวจพบความผิดปกติของการมองเห็น'
            : 'ทัศนวิสัยปกติ',
        'recommendation': isRisk
            ? 'ปรึกษาแพทย์ตาอย่างเร่งด่วน'
            : 'ตรวจสอบปกติทุกปี',
      };
    } catch (e) {
      throw Exception('Error analyzing image: $e');
    }
  }
}
