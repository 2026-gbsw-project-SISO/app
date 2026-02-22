import 'package:flutter/material.dart';
import 'package:on_gil/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final double initialIntensity;

  const SettingsPage({super.key, required this.initialIntensity});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late double _intensity;

  @override
  void initState() {
    super.initState();
    _intensity = widget.initialIntensity;
    _loadSavedIntensity();
  }

  Future<void> _loadSavedIntensity() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _intensity = prefs.getDouble('vibration_intensity') ?? widget.initialIntensity;
    });
  }

  Future<void> _saveIntensity() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('vibration_intensity', _intensity);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "On-gil",
          style: TextStyle(
            color: Color(0xFFFFC107),
            fontWeight: FontWeight.w900,
            fontFamily: 'Inter',
            fontSize: 26,
          ),
        ),
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "다크 모드",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              trailing: Switch(
                value: isDark,
                onChanged: (value) {
                  OnGilApp.of(context)?.toggleTheme(value);
                },
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "진동 세기 조절",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 30),

            Slider(
              value: _intensity,
              min: 0.2,
              max: 1.0,
              divisions: 4,
              label: _intensity.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _intensity = value;
                });
              },
            ),

            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _saveIntensity();
                  Navigator.pop(context, _intensity);
                },
                child: const Text(
                  "저장",
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