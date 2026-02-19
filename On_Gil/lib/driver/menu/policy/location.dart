import 'package:flutter/material.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

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
              title: '위치 정보 이용 목적',
              content:
              '위치 정보는 보행자 및 운전자의 위험 구간 인지를 위해 사용됩니다. 실시간 안전 알림 및 위험 상황 안내 제공을 목적으로 합니다.',
            ),
            SizedBox(height: 20),
            InfoCard(
              title: '위치 정보 처리 방식',
              content:
              '위치 정보는 실시간으로만 처리되며 장기 저장되지 않습니다. 위치 정보는 사용자 기기 내부에서만 처리됩니다. 외부 서버로 전송되거나 제3자에게 제공되지 않습니다.',
            ),
            SizedBox(height: 20),
            InfoCard(
              title: '정확성 및 제한 사항',
              content:
              'GPS 환경, 네트워크 상태, 주변 환경에 따라 위치 정보의 정확도가 달라질 수 있습니다. 위치 기반 안내는 참고용 정보이며, 실제 판단과 책임은 사용자에게 있습니다.',
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
