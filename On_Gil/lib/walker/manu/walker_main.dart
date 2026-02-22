import 'package:flutter/material.dart';
import 'package:on_gil/walker/walk/walk.dart';
import 'package:on_gil/walker/setting/setting.dart';

class WMain extends StatelessWidget {
  const WMain({super.key});

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
            color: Color(0xFFFFC107),
            fontWeight: FontWeight.w900,
            fontFamily: 'Inter',
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

              _menuButton(
                context,
                '횡단보도 도보',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PedestrianDetectionPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              _menuButton(
                context,
                '설정',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(
                        initialIntensity: 0.5,
                      ),
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

  Widget _menuButton(BuildContext context, String text,
      {VoidCallback? onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 90,
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
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
