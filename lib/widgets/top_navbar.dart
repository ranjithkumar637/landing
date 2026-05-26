import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopNavbar extends StatelessWidget {
  const TopNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF07070F).withValues(alpha: 0.45),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.04),
                width: 1,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Row(
            children: [
              // Subtle dot mark — no text name
              _DotMark(),
              const Spacer(),
              const _JoinButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// Small decorative accent — no brand name, just a visual anchor
class _DotMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF7C3AED),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.7),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF7C3AED).withValues(alpha: 0.35),
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF7C3AED).withValues(alpha: 0.15),
          ),
        ),
      ],
    );
  }
}

class _JoinButton extends StatefulWidget {
  const _JoinButton();

  @override
  State<_JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<_JoinButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _hovered
                ? const [Color(0xFFB794F4), Color(0xFF7C3AED)]
                : const [Color(0xFF9F6EF5), Color(0xFF6D28D9)],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C3AED)
                  .withValues(alpha: _hovered ? 0.60 : 0.35),
              blurRadius: _hovered ? 30 : 18,
              spreadRadius: -4,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Text(
          'Join Waitlist',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
