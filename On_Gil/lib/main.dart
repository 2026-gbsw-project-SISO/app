import 'package:flutter/material.dart';
import 'package:on_gil/driver/menu/driver_main.dart';
import 'package:on_gil/walker/manu/walker_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';




void main() {
  runApp(const OnGilApp());
}

class OnGilApp extends StatefulWidget {
  const OnGilApp({super.key});

  static _OnGilAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_OnGilAppState>();
  }

  @override
  State<OnGilApp> createState() => _OnGilAppState();
}

class _OnGilAppState extends State<OnGilApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('isDarkMode') ?? false;

    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);

    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: const Color(0xFFF4F2ED),
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF4F2ED),

        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(const Color(0xFFFFC30B)),
          trackColor: MaterialStateProperty.all(const Color(0x55FFC30B)),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFFFFC30B),
            elevation: 3,
            shape: const StadiumBorder(),
          ),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF4F2ED),
          foregroundColor: Color(0xFFFFC30B),
          elevation: 0,
        ),
      ),


      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF292929),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(const Color(0xFFFFC30B)),
          trackColor: MaterialStateProperty.all(const Color(0x55FFC30B)),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF454545),
            foregroundColor: const Color(0xFFFFC30B),
            elevation: 3,
            shape: const StadiumBorder(),
          ),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF292929),
          foregroundColor: Color(0xFFFFC30B),
          elevation: 0,
        ),
      ),

      builder: (context, child) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: child,
        );
      },


      themeMode: _themeMode,
      home: const SymbolPage(),
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

    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;

      await _controller.reverse();

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              const SizedBox(height: 12),
              const Text(
                '본 서비스는 교통 시설을 제어하지 않으며,\n AI 기반 주의 안내만 제공합니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Position? _currentPosition;

  double alertDistance = 50;
  double pedestrianLat = 37.4219983;
  double pedestrianLon = -122.084;

  bool _hasSpoken = false;
  bool soundEnabled = true;

  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadSettings();

    _tts.setLanguage("ko-KR");
    _tts.setSpeechRate(0.5);
    _tts.setVolume(1.0);
    _tts.setPitch(1.0);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      alertDistance = prefs.getDouble('alertDistance') ?? 50;
      soundEnabled = prefs.getBool('soundEnabled') ?? true;

      if (alertDistance < 10) {
        alertDistance = 10;
      }
    });
  }

  Future<void> _initLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Geolocator.getPositionStream().listen((Position position) {
      _currentPosition = position;
      _checkDistance();
    });
  }

  void _checkDistance() {
    if (_currentPosition == null) return;

    double distance = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      pedestrianLat,
      pedestrianLon,
    );

    print("현재 거리: ${distance.toStringAsFixed(2)} m");

    if (distance <= alertDistance) {
      if (!_hasSpoken) {
        _triggerDriverAlert(distance);
        _hasSpoken = true;
      }
    } else {
      _hasSpoken = false;
    }
  }

  Future<void> _triggerDriverAlert(double distance) async {
    print("운전자 경고 실행");

    if (soundEnabled) {
      await _audioPlayer.play(AssetSource('alert.wav'));
    }

    await _tts.stop();
    await _tts.speak(
        "${distance.toStringAsFixed(0)}미터 앞에 보행자가 있습니다. 주의하세요."
    );
  }

  @override
  void dispose() {
    _tts.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            const Text(
              'AI기반 보행•운전 안전 도우미',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFC30B),
                letterSpacing: -2.0,
              ),
            ),
            const SizedBox(height: 15),

            SizedBox(
              width: 250,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  await _initLocation();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DMain(),
                    ),
                  );

                  _loadSettings();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFFFFC30B),
                  backgroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  elevation: 5,
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

            SizedBox(
              width: 250,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WMain(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFFFC30B),
                  elevation: 5,
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