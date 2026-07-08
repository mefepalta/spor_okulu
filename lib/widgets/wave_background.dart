import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/background_controller.dart';

/// Beyaz zemin üzerine akışkan mavi dalga şeritleri çizen dekoratif arka plan.
///
/// Bir resim (asset) yerine [CustomPaint] kullanır; böylece her ekran boyutuna
/// uyar, keskin kalır ve renkler tek yerden ([AppColors]) yönetilir. İçeriği
/// [child] olarak alır ve dalganın üstüne yerleştirir.
class WaveBackground extends StatefulWidget {
  final Widget child;

  /// Dalga yoğunluğu (0-1). Sade ekranlarda düşük tutulabilir.
  final double intensity;

  const WaveBackground({
    super.key,
    required this.child,
    this.intensity = 1.0,
  });

  @override
  State<WaveBackground> createState() => _WaveBackgroundState();
}

class _WaveBackgroundState extends State<WaveBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _particles = _buildParticles();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    );
    // Partikül animasyonu yalnızca "yüksek" seviyede çalışır; seviye değişince
    // buna göre başlar/durur (düşük/orta seviyede boş yere kare üretmez).
    _syncAnimation();
    BackgroundController.instance.level.addListener(_syncAnimation);
  }

  @override
  void dispose() {
    BackgroundController.instance.level.removeListener(_syncAnimation);
    _controller.dispose();
    super.dispose();
  }

  /// Animasyonu geçerli seviyeyle eşler: yalnızca [BackgroundLevel.full]
  /// partikül gerektirdiğinden diğer seviyelerde denetleyici durdurulur.
  void _syncAnimation() {
    final needsParticles =
        BackgroundController.instance.level.value == BackgroundLevel.full;
    if (needsParticles && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!needsParticles && _controller.isAnimating) {
      _controller.stop();
    }
  }

  /// Determinist (sabit tohumlu) partikül kümesi: doğal görünür ama her
  /// açılışta aynı yerleşimle başlar.
  List<_Particle> _buildParticles() {
    final rnd = math.Random(7);
    return List<_Particle>.generate(26, (_) {
      final radius = 1.2 + rnd.nextDouble() * 2.6;
      return _Particle(
        y: 0.08 + rnd.nextDouble() * 0.84,
        startX: rnd.nextDouble(),
        radius: radius,
        // Küçük partiküller daha hızlı akar (parallax hissi).
        speed: 0.6 + (3.2 - radius) * 0.22 + rnd.nextDouble() * 0.4,
        bob: 0.01 + rnd.nextDouble() * 0.03,
        bobFreq: 0.8 + rnd.nextDouble() * 1.6,
        opacity: 0.35 + rnd.nextDouble() * 0.5,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Seviye tercihi değişince arka plan katmanları anında yeniden kurulur.
    return ValueListenableBuilder<BackgroundLevel>(
      valueListenable: BackgroundController.instance.level,
      builder: (context, level, _) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.surface,
          ),
          child: Stack(
            children: [
              // Statik dalga (orta + yüksek seviyede) — bir kez rasterlenir.
              if (level != BackgroundLevel.none)
                Positioned.fill(
                  child: RepaintBoundary(
                    child: CustomPaint(
                      painter: _WavePainter(
                        intensity: widget.intensity,
                        isDark: isDark,
                      ),
                      isComplex: true,
                      willChange: false,
                    ),
                  ),
                ),
              // Hareketli partikül katmanı (yalnızca yüksek seviye) — her
              // karede çizilen tek katman budur.
              if (level == BackgroundLevel.full)
                Positioned.fill(
                  child: IgnorePointer(
                    child: RepaintBoundary(
                      child: CustomPaint(
                        painter: _ParticlePainter(
                          progress: _controller,
                          particles: _particles,
                          intensity: widget.intensity,
                          isDark: isDark,
                        ),
                      ),
                    ),
                  ),
                ),
              widget.child,
            ],
          ),
        );
      },
    );
  }
}

/// Soldan sağa süzülen tek bir partikülün tanımı (oranlarla; ekran boyutundan
/// bağımsız).
class _Particle {
  final double y;
  final double startX;
  final double radius;
  final double speed;
  final double bob;
  final double bobFreq;
  final double opacity;

  const _Particle({
    required this.y,
    required this.startX,
    required this.radius,
    required this.speed,
    required this.bob,
    required this.bobFreq,
    required this.opacity,
  });
}

class _ParticlePainter extends CustomPainter {
  final Animation<double> progress;
  final List<_Particle> particles;
  final double intensity;
  final bool isDark;

  _ParticlePainter({
    required this.progress,
    required this.particles,
    required this.intensity,
    required this.isDark,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress.value;
    // Koyu zeminde partiküller daha parlak görünsün.
    final scale = isDark ? 1.5 : 1.0;

    for (final p in particles) {
      // Soldan sağa akış; sağ kenardan çıkınca soldan geri girer.
      final x = ((p.startX + t * p.speed) % 1.0) * size.width;
      final y = (p.y +
              p.bob * math.sin((t * p.bobFreq + p.startX) * math.pi * 2)) *
          size.height;
      final center = Offset(x, y);
      final o = (p.opacity * intensity * scale).clamp(0.0, 1.0);

      // Bulanıklık yerine katmanlı daire ile yumuşak parıltı (her kare ucuz).
      canvas.drawCircle(
        center,
        p.radius * 2.6,
        Paint()..color = AppColors.sky.withValues(alpha: o * 0.12),
      );
      canvas.drawCircle(
        center,
        p.radius * 1.6,
        Paint()..color = AppColors.mid.withValues(alpha: o * 0.24),
      );
      canvas.drawCircle(
        center,
        p.radius,
        Paint()..color = AppColors.glow.withValues(alpha: o * 0.8),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}

/// [Scaffold] + [WaveBackground] birleşimi. Ekranlarda tek satırlık
/// `Scaffold` → `WaveScaffold` değişimiyle dalgalı zemini uygular.
///
/// İçerik ekranlarında okunabilirlik için dalga varsayılan olarak biraz daha
/// hafiftir ([intensity]); giriş gibi boş ekranlarda doğrudan [WaveBackground]
/// tam yoğunlukla kullanılabilir.
class WaveScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool? resizeToAvoidBottomInset;
  final double intensity;

  const WaveScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.resizeToAvoidBottomInset,
    this.intensity = 0.55,
  });

  @override
  Widget build(BuildContext context) {
    return WaveBackground(
      intensity: intensity,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        drawer: drawer,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
    );
  }
}

/// Tek bir dalga şeridinin tanımı.
class _Strand {
  final double baseYFactor;
  final double amplitudeFactor;
  final double phase;
  final double freq;
  final double width;
  final double opacity;
  final double blur;

  const _Strand({
    required this.baseYFactor,
    required this.amplitudeFactor,
    required this.phase,
    required this.freq,
    required this.width,
    required this.opacity,
    required this.blur,
  });
}

class _WavePainter extends CustomPainter {
  final double intensity;
  final bool isDark;

  const _WavePainter({required this.intensity, required this.isDark});

  /// Koyu zeminde şeritler daha görünür olmalı; opaklığı yükseltiriz.
  double get _opacityScale => isDark ? 1.7 : 1.0;

  List<Color> get _gradientColors =>
      isDark ? AppColors.waveGradientDark : AppColors.waveGradient;

  // Geniş, yumuşak renk yıkamaları — arka planı maviye boyar.
  static const List<_Strand> _ribbons = <_Strand>[
    _Strand(
      baseYFactor: 0.26,
      amplitudeFactor: 0.11,
      phase: 0.4,
      freq: 1.1,
      width: 0.24,
      opacity: 0.16,
      blur: 42,
    ),
    _Strand(
      baseYFactor: 0.52,
      amplitudeFactor: 0.12,
      phase: 1.5,
      freq: 0.95,
      width: 0.22,
      opacity: 0.14,
      blur: 44,
    ),
    _Strand(
      baseYFactor: 0.76,
      amplitudeFactor: 0.10,
      phase: 2.6,
      freq: 0.9,
      width: 0.28,
      opacity: 0.15,
      blur: 48,
    ),
  ];

  // İnce, parlak şeritler — asıl "dalga" hissini bunlar verir.
  static const List<_Strand> _lines = <_Strand>[
    _Strand(
      baseYFactor: 0.30,
      amplitudeFactor: 0.12,
      phase: 0.0,
      freq: 1.15,
      width: 3.4,
      opacity: 0.60,
      blur: 8,
    ),
    _Strand(
      baseYFactor: 0.36,
      amplitudeFactor: 0.10,
      phase: 0.7,
      freq: 1.3,
      width: 2.2,
      opacity: 0.42,
      blur: 6,
    ),
    _Strand(
      baseYFactor: 0.43,
      amplitudeFactor: 0.13,
      phase: 1.4,
      freq: 1.05,
      width: 2.8,
      opacity: 0.50,
      blur: 7,
    ),
    _Strand(
      baseYFactor: 0.50,
      amplitudeFactor: 0.09,
      phase: 2.0,
      freq: 1.45,
      width: 1.8,
      opacity: 0.36,
      blur: 5,
    ),
    _Strand(
      baseYFactor: 0.58,
      amplitudeFactor: 0.14,
      phase: 2.7,
      freq: 1.0,
      width: 3.6,
      opacity: 0.56,
      blur: 9,
    ),
    _Strand(
      baseYFactor: 0.65,
      amplitudeFactor: 0.10,
      phase: 3.3,
      freq: 1.35,
      width: 2.4,
      opacity: 0.44,
      blur: 6,
    ),
    _Strand(
      baseYFactor: 0.72,
      amplitudeFactor: 0.12,
      phase: 4.0,
      freq: 1.1,
      width: 3.0,
      opacity: 0.50,
      blur: 8,
    ),
    _Strand(
      baseYFactor: 0.80,
      amplitudeFactor: 0.08,
      phase: 4.6,
      freq: 1.5,
      width: 1.6,
      opacity: 0.32,
      blur: 5,
    ),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    for (final s in _ribbons) {
      final path = _wavePath(size, s);
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.height * s.width
          ..strokeCap = StrokeCap.round
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, s.blur)
          ..shader = _blueShader(rect, s.opacity * intensity),
      );
    }

    for (final s in _lines) {
      final path = _wavePath(size, s);

      // Dıştaki bulanık parıltı.
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = s.width * 2.4
          ..strokeCap = StrokeCap.round
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, s.blur)
          ..shader = _blueShader(rect, s.opacity * 0.5 * intensity),
      );

      // İçteki net şerit.
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = s.width
          ..strokeCap = StrokeCap.round
          ..shader = _blueShader(rect, s.opacity * intensity),
      );
    }
  }

  /// Opaklığı doğrudan geçiş renklerine gömer; böylece shader ile alpha
  /// çakışmaz (Paint.color, shader ayarlıyken alpha uygulamaz).
  Shader _blueShader(Rect rect, double opacity) {
    final clamped = (opacity * _opacityScale).clamp(0.0, 1.0);
    return LinearGradient(
      colors: _gradientColors.map((c) => c.withValues(alpha: clamped)).toList(),
    ).createShader(rect);
  }

  /// Sapma için iki harmonik toplayan organik bir dalga eğrisi üretir.
  Path _wavePath(Size size, _Strand s) {
    final baseY = size.height * s.baseYFactor;
    final amplitude = size.height * s.amplitudeFactor;
    final path = Path();
    const steps = 64;

    for (var i = 0; i <= steps; i++) {
      final t = i / steps;
      final x = t * size.width;
      final y = baseY +
          amplitude * math.sin(s.freq * t * math.pi * 2 + s.phase) +
          amplitude *
              0.35 *
              math.sin(s.freq * 1.9 * t * math.pi * 2 + s.phase * 1.4);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    return path;
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) =>
      oldDelegate.intensity != intensity;
}
