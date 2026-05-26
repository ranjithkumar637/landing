import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RightContent extends StatelessWidget {
  const RightContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: SizedBox(width: constraints.maxWidth, child: _body()),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Mini feature cards ──────────────────────────────
        Row(
          children: [
            Expanded(
              child: _MiniCard(
                icon: Icons.mic_rounded,
                iconColor: const Color(0xFF9F6EF5),
                iconBg: const Color(0xFF2D1060),
                title: 'Personal\nSupport',
                subtitle: 'In-moment guidance',
                accent: const Color(0xFF7C3AED),
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: _MiniCard(
                icon: Icons.person_outline_rounded,
                iconColor: const Color(0xFF93C5FD),
                iconBg: const Color(0xFF0D2448),
                title: 'Personalized\nAwareness',
                subtitle: 'Knows your triggers',
                accent: const Color(0xFF3B82F6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            Expanded(
              child: _MiniCard(
                icon: Icons.bolt_rounded,
                iconColor: const Color(0xFFFBBF24),
                iconBg: const Color(0xFF2D1E00),
                title: 'Trigger\nAwareness',
                subtitle: 'Break the patterns',
                accent: const Color(0xFFF59E0B),
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: _MiniCard(
                icon: Icons.card_giftcard_rounded,
                iconColor: const Color(0xFF6EE7B7),
                iconBg: const Color(0xFF0A2E20),
                title: 'Real-Life\nRewards',
                subtitle: 'Discipline pays off',
                accent: const Color(0xFF10B981),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // ── Waitlist card ───────────────────────────────────
        const _WaitlistCard(),
      ],
    );
  }
}

// ── Mini feature card ─────────────────────────
class _MiniCard extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final Color accent;

  const _MiniCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  @override
  State<_MiniCard> createState() => _MiniCardState();
}

class _MiniCardState extends State<_MiniCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: _hovered
              ? Colors.white.withValues(alpha: 0.07)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered
                ? widget.accent.withValues(alpha: 0.45)
                : Colors.white.withValues(alpha: 0.10),
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.accent.withValues(alpha: 0.10),
                    blurRadius: 24,
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: widget.iconBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: widget.accent.withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: Icon(widget.icon, color: widget.iconColor, size: 19),
            ),
            const SizedBox(height: 11),

            // Title — bright white, clearly readable
            Text(
              widget.title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                height: 1.3,
                letterSpacing: -0.1,
              ),
            ),
            const SizedBox(height: 4),

            // Subtitle — visible secondary text
            Text(
              widget.subtitle,
              style: GoogleFonts.inter(
                color: const Color(0xFF94A3B8),
                fontSize: 11,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Waitlist card ─────────────────────────────
class _WaitlistCard extends StatefulWidget {
  const _WaitlistCard();

  @override
  State<_WaitlistCard> createState() => _WaitlistCardState();
}

class _WaitlistCardState extends State<_WaitlistCard>
    with SingleTickerProviderStateMixin {
  final _ctrl = TextEditingController();
  bool _btnHovered = false;
  bool _submitted = false;
  bool _loading = false;
  String? _emailError;
  late AnimationController _pulse;

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  String? _validate(String email) {
    if (email.isEmpty) return 'Email address is required';
    if (!_emailRegex.hasMatch(email)) return 'Enter a valid email address';
    return null;
  }

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _pulse.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _ctrl.text.trim();
    final error = _validate(email);
    if (error != null) {
      setState(() => _emailError = error);
      return;
    }

    setState(() { _loading = true; _emailError = null; });

    try {
      await Supabase.instance.client
          .from('waitlist')
          .insert({'email': email});
      if (mounted) setState(() { _submitted = true; _loading = false; });
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        final msg = e.toString().contains('duplicate')
            ? 'This email is already on the waitlist!'
            : 'Something went wrong. Please try again.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg, style: const TextStyle(color: Colors.white)),
            backgroundColor: const Color(0xFF7C3AED),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (_, _) => ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF7C3AED).withValues(
                    alpha: 0.22 + _pulse.value * 0.10),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7C3AED).withValues(
                      alpha: 0.05 + _pulse.value * 0.04),
                  blurRadius: 40,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: _submitted ? _success() : _form(),
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: const Color(0xFF7C3AED).withValues(alpha: 0.30),
              width: 1,
            ),
          ),
          child: Text(
            'EARLY ACCESS',
            style: GoogleFonts.inter(
              color: const Color(0xFFA78BFA),
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 12),

        Text(
          'Founding users receive',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            height: 1.2,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 11),

        // Benefits — high-visibility text
        ...[
          ('Lifetime pricing', Icons.local_offer_outlined),
          ('Early feature access', Icons.rocket_launch_outlined),
          ('Direct influence on development', Icons.edit_note_rounded),
        ].map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(e.$2, color: const Color(0xFF9F6EF5), size: 15),
                const SizedBox(width: 9),
                Flexible(
                  child: Text(
                    e.$1,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFCBD5E1),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        // Email input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: _emailError != null
                      ? const Color(0xFFEF4444)
                      : Colors.white.withValues(alpha: 0.10),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _ctrl,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 13.5),
                onChanged: (_) {
                  if (_emailError != null) setState(() => _emailError = null);
                },
                decoration: InputDecoration(
                  hintText: 'Email address',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 13.5,
                  ),
                  prefixIcon: Icon(
                    Icons.mail_outline_rounded,
                    color: _emailError != null
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF566175),
                    size: 18,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onSubmitted: (_) => _submit(),
              ),
            ),
            if (_emailError != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.error_outline_rounded,
                      color: Color(0xFFEF4444), size: 13),
                  const SizedBox(width: 5),
                  Text(
                    _emailError!,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFEF4444),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),

        const SizedBox(height: 10),

        // CTA
        MouseRegion(
          onEnter: (_) => setState(() => _btnHovered = true),
          onExit: (_) => setState(() => _btnHovered = false),
          cursor: _loading
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _loading ? null : _submit,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _loading
                      ? const [Color(0xFF6D28D9), Color(0xFF5B21B6)]
                      : _btnHovered
                          ? const [Color(0xFFB794F4), Color(0xFF7C3AED)]
                          : const [Color(0xFF9F6EF5), Color(0xFF6D28D9)],
                ),
                borderRadius: BorderRadius.circular(11),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C3AED).withValues(
                        alpha: _btnHovered ? 0.55 : 0.32),
                    blurRadius: _btnHovered ? 28 : 16,
                    spreadRadius: -4,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: _loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Join Waitlist',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        Center(
          child: Text(
            'Protect your energy. Protect your future.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _success() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 18),
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [Color(0xFF9F6EF5), Color(0xFF6D28D9)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.50),
                blurRadius: 22,
              ),
            ],
          ),
          child: const Icon(Icons.check_rounded, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 16),
        Text(
          'You\'re on the list.',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We\'ll reach out when\nearly access opens.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF566175),
            fontSize: 13,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
