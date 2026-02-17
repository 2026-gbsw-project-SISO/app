import 'package:flutter/material.dart';

class Bground extends StatelessWidget {
  const Bground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'On-Gil',
          style: TextStyle(
            color: Color(0xFFFFC107),
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 27,
          ),
        ),
        centerTitle: true,
      ),
        body: Center(
          child: Transform.translate(
            offset: const Offset(0, -40),
            child: Container(
          width: 260,
          height: 130,
          decoration: BoxDecoration(
            color: const Color(0xFFFFC107),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 7,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.volume_up, size: 35, color: Colors.black),
              SizedBox(height: 8),
              Text(
                '백그라운드 재생 중',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
        ),
    );
  }
}
