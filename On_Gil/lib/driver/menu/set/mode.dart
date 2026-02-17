import 'package:flutter/material.dart';
import 'package:on_gil/main.dart';



class ModePage extends StatelessWidget {
  const ModePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

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
          'On-Gil',
          style: TextStyle(
              color: Color(0xFFFFB300),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter'
          ),
        ),
      ),
      body: ListTile(
        title: const Text(
            "다크 모드",
          style: TextStyle(
            fontSize: 20,
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
    );
  }
}
