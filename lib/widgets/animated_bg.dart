import 'package:flutter/material.dart';
import 'dart:math' as math;

class _Particle {
  final double x, y, size, opacity;
  const _Particle(this.x, this.y, this.size, this.opacity);
}

class AnimatedBg extends StatefulWidget {
  const AnimatedBg({super.key});
  @override
  State<AnimatedBg> createState() => _AnimatedBgState();
}

class _AnimatedBgState extends State<AnimatedBg>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
    final rng = math.Random(42);
    _particles = List.generate(
      75,
      (_) => _Particle(
        rng.nextDouble(),
        rng.nextDouble(),
        rng.nextDouble() * 1.8 + 0.4,
        rng.nextDouble() * 0.045 + 0.008,
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sz = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, _) {
        final t = _ctrl.value * 2 * math.pi;
        return SizedBox.expand(
          child: Stack(
            children: [
              // Base gradient – very dark purple-black
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0A0617),
                      Color(0xFF07070F),
                      Color(0xFF050510),
                    ],
                    stops: [0.0, 0.55, 1.0],
                  ),
                ),
              ),

              // Blob 1 – large purple, left-mid
              Positioned(
                left: -140 + 30 * math.sin(t * 0.55),
                top: 60 + 50 * math.cos(t * 0.38),
                child: _blob(480, const Color(0xFF7C3AED), 0.09),
              ),

              // Blob 2 – deep violet, center-top
              Positioned(
                left: sz.width * 0.38 + 25 * math.cos(t * 0.47),
                top: -90 + 35 * math.sin(t * 0.62),
                child: _blob(380, const Color(0xFF5B21B6), 0.11),
              ),

              // Blob 3 – blue-purple, right-bottom
              Positioned(
                right: -110 + 22 * math.sin(t * 0.70),
                bottom: 80 + 38 * math.cos(t * 0.44),
                child: _blob(420, const Color(0xFF4C1D95), 0.08),
              ),

              // Blob 4 – tiny bright accent, center
              Positioned(
                left: sz.width * 0.5 + 15 * math.cos(t * 0.9),
                top: sz.height * 0.45 + 20 * math.sin(t * 0.75),
                child: _blob(160, const Color(0xFF8B5CF6), 0.06),
              ),

              // Static star particles
              for (final p in _particles)
                Positioned(
                  left: p.x * sz.width,
                  top: p.y * sz.height,
                  child: Container(
                    width: p.size,
                    height: p.size,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: p.opacity),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _blob(double size, Color color, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: opacity), color.withValues(alpha: 0.0)],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}
