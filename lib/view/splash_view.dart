import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap_movies/app_routes.dart';
import 'package:tap_movies/controller/theme_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  // Background orbs
  late final Animation<double> _bgFade;

  // Logo
  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;

  // Pulse ring
  late final Animation<double> _ringScale;
  late final Animation<double> _ringOpacity;

  // Title
  late final Animation<double> _titleSlide;
  late final Animation<double> _titleFade;

  // Tagline
  late final Animation<double> _tagFade;

  // Progress bar
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    _bgFade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.35, curve: Curves.easeIn),
    );

    _logoScale = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.1, 0.45, curve: Curves.elasticOut),
      ),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.1, 0.38, curve: Curves.easeIn),
      ),
    );

    _ringScale = Tween<double>(begin: 1.0, end: 1.55).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.35, 0.65, curve: Curves.easeOut),
      ),
    );

    _ringOpacity = Tween<double>(begin: 0.7, end: 0.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.35, 0.65, curve: Curves.easeOut),
      ),
    );

    _titleSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.42, 0.65, curve: Curves.easeOut),
      ),
    );

    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.42, 0.62, curve: Curves.easeIn),
      ),
    );

    _tagFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.60, 0.78, curve: Curves.easeIn),
      ),
    );

    _progress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.62, 1.0, curve: Curves.easeInOut),
      ),
    );

    _ctrl.forward().then((_) {
      if (mounted) Get.offAllNamed(AppRoutes.home);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, _) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            // Deep cinematic background
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.navy,
                  Color(0xFF071B3D),
                  Color(0xFF03091A),
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ── Glow orb top-right ──────────────────────────────────
                Positioned(
                  top: -size.height * 0.08,
                  right: -size.width * 0.15,
                  child: Opacity(
                    opacity: _bgFade.value * 0.55,
                    child: Container(
                      width: size.width * 0.75,
                      height: size.width * 0.75,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.blue.withOpacity(0.45),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Glow orb bottom-left ─────────────────────────────────
                Positioned(
                  bottom: -size.height * 0.1,
                  left: -size.width * 0.2,
                  child: Opacity(
                    opacity: _bgFade.value * 0.40,
                    child: Container(
                      width: size.width * 0.85,
                      height: size.width * 0.85,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.amber.withOpacity(0.30),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Center content ───────────────────────────────────────
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Pulse ring + logo
                    SizedBox(
                      width: 160,
                      height: 160,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Expanding ring
                          Transform.scale(
                            scale: _ringScale.value,
                            child: Opacity(
                              opacity: _ringOpacity.value,
                              child: Container(
                                width: 136,
                                height: 136,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.blueLight,
                                    width: 2.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Logo
                          Transform.scale(
                            scale: _logoScale.value,
                            child: Opacity(
                              opacity: _logoFade.value,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.blue.withOpacity(0.5),
                                      blurRadius: 32,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // App name
                    Transform.translate(
                      offset: Offset(0, _titleSlide.value),
                      child: Opacity(
                        opacity: _titleFade.value,
                        child: const Text(
                          'TAP MOVIES',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Tagline
                    Opacity(
                      opacity: _tagFade.value,
                      child: Text(
                        'Discover your next favourite film',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 13,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    const SizedBox(height: 56),

                    // Progress bar
                    Opacity(
                      opacity: _tagFade.value,
                      child: SizedBox(
                        width: 140,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: _progress.value,
                            minHeight: 3,
                            backgroundColor: Colors.white.withOpacity(0.12),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.blueLight,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
