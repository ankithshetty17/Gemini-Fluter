import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/common/theme/theme_notifier.dart';
import 'package:gemini/presentation/pages/onboarding_page.dart';
import 'package:gemini/common/theme/themes.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(
    ProviderScope(
      child: MyApp()
  )
  );
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:lightMode,
      darkTheme: darkMode,
      themeMode:ThemeMode,
      home: OnboardingPage(),
    );
  }
}

