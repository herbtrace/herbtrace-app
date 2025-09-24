import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/screens/common/auth/auth_screen.dart';
import 'package:herbtrace_app/screens/onboarding/pages/welcome_page.dart';
import 'package:herbtrace_app/screens/onboarding/pages/language_selection_page.dart';
import 'package:herbtrace_app/screens/onboarding/pages/supply_chain_overview_page.dart';
import 'package:herbtrace_app/screens/onboarding/pages/farmer_guidance_page.dart';
import 'package:herbtrace_app/screens/onboarding/pages/qr_process_page.dart';
import 'package:herbtrace_app/screens/onboarding/pages/get_started_page.dart';
import 'package:herbtrace_app/config/theme.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    WelcomePage(),
    LanguageSelectionPage(),
    SupplyChainOverviewPage(),
    FarmerGuidancePage(),
    QrProcessPage(),
    GetStartedPage(),
  ];

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToAuth();
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToAuth() {
    _goToAuth();
  }

  void _goToAuth() {
    // TODO: Navigate to auth screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryGreen,
              AppTheme.primaryGreen.withOpacity(0.8),
              Colors.green.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (_currentIndex > 0)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(
                          _pages.length,
                          (index) => Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == _currentIndex
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),

                      if (_currentIndex < _pages.length - 1)
                        TextButton(
                          onPressed: _skipToAuth,
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: _pages,
                ),
              ),

              // if (_currentIndex > 0)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    if (_currentIndex > 1)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _previousPage,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back, color: Colors.white),
                              const SizedBox(width: 8),
                              Text(
                                'Previous',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    if (_currentIndex > 1) const SizedBox(width: 16),

                    Expanded(
                      flex: _currentIndex > 1 ? 1 : 2,
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.primaryGreen,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentIndex == _pages.length - 1
                                  ? 'Get Started'
                                  : 'Next',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
