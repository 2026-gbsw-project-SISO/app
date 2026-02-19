import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'On-Gil',
          style: TextStyle(
              color: Color(0xFFFFB300),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter'
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: const [
            InfoCard(
              title: '알림 제공 목적',
              content:
              '본 서비스의 알림은 위험 상황에 대한 사전 인지 및 참고용 안내입니다. 알림은 사용자의 판단을 보조하기 위한 정보 제공 목적입니다.',
            ),
            SizedBox(height: 20),
            InfoCard(
              title: '정확성의 한계',
              content:
              '위치 정보, 센서, 네트워크 상태에 따라 알림이 지연되거나 누락될 수 있습니다. 모든 위험 상황을 완전히 감지하거나 안내하지 못할 수 있습니다.',
            ),
            SizedBox(height: 20),
            InfoCard(
              title: '책임 범위',
              content:
              '알림의 유무 또는 정확성과 관계없이 실제 판단과 행동에 대한 책임은 사용자에게 있습니다. 본 서비스는 사고 예방을 보장하지 않습니다.',
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    bool isLightMode = Theme.of(context).brightness == Brightness.light;
    return Container(
      height: 160,
      width: 400,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isLightMode
            ? Colors.white
            : const Color(0xFF1D1D1D),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 7,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFB300),
                fontFamily: 'Inter'
            ),
          ),
          const SizedBox(height: 7),
          Text(
            content,
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFFFB300),
                height: 1.5,
                fontFamily: 'Inter'
            ),
          ),
        ],
      ),
    );
  }
}
