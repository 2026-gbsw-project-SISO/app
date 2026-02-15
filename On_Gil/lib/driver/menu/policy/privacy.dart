import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EEE9), // 배경색
      appBar: AppBar(
        backgroundColor: const Color(0xFF0EEE9),
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
              title: '개인정보 수집 여부',
              content:
              '본 서비스는 회원가입 및 로그인을 요구하지 않으며,이름, 전화번호, 이메일 등 개인을 식별할 수 있는 정보는 수집하지 않습니다.',
            ),
            SizedBox(height: 20),
            InfoCard(
              title: '개인정보 이용 목적',
              content:
              '수집된 정보는 보행자 및 운전자의 위험 구간 인지 실시간 안전 알림 제공, 위험 상황 분석 및 안내 제공 목적에만 사용됩니다.',
            ),
            SizedBox(height: 20),
            InfoCard(
              title: '개인정보 저장 및 처리 방식',
              content:
              '모든 데이터는 사용자 기기 내부에만 저장되며, \n외부 서버로 전송하거나 제 3자에게 제공하지 않습니다. 앱 삭제 또는 설정을 통해 삭제할 수 있습니다.',
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
    return Container(
      height: 180,
      width: 400,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
