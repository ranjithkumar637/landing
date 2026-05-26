import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────
// Home screen — designed at 390 × 844 px
// ─────────────────────────────────────────────
class HomeScreenUi extends StatefulWidget {
  const HomeScreenUi({super.key});
  @override
  State<HomeScreenUi> createState() => _HomeScreenUiState();
}

class _HomeScreenUiState extends State<HomeScreenUi>
    with SingleTickerProviderStateMixin {
  late Timer _clock;
  late AnimationController _pulse;
  int _elapsed = 16 * 3600 + 0 * 60 + 41;

  @override
  void initState() {
    super.initState();
    _clock =
        Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _elapsed++);
    });
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _clock.cancel();
    _pulse.dispose();
    super.dispose();
  }

  String get _timeStr {
    final h = (_elapsed ~/ 3600).toString().padLeft(2, '0');
    final m = ((_elapsed % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (_elapsed % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 844,
      color: const Color(0xFF08080F),
      child: Column(
        children: [
          _statusBar(),
          _topBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _heroSection(),
                const SizedBox(height: 12),
                _badgeCard(),
                const SizedBox(height: 12),
                _streakSection(),
                const SizedBox(height: 12),
                _milestoneCard(),
                const SizedBox(height: 12),
                _statsRow(),
                const SizedBox(height: 12),
                _todayFocus(),
              ],
            ),
          ),
          _bottomNav(),
        ],
      ),
    );
  }

  // ── Status bar ──────────────────────────────
  Widget _statusBar() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
            '9:41',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Icon(Icons.signal_cellular_alt,
                  color: Colors.white, size: 16),
              const SizedBox(width: 5),
              Icon(Icons.wifi, color: Colors.white, size: 16),
              const SizedBox(width: 5),
              Icon(Icons.battery_full, color: Colors.white, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  // ── Top navigation bar ───────────────────────
  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.menu, color: Colors.white.withValues(alpha: 0.7), size: 22),
          const Spacer(),
          Column(
            children: [
              Text(
                'Home',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 28,
                height: 2.5,
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.5),
                width: 1.5,
              ),
              gradient: const LinearGradient(
                colors: [Color(0xFF2A1F40), Color(0xFF1A1430)],
              ),
            ),
            child: const Icon(Icons.person_outline,
                color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  // ── Hero section ────────────────────────────
  Widget _heroSection() {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          // Purple moon glow
          Positioned(
            right: -10,
            top: -20,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF7C3AED).withValues(alpha: 0.55),
                    const Color(0xFF4C1D95).withValues(alpha: 0.25),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          // Warrior silhouette suggestion
          Positioned(
            right: 12,
            top: 8,
            child: Opacity(
              opacity: 0.85,
              child: _WarriorSilhouette(),
            ),
          ),
          // Text
          Positioned(
            left: 0,
            top: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stay in control.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF94A3B8),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Build the man',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.2,
                  ),
                ),
                Text(
                  'you respect.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9F6EF5),
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFF7C3AED),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Keep your future self proud.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF94A3B8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Badge card ───────────────────────────────
  Widget _badgeCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecor(),
      child: Row(
        children: [
          // Badge icon
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1035),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.hexagon_outlined,
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.3),
                    size: 48),
                const Icon(Icons.person, color: Color(0xFFA78BFA), size: 26),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Badge',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7C3AED),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Disciplined',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '680 / 1200 XP',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9F6EF5),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: 680 / 1200,
                    backgroundColor: Colors.white.withValues(alpha: 0.08),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF7C3AED)),
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Text(
                'Next Badge',
                style: GoogleFonts.inter(
                  color: const Color(0xFF566175),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.09),
                    width: 1,
                  ),
                ),
                child: const Icon(Icons.hexagon_outlined,
                    color: Color(0xFF566175), size: 28),
              ),
              const SizedBox(height: 4),
              Text(
                'Relentless',
                style: GoogleFonts.inter(
                  color: const Color(0xFF94A3B8),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Streak section ───────────────────────────
  Widget _streakSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecor(),
      child: Column(
        children: [
          Row(
            children: [
              // Circle timer
              SizedBox(
                width: 155,
                height: 155,
                child: AnimatedBuilder(
                  animation: _pulse,
                  builder: (_, _) {
                    return CustomPaint(
                      painter: _GlowRingPainter(_pulse.value),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'You are on',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF94A3B8),
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Day 14',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              _timeStr,
                              style: GoogleFonts.jetBrainsMono(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF7C3AED),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF7C3AED)
                                            .withValues(alpha: 0.8),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'STREAK RUNNING',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF94A3B8),
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Quote
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '““',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF7C3AED).withValues(alpha: 0.7),
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        height: 0.8,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Every urge you overcome today builds a stronger tomorrow.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFCBD5E1),
                        fontSize: 13,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Voice card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.07),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Feeling an urge?',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Talk and clear your mind.',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF94A3B8),
                          fontSize: 11.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _miniAvatar(const Color(0xFF3B1F6A)),
                          _miniAvatar(const Color(0xFF1F3B6A)),
                          _miniAvatar(const Color(0xFF1F6A3B)),
                          _miniAvatar(const Color(0xFF6A3B1F)),
                          const SizedBox(width: 8),
                          Text(
                            '2.3K  used today',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF566175),
                              fontSize: 10.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [Color(0xFF9F6EF5), Color(0xFF6D28D9)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7C3AED).withValues(alpha: 0.55),
                        blurRadius: 18,
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.mic_rounded,
                      color: Colors.white, size: 26),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniAvatar(Color c) {
    return Transform.translate(
      offset: const Offset(-5, 0),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: c,
          border: Border.all(color: const Color(0xFF111122), width: 1.5),
        ),
        child: const Icon(Icons.person, color: Colors.white, size: 13),
      ),
    );
  }

  // ── Milestone card ───────────────────────────
  Widget _milestoneCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecor(),
      child: Row(
        children: [
          // Image placeholder – sunset scene
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1A1035), Color(0xFF2D1B4E)],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 14,
                  child: Container(
                    width: 40,
                    height: 1.5,
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.5),
                  ),
                ),
                // Sun
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                    ),
                  ),
                ),
                // Tree silhouettes
                Positioned(
                  bottom: 8,
                  left: 10,
                  child: Icon(Icons.park,
                      color: const Color(0xFF1A1035), size: 20),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Icon(Icons.park,
                      color: const Color(0xFF1A1035), size: 24),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next Milestone Reward',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9F6EF5),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Take a Short Trip',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Complete 21 Days',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF566175),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: 14 / 21,
                          backgroundColor:
                              Colors.white.withValues(alpha: 0.08),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF7C3AED)),
                          minHeight: 4,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '14/21',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF566175),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Stats row ────────────────────────────────
  Widget _statsRow() {
    return Row(
      children: [
        Expanded(
            child: _statCard('68%', 'Progress', 'Keep going strong!',
                Icons.track_changes_outlined)),
        const SizedBox(width: 10),
        Expanded(
            child: _statCard('12', 'Urges Resisted', 'Proud of you.',
                Icons.shield_outlined)),
        const SizedBox(width: 10),
        Expanded(
            child: _statCard('7', 'Best Streak', 'days in a row',
                Icons.bar_chart_rounded)),
      ],
    );
  }

  Widget _statCard(
      String val, String label, String sub, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
      decoration: _cardDecor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF7C3AED), size: 18),
          const SizedBox(height: 7),
          Text(
            val,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF94A3B8),
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            sub,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 9.5,
            ),
          ),
        ],
      ),
    );
  }

  // ── Today's Focus ────────────────────────────
  Widget _todayFocus() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: _cardDecor(),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF7C3AED).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.gps_fixed_rounded,
                color: Color(0xFF9F6EF5), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Focus',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9F6EF5),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Protect your energy. Protect your future.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFCBD5E1),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded,
              color: const Color(0xFF566175), size: 20),
        ],
      ),
    );
  }

  // ── Bottom nav ───────────────────────────────
  Widget _bottomNav() {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: const Color(0xFF0C0C18),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_rounded, 'Home', true),
          _navItem(Icons.hexagon_outlined, 'Journey', false),
          _addBtn(),
          _navItem(Icons.bar_chart_rounded, 'Insights', false),
          _navItem(Icons.person_outline_rounded, 'Profile', false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon,
            color: active ? const Color(0xFF9F6EF5) : const Color(0xFF566175),
            size: 22),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            color: active ? const Color(0xFF9F6EF5) : const Color(0xFF566175),
            fontSize: 10,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _addBtn() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF9F6EF5), Color(0xFF6D28D9)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.5),
            blurRadius: 14,
            spreadRadius: -2,
          ),
        ],
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 26),
    );
  }

  BoxDecoration _cardDecor() {
    return BoxDecoration(
      color: const Color(0xFF111120),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.07),
        width: 1,
      ),
    );
  }
}

// ── Warrior silhouette ───────────────────────
class _WarriorSilhouette extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 130,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Outer aura ring
          Positioned(
            top: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF7C3AED).withValues(alpha: 0.45),
                    const Color(0xFF4C1D95).withValues(alpha: 0.20),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),
          // Figure body
          Positioned(
            bottom: 0,
            child: CustomPaint(
              size: const Size(70, 120),
              painter: _FigurePainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FigurePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dark = Paint()
      ..color = const Color(0xFF08070F)
      ..style = PaintingStyle.fill;
    final purplePaint = Paint()
      ..color = const Color(0xFF5B21B6).withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    // Head
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(size.width / 2, 18), width: 28, height: 32),
      dark,
    );
    // Shoulders / cape
    final cape = Path()
      ..moveTo(size.width / 2 - 32, size.height * 0.65)
      ..quadraticBezierTo(
          size.width / 2, size.height * 0.35, size.width / 2 + 32, size.height * 0.65)
      ..lineTo(size.width / 2 + 18, size.height)
      ..lineTo(size.width / 2 - 18, size.height)
      ..close();
    canvas.drawPath(cape, purplePaint);
    canvas.drawPath(cape, dark..color = dark.color.withValues(alpha: 0.5));
    // Torso
    final body = Path()
      ..moveTo(size.width / 2 - 14, size.height * 0.38)
      ..lineTo(size.width / 2 + 14, size.height * 0.38)
      ..lineTo(size.width / 2 + 10, size.height * 0.72)
      ..lineTo(size.width / 2 - 10, size.height * 0.72)
      ..close();
    canvas.drawPath(body, dark..color = const Color(0xFF08070F));
  }

  @override
  bool shouldRepaint(_) => false;
}

// ── Glow ring painter for streak circle ──────
class _GlowRingPainter extends CustomPainter {
  final double pulse;
  _GlowRingPainter(this.pulse);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;

    // Outer glow
    final glowPaint = Paint()
      ..color = const Color(0xFF7C3AED)
          .withValues(alpha: 0.12 + pulse * 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawCircle(center, radius, glowPaint);

    // Track ring
    final trackPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.07)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(center, radius, trackPaint);

    // Progress arc
    final arcPaint = Paint()
      ..shader = const SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: math.pi * 1.5,
        colors: [Color(0xFFA78BFA), Color(0xFF6D28D9)],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * 0.72,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(_GlowRingPainter old) => old.pulse != pulse;
}
