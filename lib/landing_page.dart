import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'widgets/animated_bg.dart';
import 'widgets/top_navbar.dart';
import 'widgets/left_content.dart';
import 'widgets/phone_showcase.dart';
import 'widgets/right_content.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _logUniqueVisit();
  }

  /// Inserts one row into page_views only on the very first visit.
  /// SharedPreferences uses localStorage on web, so the flag
  /// persists across refreshes and return visits in the same browser.
  Future<void> _logUniqueVisit() async {
    final prefs = await SharedPreferences.getInstance();
    final alreadyCounted = prefs.getBool('visit_logged') ?? false;
    if (alreadyCounted) return; // same person — skip

    await Supabase.instance.client.from('page_views').insert({});
    await prefs.setBool('visit_logged', true); // never count again
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF07070F),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            const AnimatedBg(),
            Column(
              children: [
                const TopNavbar(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(44, 0, 44, 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Expanded(flex: 27, child: LeftContent()),
                        SizedBox(width: 24),
                        Expanded(flex: 44, child: PhoneShowcase()),
                        SizedBox(width: 24),
                        Expanded(flex: 29, child: RightContent()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
