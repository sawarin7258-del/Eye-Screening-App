# Email Configuration Guide

## การตั้งค่า Gmail SMTP

### ขั้นตอนที่ 1: เปิดใช้งาน 2-Step Verification

1. ไปที่ [Google Account](https://myaccount.google.com/)
2. ไปที่ "Security" ทางด้านซ้าย
3. เลื่อนลงหา "2-Step Verification"
4. คลิก "Get started"
5. ทำตามขั้นตอนในการตั้งค่า

### ขั้นตอนที่ 2: สร้าง App Password

1. กลับไปที่ [Google Account Security](https://myaccount.google.com/security)
2. ค้นหา "App passwords" (จะปรากฏเมื่อเปิด 2-Step Verification)
3. เลือก:
   - App: `Mail`
   - Device: `Windows Computer` (หรือตามอุปกรณ์ของคุณ)
4. Google จะให้ password 16 ตัวอักษร

### ขั้นตอนที่ 3: อัพเดท Email Service

แก้ไขไฟล์ `lib/services/email_service.dart`:

```dart
// ก่อน
final smtpServer = mailer.gmail('your-email@gmail.com', 'your-password');

// หลัง
final smtpServer = mailer.gmail(
  'your-email@gmail.com', 
  'xxxx xxxx xxxx xxxx'  // App password 16 ตัว (ไม่ต้องเว้นวรรค)
);
```

### ขั้นตอนที่ 4: ทดสอบ

รัน app และลองส่ง email:

1. สมัครสมาชิกใหม่
2. ทำการตรวจสายตา
3. คลิก "ส่งรายงานไปยัง Email"
4. ตรวจสอบ inbox ของคุณ

## Troubleshooting

### ปัญหา: "Authentication failed"
- ตรวจสอบ 2-Step Verification ว่าเปิดใช้แล้ว
- ตรวจสอบ App Password ว่าถูกต้อง
- ลองสร้าง App Password ใหม่

### ปัญหา: "Connection timeout"
- ตรวจสอบ internet connection
- ลองใช้ VPN ถ้า Gmail ถูกบล็อก
- ตรวจสอบ port 587 ว่าเปิดอยู่

### ปัญหา: "Email not received"
- ตรวจสอบ spam folder
- ตรวจสอบว่า email address ถูกต้อง
- ลองส่ง email อีกครั้ง

## ตัวอย่าง Email Template

```html
<html>
  <body style="font-family: Arial, sans-serif; direction: rtl;">
    <h1 style="color: #1DBFB5;">ผลการตรวจทัศนวิสัย</h1>
    
    <p>สวัสดี [Name],</p>
    
    <h2>ผลการตรวจของคุณ:</h2>
    <table style="border-collapse: collapse; width: 100%;">
      <tr style="background-color: #f0f0f0;">
        <td>ตาซ้าย:</td>
        <td>[Left Eye Result]</td>
      </tr>
      <tr>
        <td>ตาขวา:</td>
        <td>[Right Eye Result]</td>
      </tr>
      <tr>
        <td>สถานะ:</td>
        <td>[Status: Normal or At Risk]</td>
      </tr>
    </table>
    
    <p><strong>วันที่ทดสอบ:</strong> [Test Date]</p>
    
    <p style="color: #666; font-size: 12px;">
      หมายเหตุ: หากคุณมีความเสี่ยง โปรดปรึกษาแพทย์ตาโดยเร็ว
    </p>
  </body>
</html>
```

## Alternative Email Services

### ใช้ SendGrid
```dart
import 'package:sendgrid_email/sendgrid_email.dart';

final sendgrid = SendGridEmail(apiKey: 'YOUR_SENDGRID_API_KEY');
await sendgrid.send(
  to: recipientEmail,
  from: 'noreply@eyescreeningapp.com',
  subject: 'ผลการตรวจทัศนวิสัย',
  html: emailHtml,
);
```

### ใช้ AWS SES
```dart
import 'package:aws_ses/aws_ses.dart';

final ses = SESClient(
  accessKey: 'YOUR_ACCESS_KEY',
  secretKey: 'YOUR_SECRET_KEY',
  region: 'ap-southeast-1',
);
await ses.send(emailRequest);
```

## Security Best Practices

1. **ไม่ใช้ password จริง** - ใช้ App Password แทน
2. **เก็บ secrets ใน environment** - ใช้ .env file
3. **เปิด 2-Step Verification** - เพิ่มความปลอดภัย
4. **ใช้ HTTPS** - สำหรับการส่งข้อมูล
5. **รีวิว Email Content** - หลีกเลี่ยง spam filters

---

สำหรับคำถามหรือปัญหา โปรดติดต่อทีมสนับสนุน
