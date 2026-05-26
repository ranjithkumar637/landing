import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'phone_frame.dart';

const _homeScreen =
    'assets/ChatGPT Image May 26, 2026, 03_52_54 PM.png';
const _journeyScreen =
    'assets/ChatGPT Image May 26, 2026, 03_48_22 PM.png';

class PhoneShowcase extends StatefulWidget {
  const PhoneShowcase({super.key});

  @override
  State<PhoneShowcase> createState() => _PhoneShowcaseState();
}

class _PhoneShowcaseState extends State<PhoneShowcase>
    with SingleTickerProviderStateMixin {
  late AnimationController _float;

  @override
  void initState() {
    super.initState();
    _float = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();
  }

  @override
  void dispose() {
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _float,
      builder: (_, _) {
        final t = _float.value * 2 * math.pi;
        final y1 = math.sin(t) * 10.0;
        final y2 = math.sin(t + math.pi * 0.45) * 8.0;

        return LayoutBuilder(builder: (ctx, constraints) {
          final totalH = constraints.maxHeight;
          final totalW = constraints.maxWidth;

          // Each phone height relative to available space
          final frontH = (totalH * 0.86).clamp(360.0, 640.0);
          final frontW = frontH * (260.0 / 530.0); // ~50.9% aspect
          final backH = frontH * 0.88;
          final backW = backH * (260.0 / 530.0);

          // Gap between the two phones (pixels of empty space at the centre)
          const phoneGap = 14.0;

          return SizedBox(
            width: totalW,
            height: totalH,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // ── Glow pool beneath both phones ─────────────────
                Positioned(
                  bottom: totalH * 0.06,
                  child: Container(
                    width: frontW + backW + phoneGap + 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7C3AED)
                              .withValues(alpha: 0.32),
                          blurRadius: 100,
                          spreadRadius: 40,
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Back phone: Journey (right side) ──────────────
                // left edge starts phoneGap/2 to the right of centre
                Positioned(
                  left: totalW / 2 + phoneGap / 2,
                  child: Transform.translate(
                    offset: Offset(0, y2),
                    child: Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0009)
                        ..rotateY(-0.12)
                        ..rotateZ(0.055),
                      child: Opacity(
                        opacity: 0.90,
                        child: PhoneFrame(
                          width: backW,
                          height: backH,
                          glowColor: const Color(0xFF5B21B6),
                          child: Image.asset(
                            _journeyScreen,
                            width: 390,
                            height: 844,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Front phone: Home (left side) ─────────────────
                // right edge ends phoneGap/2 to the left of centre
                Positioned(
                  right: totalW / 2 + phoneGap / 2,
                  child: Transform.translate(
                    offset: Offset(0, y1),
                    child: Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0009)
                        ..rotateY(0.10)
                        ..rotateZ(-0.048),
                      child: PhoneFrame(
                        width: frontW,
                        height: frontH,
                        glowColor: const Color(0xFF7C3AED),
                        child: Image.asset(
                          _homeScreen,
                          width: 390,
                          height: 844,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
