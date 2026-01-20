import 'package:flutter/material.dart';

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        title: const Text(
          'Eye Screening App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.cyan.shade50,
              child: const Text(
                'ความรู้เรื่องดวงตา',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKnowledgeCard(
                    icon: Icons.visibility,
                    title: 'การดูแลสุขภาพดวงตา',
                    content:
                        'ดวงตาเป็นอวัยวะที่สำคัญของร่างกาย ควรได้รับการดูแลเป็นพิเศษ การตรวจสุขภาพตาอย่างสม่ำเสมอจะช่วยให้สามารถตรวจพบปัญหาได้ตั้งแต่เนิ่นๆ',
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  _buildKnowledgeCard(
                    icon: Icons.remove_red_eye,
                    title: 'โรคตาที่พบบ่อย',
                    content:
                        'โรคต้อกระจก โรคต้อหิน จอประสาทตาเสื่อม และโรคเบาหวานขึ้นตา เป็นโรคตาที่พบบ่อยและอาจนำไปสู่การสูญเสียการมองเห็นได้',
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  _buildKnowledgeCard(
                    icon: Icons.lightbulb,
                    title: 'คำแนะนำในการดูแล',
                    content:
                        '1. พักสายตาทุก 20 นาที\n2. ใช้แว่นกันแดดเมื่ออยู่กลางแจ้ง\n3. ตรวจสุขภาพตาปีละ 1 ครั้ง\n4. รับประทานอาหารที่มีวิตามินเอ\n5. หลีกเลี่ยงการถูตาบ่อยๆ',
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  _buildKnowledgeCard(
                    icon: Icons.warning,
                    title: 'สัญญาณเตือนที่ต้องพบแพทย์',
                    content:
                        'หากพบอาการเหล่านี้ ควรรีบพบจักษุแพทย์:\n• มองเห็นไม่ชัดเฉียบพลัน\n• เห็นแสงวูบวาบ\n• ปวดตาอย่างรุนแรง\n• ตามองแดงบวม\n• เห็นจุดดำลอยตามสายตา',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKnowledgeCard({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}