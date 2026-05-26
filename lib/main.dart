import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:'https://fmirllhobffliozwcmdj.supabase.co',       // ← paste from Project Settings → API
    anonKey:'sb_publishable_jmxzxtjSWo5mRKXSr2eUMA_mWc4X3tg', // ← paste from Project Settings → API
  );

  runApp(const AscendApp());
}

class AscendApp extends StatelessWidget {
  const AscendApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASCEND — Build The Man You Respect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF07070F),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const LandingPage(),
    );
  }
}
