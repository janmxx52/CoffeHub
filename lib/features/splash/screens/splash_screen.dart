// lib/splash_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../providers/splash_provider.dart';
import '../widgets/coffee_cup_painter.dart';
import '../widgets/steam_animation.dart';
import '../widgets/splash_background.dart';
import '../widgets/get_started_button.dart';
import '../../../core/widgets/app_primary_button.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _steamController;

  late Animation<double> _bgFade;
  late Animation<double> _iconSlide;
  late Animation<double> _titleSlide;
  late Animation<double> _taglineSlide;
  late Animation<double> _ctaSlide;
  late Animation<double> _steam;

  bool _pressed = false;
  bool _entered = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });



    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _steamController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();

    _bgFade = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    _iconSlide = _staggeredSlide(0.00, 0.45);
    _titleSlide = _staggeredSlide(0.20, 0.65);
    _taglineSlide = _staggeredSlide(0.40, 0.80);
    _ctaSlide = _staggeredSlide(0.58, 1.00);

    _steam = CurvedAnimation(parent: _steamController, curve: Curves.easeInOut);

  //   Future<void> initialize(BuildContext context) async {
  //
  //     await Future.delayed(
  //       const Duration(seconds: 2),
  //     );
  //
  //     if(authRepository.isLoggedIn){
  //
  //       Navigator.pushReplacement...
  //
  //     }else{
  //
  //     Navigator.pushReplacement...
  //
  //     }
  //
  //   }
  // }
      Future.delayed(const Duration(milliseconds: 100), () {
        _fadeController.forward();
        _slideController.forward();
       });

  }



Animation<double> _staggeredSlide(double start, double end) =>
      CurvedAnimation(
        parent: _slideController,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      );

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _steamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.espresso,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          SplashBackground(
            animation: _bgFade,
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                _buildCenterContent(),
                const Spacer(flex: 1),
                _buildBottomLabels(),
                const SizedBox(height: 8),
                _buildHomeIndicator(),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          // Steam + cup icon
          _buildAnimated(
            _iconSlide,
            child: SteamAnimation(
              controller: _steamController,
            ),
          ),
          const SizedBox(height: 24),

          // Eyebrow
          _buildAnimated(
            _titleSlide,
            child: Text(
              'PREMIUM COFFEE EXPERIENCE',
              style: AppTextStyles.splashEyebrow,
            ),
          ),
          const SizedBox(height: 14),

          // Brand name
          _buildAnimated(
            _titleSlide,
            child: Column(
              children: [
                Text(
                  'Coffee',
                  style: AppTextStyles.splashCoffee,
                ),
                Text(
                  'Hub',
                  style: AppTextStyles.splashHub,
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          // Ornament
          _buildAnimated(_taglineSlide, child: _buildOrnament()),
          const SizedBox(height: 22),

          // Tagline
          _buildAnimated(
            _taglineSlide,
            child: Text(
              'From highland estates to your hands —\nevery cup a journey worth savoring.',
              textAlign: TextAlign.center,
              style: AppTextStyles.splashTagline,
            ),
          ),
          const SizedBox(height: 36),

          // CTA button
          _buildAnimated(
            _ctaSlide,
            child: AppPrimaryButton(
              text: _entered ? 'WELCOME' : 'GET STARTED',
                onPressed: () async {
                  Navigator.pushReplacementNamed(
                    context,
                    '/home',
                  );
                  await _initialize();
                },

                // TODO:

              isPressed: _pressed,
            ),
          ),

          // //later
          // onPressed: () {
          //
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (_) => const LoginScreen(),
          //     ),
          //   );
          //
          // }

          const SizedBox(height: 20),

          // Sign in link
          _buildAnimated(
            _ctaSlide,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already a member?  ',
                  style: AppTextStyles.splashMember,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Sign in',
                    style: AppTextStyles.splashSignIn,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

   Widget _buildOrnament() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 1,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Color(0xCCC8873A)],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.amber,
            border: Border.all(color: AppColors.amber.withOpacity(0.4), width: 3),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 36,
          height: 1,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xCCC8873A), Colors.transparent],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomLabels() {
    const labels = ['Origin', 'Roast', 'Blend', 'Brew'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.amber.withOpacity(0.1), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: labels
            .map(
              (l) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              l.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 9,
                letterSpacing: 2.5,
                color: AppColors.cream.withOpacity(0.25),
              ),
            ),
          ),
        )
            .toList(),
      ),
    );
  }

  Widget _buildHomeIndicator() {
    return Center(
      child: Container(
        width: 134,
        height: 5,
        decoration: BoxDecoration(
          color: AppColors.cream.withOpacity(0.2),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _buildAnimated(Animation<double> anim, {required Widget child}) {
    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) => Opacity(
        opacity: anim.value,
        child: Transform.translate(
          offset: Offset(0, 28 * (1 - anim.value)),
          child: child,
        ),
      ),
    );
  }

  Future<void> _initialize() async {

    final splashProvider =
    context.read<SplashProvider>();

    final isLogin =
    await splashProvider.initialize();

    if (!mounted) return;

    if (isLogin) {

      Navigator.pushReplacementNamed(
        context,
        '/home',
      );

    } else {

      Navigator.pushReplacementNamed(
        context,
        '/login',
      );

    }
  }
}

// Custom painter for the coffee cup icon
