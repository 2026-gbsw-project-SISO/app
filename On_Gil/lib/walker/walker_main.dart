import 'package:flutter/material.dart';

class WalkerMain extends StatelessWidget {
  const WalkerMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EEE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0EEE9), // AppBar 배경색
        elevation: 0, // 그림자 없애기
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.black), // 뒤로가기 화살표
          onPressed: () {
            Navigator.pop(context); // 이전 화면으로 돌아가기
          },
        ),
      ),
      body: Center(
        child : Text(
          '보행자',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
