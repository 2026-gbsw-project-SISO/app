import 'package:flutter/material.dart';
import 'package:on_gil/driver/menu/set/mode.dart';

class SetPage extends StatelessWidget {
  const SetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            color: Color(0xFFFFB300),
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),


              _menuButton(
                '알림 설정',
                onTap: () {
                },
              ),
              const SizedBox(height: 30),

              _menuButton(
                '사운드 설정',
                onTap: () {
                },


              ),
              const SizedBox(height: 30),

              _menuButton(
                '모드 전환',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ModePage(),
                    ),
                  );
                },
              ),
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
