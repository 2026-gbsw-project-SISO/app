import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const OnGilApp());
}

class OnGilApp extends StatelessWidget {
  const OnGilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SymbolPage(),
    );
  }
}

class SymbolPage extends StatefulWidget {
  const SymbolPage({super.key});

  @override
  State<SymbolPage> createState() => _SymbolPageState();
}

class _SymbolPageState extends State<SymbolPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // 페이드 인/아웃
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward(); // 페이드 인

    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;

      await _controller.reverse();

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EEE9),
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/SISO.png', width: 120),
              const SizedBox(height: 8),
              const Text(
                'On-Gil',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFFFC30B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _playVibration() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EEE9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'On-Gil',
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w900,
                color: Color(0xFFFFC30B),
                letterSpacing: -2.0,
              ),
            ),
            const SizedBox(height: 15),

            // 운전자용 버튼
            SizedBox(
              width: 250,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  _playVibration();
                  print("운전자용 화면으로 이동");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFFFC30B),
                  shape: const StadiumBorder(),
                  elevation: 0,
                ),
                child: const Text(
                  '운전자용',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // 보행자용 버튼
            SizedBox(
              width: 250,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  _playVibration();
                  print("보행자용 화면으로 이동");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC30B),
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  elevation: 0,
                ),
                child: const Text(
                  '보행자용',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
