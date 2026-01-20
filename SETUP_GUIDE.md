# Eye Screening App - เอกสารการตั้งค่า

แอปพลิเคชันนี้เป็นแอปตรวจสายตาด้วย Flutter ที่มีฟีเจอร์แบบสมบูรณ์

## ฟีเจอร์หลัก

1. **Authentication ด้วย Email/Password** - เข้าสู่ระบบและสมัครสมาชิกด้วย Firebase Auth
2. **Camera Integration** - ถ่ายภาพดวงตาจากกล้องจริง
3. **Eye Analysis** - วิเคราะห์ภาพดวงตา (การจำลอง)
4. **Real-time DateTime** - แสดงเวลาจริงในการทดสอบ
5. **Email Report** - ส่งรายงานผลการตรวจไปยัง Email
6. **Firestore Database** - บันทึกประวัติการตรวจ
7. **History Tracking** - ดูประวัติการตรวจทั้งหมด

## การติดตั้ง

### 1. ติดตั้ง Dependencies

```bash
flutter pub get
```

### 2. ตั้งค่า Firebase

#### สร้างโปรเจกต์ Firebase
1. ไปที่ [Firebase Console](https://console.firebase.google.com/)
2. สร้างโปรเจกต์ใหม่ชื่อ `eye-screening-app`
3. เปิดใช้งาน Authentication แบบ Email/Password
4. เปิดใช้งาน Firestore Database

#### คัดลอก Firebase Config
1. ไปที่ Project Settings
2. คัดลอก Web API Key
3. ปรับปรุง `lib/firebase_options.dart` ด้วย Firebase credentials

### 3. ตั้งค่า Email (Gmail)

#### สร้าง Gmail App Password
1. ไปที่ Google Account settings
2. เปิด 2-Step Verification
3. สร้าง App Password สำหรับ Gmail
4. ใช้ email และ app password ในไฟล์ `lib/services/email_service.dart`

อัพเดท:
```dart
final smtpServer = mailer.gmail(
  'your-email@gmail.com', 
  'your-app-password'
);
```

### 4. ขอ Permissions

#### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

#### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSCameraUsageDescription</key>
<string>This app uses the camera for eye screening tests.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to your photo library.</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>This app needs to save photos to your photo library.</string>
```

### 5. รัน Application

```bash
flutter run
```

## โครงสร้างโปรเจกต์

```
lib/
├── main.dart                 # Main entry point
├── firebase_options.dart     # Firebase configuration
├── screens/                  # UI Screens
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── test_start_screen.dart
│   ├── test_running_screen.dart
│   ├── result_normal_screen.dart
│   ├── result_risk_screen.dart
│   ├── history_screen.dart
│   └── knowledge_screen.dart
├── services/                 # Business Logic
│   ├── auth_service.dart     # Firebase Authentication
│   ├── camera_service.dart   # Camera & Image Processing
│   ├── firestore_service.dart # Database Operations
│   └── email_service.dart    # Email Service
└── models/                   # Data Models
    └── test_result.dart
```

## Flow การใช้งาน

1. **SplashScreen** → หน้าแรก
2. **LoginScreen** → สมัครสมาชิกหรือเข้าสู่ระบบ
3. **HomeScreen** → เมนูหลัก
4. **TestStartScreen** → เตรียมการตรวจ
5. **TestRunningScreen** → ถ่ายภาพและวิเคราะห์
6. **ResultScreen** → แสดงผล (ปกติ หรือ เสี่ยง)
7. **HistoryScreen** → ดูประวัติทั้งหมด

## การใช้งาน

### สมัครสมาชิก
1. กด "สร้างบัญชี"
2. กรอก Email, ชื่อ-นามสกุล, รหัสผ่าน
3. กด "สร้างบัญชี"

### เข้าสู่ระบบ
1. กรอก Email และ รหัสผ่าน
2. กด "เข้าสู่ระบบ"

### ทำการตรวจ
1. จากหน้าหลัก กด "เริ่มตรวจสายตา"
2. กด "เริ่มการตรวจ"
3. อนุญาตการใช้กล้อง
4. ถ่ายภาพดวงตา
5. รอการวิเคราะห์
6. ดูผลการตรวจ

### ดูประวัติ
1. กด "ประวัติการตรวจ"
2. ดูรายการการตรวจทั้งหมด
3. ดูรายละเอียดของแต่ละครั้ง

### ส่งรายงาน
1. จากหน้าผลการตรวจ
2. กด "ส่งรายงานไปยัง Email"
3. รอจนกว่าส่งเสร็จ

## Troubleshooting

### ปัญหา: "Firebase not initialized"
**วิธีแก้**: ตรวจสอบว่า `firebase_options.dart` มี credentials ที่ถูกต้อง

### ปัญหา: "Camera permission denied"
**วิธีแก้**: ให้ permissions ในการตั้งค่าโทรศัพท์

### ปัญหา: "Email not sending"
**วิธีแก้**: 
- ตรวจสอบ Gmail app password
- เปิดใช้ "Less secure app access"
- ตรวจสอบ internet connection

### ปัญหา: "Firestore read timeout"
**วิธีแก้**: 
- ตรวจสอบ Firebase project credentials
- ตรวจสอบ Firestore rules ให้ allow read/write

## Notes

- ผลการวิเคราะห์ปัจจุบันเป็นการจำลอง (simulation) สำหรับการทดสอบ
- ในการใช้งานจริง ต้องอินทิเกรต AI/ML API ที่แท้จริง
- Email service ใช้ Gmail SMTP สำหรับส่งอีเมล
- ข้อมูลจะถูกบันทึกใน Firestore ตามเวลาจริง

## ติดต่อ

สำหรับปัญหาหรือข้อเสนอแนะ โปรดติดต่อทีมพัฒนา
