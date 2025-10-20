import 'package:flutter/material.dart';
import 'package:isma_ni/language/language_selection_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isma_ni/utils/colors.dart';
import 'package:isma_ni/utils/my_images.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  final List<Map<String, String>> _slides = [
    {
      "image": MyImages.onboard1,
      "title": "All your services in one place",
      "subtitle": "Find technicians, shops, and experts near you instantly.",
    },
    {
      "image": MyImages.onboard2,
      "title": "Trusted & Verified Providers",
      "subtitle": "Every provider is reviewed and verified for your safety.",
    },
    {
      "image": MyImages.onboard3,
      "title": "Trusted & Verified Providers",
      "subtitle": "Every provider is reviewed and verified for your safety.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOnboardingCompleted', true);
    if (mounted) 
     Navigator.push(context, MaterialPageRoute(builder: 
          (context)=>LanguageSelectionScreen()
          ));
   
  }

  void _nextSlide() async {
    if (_currentIndex < _slides.length - 1) {
      await _controller.reverse(); // fade out
      setState(() => _currentIndex++);
      await _controller.forward(); // fade in
    } else {
      _completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward(); // Start first fade in

    final slide = _slides[_currentIndex];
    final isLast = _currentIndex == _slides.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Skip button (top right)
            Positioned(
              top: 16,
              right: 16,
              child: TextButton(
                onPressed: _completeOnboarding,
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                  ),
                ),
              ),
            ),

            // Center content
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 60),

                // Image with smooth fade
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(
                      slide["image"]!,
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * 0.35,
                    ),
                  ),
                ),

                // Bottom Section
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 45),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Text(
                          slide["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          slide["subtitle"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Next / Get Started Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _nextSlide,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              isLast ? "Get Started" : "Next",
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}