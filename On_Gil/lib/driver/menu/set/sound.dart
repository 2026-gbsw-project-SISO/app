import 'package:flutter/material.dart';
import 'soundservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundSettingPage extends StatefulWidget {
  const SoundSettingPage({super.key});

  @override
  State<SoundSettingPage> createState() => _SoundSettingPageState();
}

class _SoundSettingPageState extends State<SoundSettingPage> {

  final SoundService _soundService = SoundService();

  bool soundEnabled = true;
  bool vibrationEnabled = true;
  double alertDistance = 50;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      soundEnabled = prefs.getBool('soundEnabled') ?? true;
      vibrationEnabled = prefs.getBool('vibrationEnabled') ?? true;
      alertDistance = prefs.getDouble('alertDistance') ?? 50;
    });

    _soundService.setSound(soundEnabled);
    _soundService.setVibration(vibrationEnabled);
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('soundEnabled', soundEnabled);
    await prefs.setBool('vibrationEnabled', vibrationEnabled);
    await prefs.setDouble('alertDistance', alertDistance);
  }

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
          'On-gil',
          style: TextStyle(
            color: Color(0xFFFFB300),
            fontSize: 26,
            fontWeight: FontWeight.w900,
            fontFamily: 'Inter',
          ),
        ),
      ),

      body: Column(
        children: [

          ListTile(
            title: const Text(
              "경고음 사용",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            trailing: Switch(
              value: soundEnabled,
              onChanged: (value) async {
                setState(() {
                  soundEnabled = value;
                  _soundService.setSound(value);
                });
                await _saveSettings();
              },
            ),
          ),

          const SizedBox(height: 30),

          Column(
            children: [
              const Text(
                "경고 거리 설정",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),

              Text(
                "${alertDistance.toInt()} m",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),

              Slider(
                min: 0,
                max: 200,
                divisions: 19,
                value: alertDistance,
                activeColor: const Color(0xFFFFC30B),
                inactiveColor: const Color(0x55FFC30B),
                label: "${alertDistance.toInt()} m",
                onChanged: (value) async {
                  setState(() {
                    alertDistance = value;
                  });
                  await _saveSettings();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
