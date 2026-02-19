import 'package:flutter/material.dart';
import 'package:on_gil/driver/menu/policy/Notification.dart';
import 'package:on_gil/driver/menu/policy/driver_policy.dart';
import 'package:on_gil/driver/menu/policy/location.dart';
import 'package:on_gil/driver/menu/policy/privacy.dart';
import 'package:on_gil/driver/menu/policy/terms.dart';
import 'package:package_info_plus/package_info_plus.dart';


class Policy extends StatefulWidget {
  const Policy({super.key});

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = info.version;
    });
  }


  @override
  Widget build(BuildContext context) {
    bool isLightMode = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'On-Gil',
          style: TextStyle(
            color: Color(0xFFFFB703),
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
                color: isLightMode
                    ? Colors.white
                    : const Color(0xFF1D1D1D),                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 7,
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
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Image.asset('assets/smallSISO.png')
                    ),
                  ),

                  const SizedBox(width: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'On-Gil',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFB703),
                          fontFamily: 'Inter',

                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'GPS 기반 AI안전 보험·운전 보조 앱',
                        style: TextStyle(
                            fontSize: 13,
                        ),

                      ),
                      SizedBox(height: 4),
                      Text(
                          '버전 $appVersion',
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
                color: Color(0xFFFFB703),
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 8),

            _menuItem(
              icon: Icons.lock_outline,
              title: '개인 정보 및 정책',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPage(),
                  ),
                );
              },
            ),
            _menuItem(
              icon: Icons.location_on_outlined,
              title: '위치 정보 안내',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationPage(),
                  ),
                );
              },
            ),
            _menuItem(
              icon: Icons.warning_amber_outlined,
              title: '운전자 책임 고지',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const driverPage(),
                  ),
                );
              },
            ),
            _menuItem(
              icon: Icons.notifications_none,
              title: '알림 정확성 안내',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationPage(),
                  ),
                );
              },
            ),
            _menuItem(
              icon: Icons.description_outlined,
              title: '이용 약관',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TermsPage(),
                  ),
                );
              },
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
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            )

          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }
}
