import 'package:flutter/material.dart';
import 'pages/page.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0f172a),
        scaffoldBackgroundColor: const Color(0xFF0f172a),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFff006e),
        ),
      ),
      home: const InputPage(),
    );
  }
}
