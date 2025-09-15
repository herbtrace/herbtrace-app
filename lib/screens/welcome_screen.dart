import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herbtrace_app/screens/common/auth/auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(painter: GridPainter(), size: Size.infinite),

          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AnimatedWelcomeText(),
                  const SizedBox(height: 20),

                  Text(
                    'HerbTrace',
                    style: GoogleFonts.montserrat(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 40),

                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 60),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const AnimatedStartText(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedWelcomeText extends StatefulWidget {
  const AnimatedWelcomeText({super.key});

  @override
  State<AnimatedWelcomeText> createState() => _AnimatedWelcomeTextState();
}

class _AnimatedWelcomeTextState extends State<AnimatedWelcomeText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  int _currentIndex = 0;

  final List<Map<String, String>> _welcomeMessages = [
    {'text': 'Welcome to', 'language': 'English'},
    {'text': 'आपका स्वागत है', 'language': 'Hindi'},
    {'text': 'ಸ್ವಾಗತ', 'language': 'Kannada'},
    {'text': 'स्वागतम्', 'language': 'Sanskrit'},
    {'text': 'സ്വാഗതം', 'language': 'Malayalam'},
    {'text': 'வரவேற்பு', 'language': 'Tamil'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            _controller.reverse().then((_) {
              if (mounted) {
                setState(() {
                  _currentIndex = (_currentIndex + 1) % _welcomeMessages.length;
                });
                _controller.forward();
              }
            });
          }
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            _welcomeMessages[_currentIndex]['text']!,
            style: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2E7D32),
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 4),
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            '(${_welcomeMessages[_currentIndex]['language']})',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedStartText extends StatefulWidget {
  const AnimatedStartText({super.key});

  @override
  State<AnimatedStartText> createState() => _AnimatedStartTextState();
}

class _AnimatedStartTextState extends State<AnimatedStartText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  int _currentIndex = 0;

  final List<Map<String, String>> _startMessages = [
    {'text': 'Start Journey', 'language': 'English'},
    {'text': 'यात्रा शुरू करें', 'language': 'Hindi'},
    {'text': 'ಪ್ರಯಾಣ ಪ್ರಾರಂಭಿಸಿ', 'language': 'Kannada'},
    {'text': 'यात्रा आरभ्यताम्', 'language': 'Sanskrit'},
    {'text': 'യാത്ര ആരംഭിക്കുക', 'language': 'Malayalam'},
    {'text': 'பயணத்தைத் தொடங்கு', 'language': 'Tamil'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            _controller.reverse().then((_) {
              if (mounted) {
                setState(() {
                  _currentIndex = (_currentIndex + 1) % _startMessages.length;
                });
                _controller.forward();
              }
            });
          }
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Text(
        _startMessages[_currentIndex]['text']!,
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.1)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (double i = 0; i <= size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i <= size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    final circlePaint = Paint()
      ..color = Colors.green.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    for (double x = 0; x <= size.width; x += 30) {
      for (double y = 0; y <= size.height; y += 30) {
        canvas.drawCircle(Offset(x, y), 2, circlePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
