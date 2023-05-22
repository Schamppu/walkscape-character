import 'package:flutter/material.dart';
import 'package:walkscape_characters/character_creator.dart';
import 'package:walkscape_characters/pfp_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PfpManager().initPfp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalkScape Character Creator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PageCharacterCreator(title: 'WalkScape Character Creator'),
    );
  }
}
