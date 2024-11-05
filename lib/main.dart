import 'package:flutter/material.dart';
import 'package:gemini/presentation/pages/onboarding_page.dart';
import 'package:gemini/common/theme/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:lightMode,
      darkTheme: darkMode,
      home:const  OnboardingPage(),
    );
  }
}

