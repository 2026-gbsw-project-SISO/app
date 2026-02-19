import 'package:flutter/material.dart';

class driverPage extends StatelessWidget {
  const driverPage({super.key});

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
              title: '서비스 성격',
              content:
              '본 서비스는 기존 교통 신호, 도로 시설, 횡단보도 등을 관리하거나 제어하지 않습니다. AI 기반 위험 인지 및 안내를 제공하는 운전자 보조 시스템입니다.',
            ),
            SizedBox(height: 20),
            InfoCard(
              title: '운전 책임 주체',
              content:
              '실제 운전 판단과 차량 조작에 대한 모든 책임은 운전자 본인에게 있습니다. 본 서비스의 안내는 운전자의 판단을 대체하지 않습니다.',
            ),
            SizedBox(height: 20),
            InfoCard(
              title: '시스템 한계 및 면책',
              content:
              'GPS 오류, 인식 지연, 환경 요인 등으로 인해 안내가 지연되거나 부정확할 수 있습니다. 서비스 이용 중 발생하는 상황에 대해 최종 책임은 사용자에게 있습니다.',
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
      height: 180,
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
