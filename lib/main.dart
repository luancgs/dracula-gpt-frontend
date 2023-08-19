import 'package:dracula_gpt/src/interface/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DraculaGPT());
}

class DraculaGPT extends StatelessWidget {
  const DraculaGPT({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dracula GPT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Dracula GPT'),
    );
  }
}
