import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

enum DetectionState {
  detectingCrosswalk,
  detectingTrafficLight,
  crosswalkNotFound,
  noTrafficLight,
  redLight,
  greenLight,
}

class PedestrianDetectionPage extends StatefulWidget {
  const PedestrianDetectionPage({super.key});

  @override
  State<PedestrianDetectionPage> createState() =>
      _PedestrianDetectionPageState();
}

class _PedestrianDetectionPageState extends State<PedestrianDetectionPage> {
  DetectionState _state = DetectionState.detectingCrosswalk;
  Timer? _timer;
  bool _detected = false;

  @override
  void initState() {
    super.initState();
    _startCrosswalkDetection();
  }

  void _startCrosswalkDetection() {
    setState(() {
      _state = DetectionState.detectingCrosswalk;
      _detected = false;
    });

    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 10), () {
      if (!_detected) {
        _handleCrosswalkNotFound();
      }
    });


    _fakeCrosswalkDetection();
  }

  void _fakeCrosswalkDetection() async {
    await Future.delayed(const Duration(seconds: 3));

    bool detected = true;

    if (detected) {
      _detected = true;
      _timer?.cancel();
      _handleCrosswalkDetected();
    }
  }

  void _handleCrosswalkDetected() async {
    await _vibrateLong();

    setState(() {
      _state = DetectionState.detectingTrafficLight;
    });

    _startTrafficLightDetection();
  }

  void _handleCrosswalkNotFound() async {
    setState(() {
      _state = DetectionState.crosswalkNotFound;
    });

    await _vibrateShort();
  }

  void _startTrafficLightDetection() {
    _detected = false;

    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 10), () {
      if (!_detected) {
        _handleNoTrafficLight();
      }
    });

    _fakeTrafficLightDetection();
  }

  void _fakeTrafficLightDetection() async {
    await Future.delayed(const Duration(seconds: 3));

    String result = "red";

    _detected = true;
    _timer?.cancel();

    if (result == "red") {
      _handleRedLight();
    } else {
      _handleGreenLight();
    }
  }

  void _handleRedLight() async {
    setState(() {
      _state = DetectionState.redLight;
    });

    await _vibrateRed();
  }

  void _handleGreenLight() async {
    setState(() {
      _state = DetectionState.greenLight;
    });

    await _vibrateGreen();
  }

  void _handleNoTrafficLight() async {
    setState(() {
      _state = DetectionState.noTrafficLight;
    });

    await _vibrateWarning();
  }


  Future<void> _vibrateShort() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 200);
    }
  }

  Future<void> _vibrateLong() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 500);
    }
  }

  Future<void> _vibrateRed() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(pattern: [0, 800, 1000, 800]);
    }
  }

  Future<void> _vibrateGreen() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(pattern: [0, 300, 300, 300, 300, 300]);
    }
  }

  Future<void> _vibrateWarning() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 400);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "On-gil",
          style: TextStyle(
            fontFamily: 'Inter',
            color: Color(0xFFFFC30B),
            fontWeight: FontWeight.w900,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          _getMessage(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getMessage() {
    switch (_state) {
      case DetectionState.detectingCrosswalk:
        return "횡단보도 탐지 중...";
      case DetectionState.crosswalkNotFound:
        return "횡단보도가 감지되지 않았습니다.";
      case DetectionState.detectingTrafficLight:
        return "신호등 탐지 중...";
      case DetectionState.noTrafficLight:
        return "신호등 없는 횡단보도입니다.\n조심히 건너세요.";
      case DetectionState.redLight:
        return "빨간불입니다.\n멈추세요.";
      case DetectionState.greenLight:
        return "초록불입니다.\n건너세요.";
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}