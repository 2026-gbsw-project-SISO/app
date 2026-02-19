import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

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
              title: '서비스 이용 목적 및 범위',
              content:
              '본 서비스는 보행자 및 운전자의 안전을 돕기 위한 위치 기반 위험 안내 서비스입니다. \n서비스는 사용자에게 정보 제공 목적으로만 제공됩니다.',
            ),
            SizedBox(height: 20),
            InfoCard(
              title: '서비스 이용 제한 및 면책',
              content:
              '서비스는 기술적·환경적 요인에 따라 일부 기능이 제한되거나 제공되지 않을 수 있습니다. \n본 서비스는 모든 위험 상황을 감지하거나 사고 예방을 보장하지 않습니다.',
            ),
            SizedBox(height: 20),
            InfoCard(
              title: '책임의 한계',
              content:
              '서비스 이용에 따른 판단 및 행동에 대한 책임은 전적으로 사용자에게 있습니다. \n본 서비스 제공자는 서비스 이용 중 발생한 손해에 대해 법적 책임을 지지 않습니다.',
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
