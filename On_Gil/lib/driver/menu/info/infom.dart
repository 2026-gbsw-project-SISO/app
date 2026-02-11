import 'package:flutter/material.dart';
import 'package:on_gil/driver/menu/info/edit/MyInfoEdit.dart';
import 'package:on_gil/driver/menu/info/mycar/Car.dart';


class Infom extends StatelessWidget {
  const Infom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EEE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0EEE9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'On-Gil',
          style: TextStyle(
            color: Color(0xFFFFC107),
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              _menuButton(
                '내 차량 등록',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Car(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              _menuButton(
                '내 정보 수정',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Edit(),
                    ),
                  );
                },

              ),
              const SizedBox(height: 30),

              _menuButton(
                  '이용 요약'
          ),
              const SizedBox(height: 30),

              _menuButton('설정'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuButton(String text, {VoidCallback? onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 62,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFFFFC30B),
          disabledBackgroundColor: Colors.white,
          disabledForegroundColor: const Color(0xFFFFC30B),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
