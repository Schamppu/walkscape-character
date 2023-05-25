import 'package:flutter/material.dart';
import 'package:walkscape_characters/pages/page_intro.dart';
import 'package:walkscape_characters/managers/pfp_manager.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PfpManager().initPfp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalkScape Character Creator',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.light), useMaterial3: true, brightness: Brightness.light),
      darkTheme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark), useMaterial3: true, brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      builder: (context, child) => ResponsiveBreakpoints.builder(child: child!, breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 950, name: TABLET),
        const Breakpoint(start: 951, end: double.infinity, name: DESKTOP),
      ]),
      home: const PageIntro(),
    );
  }
}
