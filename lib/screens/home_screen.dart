import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            _buildMenuCard(
              context,
              icon: Icons.science,
              title: 'เริ่มการตรวจสอบดวงตา',
              color: Colors.cyan.shade100,
              iconColor: Colors.cyan.shade700,
              onTap: () => Navigator.pushNamed(context, '/test-start'),
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              icon: Icons.bar_chart,
              title: 'ประวัติการตรวจสอบ',
              color: Colors.blue.shade100,
              iconColor: Colors.blue.shade700,
              onTap: () => Navigator.pushNamed(context, '/history'),
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              icon: Icons.visibility,
              title: 'ความรู้เรื่องดวงตา',
              color: Colors.indigo.shade100,
              iconColor: Colors.indigo.shade700,
              onTap: () => Navigator.pushNamed(context, '/knowledge'),
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              icon: Icons.settings,
              title: 'ตั้งค่า',
              color: Colors.teal.shade100,
              iconColor: Colors.teal.shade700,
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: iconColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: iconColor, size: 20),
          ],
        ),
      ),
    );
  }
}