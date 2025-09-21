import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herbtrace_app/screens/common/home_screen.dart';
import '../../../services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final _authService = AuthService();

  bool _isEmail = false;
  bool _isValid = false;
  bool _isLoading = false;
  bool _showOTP = false;
  String? _errorText;

  Timer? _timer;
  int _timerSeconds = 120;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAuth();
    _idController.addListener(_validateInput);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  Future<void> _initializeAuth() async {
    try {
      await _authService.init();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error initializing auth: $e')));
      }
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _otpController.dispose();
    _timer?.cancel();
    _animationController.dispose();
    _authService.dispose();
    super.dispose();
  }

  void _validateInput() {
    final input = _idController.text.trim();
    setState(() {
      if (input.contains('@')) {
        _isEmail = true;
        _isValid = _authService.isValidEmail(input);
      } else {
        _isEmail = false;
        _isValid = _authService.isValidPhoneNumber(input);
      }
      _errorText = _isValid ? null : _getErrorText();
    });
  }

  String _getErrorText() {
    if (_idController.text.isEmpty) return '';
    if (_isEmail) {
      return 'Please enter a valid email address';
    } else {
      return 'Please enter a valid 10-digit phone number';
    }
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _timerSeconds = 120);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds == 0) {
        timer.cancel();
        setState(() => _isLoading = false);
      } else {
        setState(() => _timerSeconds--);
      }
    });
  }

  Future<void> _handleVerification() async {
    if (!_isValid) return;

    setState(() => _isLoading = true);

    try {
      final response = _isEmail
          ? await _authService.verifyEmail(_idController.text)
          : await _authService.verifyPhone(_idController.text);

      if (response['success']) {
        setState(() => _showOTP = true);
        _animationController.forward();
        _startTimer();
      }
    } catch (e) {
      setState(() => _errorText = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLogin() async {
    if (_otpController.text.length != 6) {
      setState(() => _errorText = 'Please enter a valid 6-digit OTP');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final isValid = _authService.verifyOTP(_otpController.text);
      if (isValid) {
        print(_otpController.text);
        await _authService.completeLogin(_idController.text, ref);

        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Login successful!')));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          setState(() {});
        }
      } else {
        setState(() => _errorText = 'Invalid OTP');
      }
    } catch (e) {
      setState(() => _errorText = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String get _timerText {
    final minutes = (_timerSeconds / 60).floor();
    final seconds = _timerSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(painter: GridPainter(), size: Size.infinite),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
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
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Authentication',
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 40),

                    TextField(
                      controller: _idController,
                      keyboardType: TextInputType.text,
                      maxLength: null,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          _isEmail ? Icons.email : Icons.phone,
                          color: _isValid ? Colors.green : Colors.grey,
                        ),
                        hintText: 'Enter Phone Number or Email',
                        errorText: _errorText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    if (_showOTP) ...[
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _slideAnimation.value),
                            child: Opacity(
                              opacity: _fadeAnimation.value,
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _otpController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 6,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                      ),
                                      hintText: 'Enter 6-digit OTP',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.green,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Time remaining: $_timerText',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isValid && !_isLoading
                            ? (_showOTP ? _handleLogin : _handleVerification)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _showOTP ? 'Login' : 'Send OTP',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
