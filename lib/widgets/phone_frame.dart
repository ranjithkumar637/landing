import 'package:flutter/material.dart';

/// Renders a premium phone frame around [child].
/// [child] should be designed at 390×844 logical pixels (standard iPhone scale).
class PhoneFrame extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color glowColor;

  const PhoneFrame({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.glowColor = const Color(0xFF7C3AED),
  });

  @override
  Widget build(BuildContext context) {
    final radius = width * 0.145;
    final inset = width * 0.038;

    return SizedBox(
      width: width + 6,
      height: height,
      child: Stack(
        children: [
          // Phone body
          Positioned(
            left: 3,
            right: 3,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E1B30), Color(0xFF13101E)],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.11),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: glowColor.withValues(alpha: 0.22),
                    blurRadius: 55,
                    spreadRadius: -8,
                    offset: const Offset(0, 22),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.65),
                    blurRadius: 35,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius - 1),
                child: Stack(
                  children: [
                    // ── Screen content ──────────────────────────────────
                    Positioned(
                      top: inset,
                      left: inset,
                      right: inset,
                      bottom: inset,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(radius - inset - 2),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: 390,
                            height: 844,
                            child: child,
                          ),
                        ),
                      ),
                    ),

                    // ── Dynamic island ──────────────────────────────────
                    Positioned(
                      top: inset + 7,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: width * 0.28,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    // ── Top reflection sheen ────────────────────────────
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: height * 0.38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius - 1),
                            topRight: Radius.circular(radius - 1),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.045),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Volume buttons (left) ──────────────────────────────────────
          Positioned(
            left: 0,
            top: height * 0.22,
            child: _SideBtn(h: 34),
          ),
          Positioned(
            left: 0,
            top: height * 0.22 + 46,
            child: _SideBtn(h: 34),
          ),

          // ── Power button (right) ───────────────────────────────────────
          Positioned(
            right: 0,
            top: height * 0.27,
            child: _SideBtn(h: 56),
          ),
        ],
      ),
    );
  }
}

class _SideBtn extends StatelessWidget {
  final double h;
  const _SideBtn({required this.h});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
