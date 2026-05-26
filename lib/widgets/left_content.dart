import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeftContent extends StatelessWidget {
  const LeftContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: SizedBox(width: constraints.maxWidth, child: _body()),
      ),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _LabelPill(),
        const SizedBox(height: 18),
        _MainHeading(),
        const SizedBox(height: 18),
        _SubText(),
        const SizedBox(height: 26),

        // ── Personal Support — the MAIN pitch ────────────────
        _VoiceHeroCard(),

        const SizedBox(height: 10),

        // ── Supporting features ───────────────────────────────
        _FeatureCard(
          icon: Icons.bolt_rounded,
          title: 'Trigger Awareness',
          desc:
              'Learns your trigger patterns, emotional states, and dangerous timings so support always feels personal.',
        ),
        const SizedBox(height: 8),
        _FeatureCard(
          icon: Icons.trending_up_rounded,
          title: 'Progression System',
          desc:
              'Average → Disciplined → Relentless → Dominant → Legend. Every day you hold, you evolve.',
        ),
        const SizedBox(height: 8),
        _FeatureCard(
          icon: Icons.shield_outlined,
          title: 'Growth Over Shame',
          desc:
              'One slip doesn\'t reset everything. Progress is tracked forward, not punished backward.',
        ),
      ],
    );
  }
}

// ── Label pill ────────────────────────────────
class _LabelPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF7C3AED).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: const Color(0xFF7C3AED).withValues(alpha: 0.28),
          width: 1,
        ),
      ),
      child: Text(
        'DISCIPLINE  ·  CONTROL  ·  AWARENESS',
        style: GoogleFonts.inter(
          color: const Color(0xFFA78BFA),
          fontSize: 9.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

// ── Main heading ──────────────────────────────
class _MainHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = GoogleFonts.inter(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.w800,
      height: 1.28,
      letterSpacing: -0.8,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Most people don\'t fail', style: s),
        Text('because they\'re weak.', style: s),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'They fight urges ',
              style: s.copyWith(color: const Color(0xFF6B7280)),
            ),
            TextSpan(
              text: 'alone.',
              style: s.copyWith(
                color: const Color(0xFFA78BFA),
                shadows: [
                  Shadow(
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.90),
                    blurRadius: 18,
                  ),
                  Shadow(
                    color: const Color(0xFFA78BFA).withValues(alpha: 0.55),
                    blurRadius: 42,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

// ── Sub-text ──────────────────────────────────
class _SubText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Most recovery apps only count streaks after relapse.',
          style: GoogleFonts.inter(
            color: const Color(0xFF94A3B8),
            fontSize: 13,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          'The hardest moment is when urges hit, emotions take over,\nand the mind goes on autopilot.',
          style: GoogleFonts.inter(
            color: const Color(0xFF566175),
            fontSize: 13,
            height: 1.65,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          'This app focuses on awareness, recovery, and real control.',
          style: GoogleFonts.inter(
            color: const Color(0xFF6D5A8A),
            fontSize: 13,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ── Voice hero card — main pitch ─────────────
class _VoiceHeroCard extends StatefulWidget {
  @override
  State<_VoiceHeroCard> createState() => _VoiceHeroCardState();
}

class _VoiceHeroCardState extends State<_VoiceHeroCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (_, _) => AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _hovered
                  ? [
                      const Color(0xFF1E1040),
                      const Color(0xFF150C30),
                    ]
                  : [
                      const Color(0xFF160D35),
                      const Color(0xFF100928),
                    ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFF7C3AED).withValues(
                  alpha: 0.32 + _pulse.value * 0.14),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C3AED).withValues(
                    alpha: 0.10 + _pulse.value * 0.06),
                blurRadius: 28,
                spreadRadius: -4,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mic icon with glow ring
              AnimatedBuilder(
                animation: _pulse,
                builder: (_, _) => Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [Color(0xFF9F6EF5), Color(0xFF6D28D9)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7C3AED).withValues(
                            alpha: 0.40 + _pulse.value * 0.20),
                        blurRadius: 18 + _pulse.value * 8,
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.mic_rounded,
                      color: Colors.white, size: 24),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Personal Support',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7C3AED)
                                .withValues(alpha: 0.20),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: const Color(0xFF7C3AED)
                                  .withValues(alpha: 0.35),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'CORE FEATURE',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFA78BFA),
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'When urges hit, you don\'t read quotes.\nYou open the app and talk.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFCBD5E1),
                        fontSize: 13,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'A support system that understands your emotional state in that exact moment — calms impulsive thinking, redirects your focus, and helps you regain control without judgment.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF7A8599),
                        fontSize: 11.5,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Social proof strip
                    Wrap(
                      spacing: 14,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _dot(),
                            const SizedBox(width: 6),
                            Text(
                              'Calms impulsive thinking',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9F6EF5),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _dot(),
                            const SizedBox(width: 6),
                            Text(
                              'Redirects focus',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9F6EF5),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _dot(),
                            const SizedBox(width: 6),
                            Text(
                              'Breaks the loop',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9F6EF5),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot() {
    return Container(
      width: 5,
      height: 5,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF7C3AED),
      ),
    );
  }
}

// ── Supporting feature card ───────────────────
class _FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
        decoration: BoxDecoration(
          color: _hovered
              ? Colors.white.withValues(alpha: 0.055)
              : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered
                ? const Color(0xFF7C3AED).withValues(alpha: 0.38)
                : Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.22),
                  width: 1,
                ),
              ),
              child: Icon(widget.icon,
                  color: const Color(0xFFA78BFA), size: 16),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.desc,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF8A9AB5),
                      fontSize: 11.5,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
