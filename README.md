# Eye Screening App 👁️

แอปพลิเคชันตรวจสายตาแบบสมบูรณ์ด้วย Flutter กับ Firebase backend

## ✨ ฟีเจอร์หลัก

### 1. 🔐 Authentication
- เข้าสู่ระบบด้วย Email/Password
- สมัครสมาชิกใหม่
- Firebase Authentication

### 2. 📷 Camera Integration
- เปิดกล้องเพื่อถ่ายภาพดวงตา
- เลือกรูปจากแกลลารี่
- บันทึกรูปทั้งบน cloud

### 3. 🔬 Eye Analysis
- วิเคราะห์ภาพดวงตา
- แสดงผลทัศนวิสัย (Visual Acuity)
- ระบุความเสี่ยง

### 4. ⏰ Real-time DateTime
- แสดงเวลาจริงระหว่างการตรวจ
- บันทึกเวลาการตรวจอย่างแม่นยำ

### 5. 📧 Email Report
- ส่งรายงานผลการตรวจไปยัง Email ผู้ใช้
- รายงานเป็น HTML ที่สวยงาม
- ระบุคำแนะนำเพิ่มเติม

### 6. 📊 Firestore Database
- บันทึกประวัติการตรวจ
- Cloud backup อัตโนมัติ
- ค้นหาประวัติได้ง่าย

### 7. 📝 History Tracking
- ดูประวัติการตรวจทั้งหมด
- แสดงผลการตรวจแต่ละครั้ง
- เรียงลำดับตามเวลา

## 🚀 การเริ่มต้นใช้งาน

### Requirements
- Flutter 3.10+
- Dart 3.10+
- Android/iOS/Web browser
- Firebase account

### Installation

1. **Clone repository**
```bash
git clone <repository-url>
cd eye_screening_app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Setup Firebase**
- สร้างโปรเจกต์บน [Firebase Console](https://console.firebase.google.com/)
- ดาวน์โหลด config files
- ตั้งค่า Authentication & Firestore
- อัพเดท `firebase_options.dart`

4. **Setup Email Service**
- สร้าง Gmail App Password
- อัพเดท `lib/services/email_service.dart` ด้วย credentials

5. **Request Permissions**
- เปิดใช้ Camera permissions
- ส่งการอนุญาตในแอป

6. **Run**
```bash
flutter run
```

## 📱 Screen Flows

```
SplashScreen
    ↓
LoginScreen ←→ HomeScreen
    ↓           ↓
    ↓       TestStartScreen
    ↓           ↓
    ↓       TestRunningScreen
    ↓           ↓
    ↓       (Result Screen)
    ↓           ↓
    ↓       ResultNormalScreen / ResultRiskScreen
    ↓           ↓
    ├── HistoryScreen
    └── KnowledgeScreen
```

## 🏗️ Project Structure

```
lib/
├── main.dart                    # Entry point
├── firebase_options.dart        # Firebase config
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── test_start_screen.dart
│   ├── test_running_screen.dart
│   ├── result_normal_screen.dart
│   ├── result_risk_screen.dart
│   ├── history_screen.dart
│   ├── test_error_screen.dart
│   └── knowledge_screen.dart
├── services/
│   ├── auth_service.dart        # Firebase Auth
│   ├── firestore_service.dart   # Database
│   ├── camera_service.dart      # Camera
│   └── email_service.dart       # Email
├── models/
│   └── test_result.dart
```

## 📚 API Services

### AuthService
- `registerWithEmail()` - สมัครสมาชิก
- `loginWithEmail()` - เข้าสู่ระบบ
- `signOut()` - ออกจากระบบ

### FirestoreService
- `saveTestResult()` - บันทึกผล
- `getTestHistory()` - ดึงประวัติ
- `saveUserData()` - บันทึกข้อมูลผู้ใช้

### CameraService
- `takePicture()` - ถ่ายภาพจากกล้อง
- `pickImageFromGallery()` - เลือกรูปจากแกลลารี่
- `analyzeEyeImage()` - วิเคราะห์ภาพ

### EmailService
- `sendTestResultEmail()` - ส่งรายงาน

## 🔧 Configuration

### Firebase Firestore Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
      match /test_results/{resultId} {
        allow read, write: if request.auth.uid == userId;
      }
    }
  }
}
```

## 🐛 Troubleshooting

| ปัญหา | วิธีแก้ |
|-------|--------|
| Firebase not initialized | ตรวจสอบ firebase_options.dart |
| Camera permission denied | ให้ permissions ในการตั้งค่า |
| Email not sending | ตรวจสอบ Gmail app password |
| Firestore timeout | ตรวจสอบ connection & rules |

## 📝 License

This project is licensed under the MIT License.

## 👨‍💻 Developer

Made with ❤️ for eye health awareness

---

สำหรับรายละเอียดเพิ่มเติม ดู [SETUP_GUIDE.md](./SETUP_GUIDE.md)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
