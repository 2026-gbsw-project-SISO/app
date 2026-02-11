import 'package:flutter/material.dart';

class Policy extends StatelessWidget {
  const Policy({super.key});

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xFFFFB703);
    const bgColor = Color(0xFFF7F4ED);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'On-Gil',
          style: TextStyle(
            color: mainColor,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Image.asset('SISO.png')
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'On-Gil',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                          fontFamily: 'Inter',

                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'GPS 기반 AI안전 보험·운전 보조 앱',
                        style: TextStyle(fontSize: 13),

                      ),
                      SizedBox(height: 4),
                      Text(
                        '버전 X.X.X',
                        style: TextStyle(fontSize: 12, color: Colors.grey)
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              '앱 정보 및 정책',
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 8),

            _menuItem(
              icon: Icons.lock_outline,
              title: '개인 정보 및 정책',
              onTap: () {},
            ),
            _menuItem(
              icon: Icons.location_on_outlined,
              title: '위치 정보 안내',
              onTap: () {},
            ),
            _menuItem(
              icon: Icons.warning_amber_outlined,
              title: '운전자 책임 고지',
              onTap: () {},
            ),
            _menuItem(
              icon: Icons.notifications_none,
              title: '알림 정확성 안내',
              onTap: () {},
            ),
            _menuItem(
              icon: Icons.description_outlined,
              title: '이용 약관',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  static Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Color(0xFFFFB703)),
          title: Text(title),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }
}
