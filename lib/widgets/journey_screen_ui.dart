import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────
// Journey screen — designed at 390 × 844 px
// ─────────────────────────────────────────────
class JourneyScreenUi extends StatelessWidget {
  const JourneyScreenUi({super.key});

  static const _levels = [
    _Level('AVERAGE', '0 – 20 Days', 'Building awareness and starting your journey.',
        'Self Control', 'You\'re in control.', _LevelTier.active),
    _Level('DISCIPLINED', '21 – 45 Days', 'Discipline becomes your habit.',
        'Clean Mind', 'Mental fog starts to clear.', _LevelTier.current),
    _Level('RELENTLESS', '46 – 90 Days', 'You control your urges, not the other way.',
        'More Energy', 'Feel the real energy within.', _LevelTier.locked),
    _Level('DOMINANT', '91 – 180 Days', 'You don\'t chase pleasure, you chase purpose.',
        'Attraction', 'Your aura changes.', _LevelTier.locked),
    _Level('KING', '181 – 365 Days', 'You\'ve mastered yourself, now you lead yourself.',
        'Respect', 'People notice your presence.', _LevelTier.locked),
    _Level('LEGEND', '365+ Days', 'You\'re a legend. In control. Always.',
        'Freedom', 'True freedom unlocked.', _LevelTier.locked),
  ];

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
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _heroBanner(),
                const SizedBox(height: 14),
                _levelList(),
                const SizedBox(height: 14),
                _howItWorks(),
              ],
            ),
          ),
          _bottomNav(),
        ],
      ),
    );
  }

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
                fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Row(children: [
            const Icon(Icons.signal_cellular_alt,
                color: Colors.white, size: 16),
            const SizedBox(width: 5),
            const Icon(Icons.wifi, color: Colors.white, size: 16),
            const SizedBox(width: 5),
            const Icon(Icons.battery_full, color: Colors.white, size: 18),
          ]),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.menu,
              color: Colors.white.withValues(alpha: 0.7), size: 22),
          const Spacer(),
          Column(children: [
            Text(
              'Journey',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
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
          ]),
          const Spacer(),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.5),
                  width: 1.5),
              gradient: const LinearGradient(
                  colors: [Color(0xFF2A1F40), Color(0xFF1A1430)]),
            ),
            child: const Icon(Icons.person_outline,
                color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _heroBanner() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF13102A), Color(0xFF0E0C1E)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: Colors.white.withValues(alpha: 0.07), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.emoji_events_outlined,
              color: const Color(0xFF9F6EF5), size: 32),
          const SizedBox(width: 14),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.4),
                children: const [
                  TextSpan(
                      text: 'Every level makes you a ',
                      style: TextStyle(color: Color(0xFFCBD5E1))),
                  TextSpan(
                      text: 'stronger',
                      style: TextStyle(color: Color(0xFF9F6EF5))),
                  TextSpan(
                      text: ' man.',
                      style: TextStyle(color: Color(0xFFCBD5E1))),
                ],
              ),
            ),
          ),
          // Silhouette image suggestion
          SizedBox(
            width: 60,
            height: 70,
            child: Stack(alignment: Alignment.center, children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    const Color(0xFF7C3AED).withValues(alpha: 0.4),
                    Colors.transparent,
                  ]),
                ),
              ),
              const Icon(Icons.person, color: Color(0xFFA78BFA), size: 36),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _levelList() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vertical connector line
          Column(
            children: [
              for (int i = 0; i < _levels.length; i++) ...[
                _connectorDot(_levels[i]),
                if (i < _levels.length - 1) _connectorLine(_levels[i]),
              ],
            ],
          ),
          const SizedBox(width: 10),
          // Level cards
          Expanded(
            child: Column(
              children: [
                for (int i = 0; i < _levels.length; i++) ...[
                  _LevelCard(level: _levels[i]),
                  if (i < _levels.length - 1) const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _connectorDot(_Level level) {
    final isCurrent = level.tier == _LevelTier.current;
    final isLocked = level.tier == _LevelTier.locked;

    return Container(
      width: 18,
      height: 18,
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isLocked
            ? const Color(0xFF1A1A2E)
            : isCurrent
                ? const Color(0xFF7C3AED)
                : const Color(0xFF5B21B6).withValues(alpha: 0.5),
        border: Border.all(
          color: isLocked
              ? Colors.white.withValues(alpha: 0.1)
              : const Color(0xFF7C3AED).withValues(alpha: 0.6),
          width: 1.5,
        ),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.6),
                  blurRadius: 8,
                )
              ]
            : [],
      ),
      child: isLocked
          ? const Icon(Icons.lock_outline, color: Color(0xFF475569), size: 10)
          : null,
    );
  }

  Widget _connectorLine(_Level level) {
    final isLocked = level.tier == _LevelTier.locked;
    return Container(
      width: 1.5,
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isLocked
              ? [
                  Colors.white.withValues(alpha: 0.06),
                  Colors.white.withValues(alpha: 0.03),
                ]
              : [
                  const Color(0xFF7C3AED).withValues(alpha: 0.4),
                  const Color(0xFF7C3AED).withValues(alpha: 0.15),
                ],
        ),
      ),
    );
  }

  Widget _howItWorks() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.025),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: Colors.white.withValues(alpha: 0.06), width: 1),
      ),
      child: Column(
        children: [
          Text(
            'HOW IT WORKS',
            style: GoogleFonts.inter(
              color: const Color(0xFF7C3AED),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _howItem(Icons.timer_outlined, 'Urges are normal',
                  'They come.\nYou don\'t have to obey.'),
              _howItem(Icons.trending_up_rounded, 'You resist',
                  'Every time you resist,\nyou level up.'),
              _howItem(Icons.lock_open_outlined, 'Privileges unlock',
                  'The longer you stay\nclean, the more\nyou earn.'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _howItem(IconData icon, String title, String sub) {
    return Column(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.2),
                width: 1),
          ),
          child:
              Icon(icon, color: const Color(0xFF9F6EF5), size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 3),
        Text(
          sub,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              color: const Color(0xFF475569), fontSize: 9, height: 1.5),
        ),
      ],
    );
  }

  Widget _bottomNav() {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: const Color(0xFF0C0C18),
        border: Border(
            top: BorderSide(
                color: Colors.white.withValues(alpha: 0.06), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_rounded, 'Home', false),
          _navItem(Icons.hexagon_outlined, 'Journey', true),
          _addBtn(),
          _navItem(Icons.bar_chart_rounded, 'Insights', false),
          _navItem(Icons.person_outline_rounded, 'Profile', false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool active) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon,
          color:
              active ? const Color(0xFF9F6EF5) : const Color(0xFF566175),
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
    ]);
  }

  Widget _addBtn() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
            colors: [Color(0xFF9F6EF5), Color(0xFF6D28D9)]),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF7C3AED).withValues(alpha: 0.5),
              blurRadius: 14,
              spreadRadius: -2)
        ],
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 26),
    );
  }
}

// ── Level card ────────────────────────────────
class _LevelCard extends StatelessWidget {
  final _Level level;
  const _LevelCard({required this.level});

  @override
  Widget build(BuildContext context) {
    final isLocked = level.tier == _LevelTier.locked;
    final isCurrent = level.tier == _LevelTier.current;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrent
            ? const Color(0xFF15122A)
            : Colors.white.withValues(alpha: 0.025),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: isCurrent
              ? const Color(0xFF7C3AED).withValues(alpha: 0.45)
              : Colors.white.withValues(alpha: 0.065),
          width: 1,
        ),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.08),
                  blurRadius: 20,
                )
              ]
            : [],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isLocked
                  ? const Color(0xFF0F0F1E)
                  : const Color(0xFF1A1035),
              border: Border.all(
                color: isLocked
                    ? Colors.white.withValues(alpha: 0.07)
                    : const Color(0xFF7C3AED).withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: Opacity(
              opacity: isLocked ? 0.4 : 1.0,
              child: Center(child: _levelIcon(level.name)),
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  level.name,
                  style: GoogleFonts.inter(
                    color: isLocked ? const Color(0xFF566175) : Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  level.days,
                  style: GoogleFonts.inter(
                    color: isLocked
                        ? const Color(0xFF3B4560)
                        : const Color(0xFF9F6EF5),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  level.description,
                  style: GoogleFonts.inter(
                    color: isLocked
                        ? const Color(0xFF2D3748)
                        : const Color(0xFF6B7280),
                    fontSize: 10,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          // Privilege unlock
          Container(
            width: 100,
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: isLocked
                  ? Colors.white.withValues(alpha: 0.02)
                  : const Color(0xFF1A1035),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: isLocked
                    ? Colors.white.withValues(alpha: 0.05)
                    : const Color(0xFF7C3AED).withValues(alpha: 0.25),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PRIVILEGES UNLOCKED',
                  style: GoogleFonts.inter(
                    color: isLocked
                        ? const Color(0xFF2D3748)
                        : const Color(0xFF566175),
                    fontSize: 7.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  level.privilege,
                  style: GoogleFonts.inter(
                    color: isLocked
                        ? const Color(0xFF3B4560)
                        : const Color(0xFF9F6EF5),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  level.privilegeDesc,
                  style: GoogleFonts.inter(
                    color: isLocked
                        ? const Color(0xFF1E2840)
                        : const Color(0xFF566175),
                    fontSize: 9,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _levelIcon(String name) {
    switch (name) {
      case 'AVERAGE':
        return const Icon(Icons.person_outline_rounded,
            color: Color(0xFF94A3B8), size: 26);
      case 'DISCIPLINED':
        return const Icon(Icons.shield_outlined,
            color: Color(0xFF9F6EF5), size: 24);
      case 'RELENTLESS':
        return const Icon(Icons.security_rounded,
            color: Color(0xFF7C3AED), size: 24);
      case 'DOMINANT':
        return const Icon(Icons.pets_rounded,
            color: Color(0xFFD97706), size: 24);
      case 'KING':
        return const Icon(Icons.workspace_premium_rounded,
            color: Color(0xFFF59E0B), size: 24);
      case 'LEGEND':
        return const Icon(Icons.auto_awesome_rounded,
            color: Color(0xFFE2E8F0), size: 24);
      default:
        return const Icon(Icons.person_outline,
            color: Color(0xFF566175), size: 24);
    }
  }
}

// ── Data model ────────────────────────────────
enum _LevelTier { active, current, locked }

class _Level {
  final String name, days, description, privilege, privilegeDesc;
  final _LevelTier tier;
  const _Level(this.name, this.days, this.description, this.privilege,
      this.privilegeDesc, this.tier);
}
