import 'package:flutter/material.dart';
import 'package:isma_ni/language/language_selection_screen.dart';
import 'package:isma_ni/screens/splash_onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isma_ni/utils/colors.dart';
import 'package:isma_ni/utils/my_images.dart';
import 'package:isma_ni/language/app_language_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }
 Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2)); // Splash delay

    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (!mounted) return;

    if (isFirstTime) {
      // 🔹 First time launching → show onboarding
      await prefs.setBool('isFirstTime', false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    } else {
      // 🔹 Not first time → show language selection
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LanguageSelectionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLanguage = Provider.of<AppLanguageProvider>(context);
    final isArabic = appLanguage.appLocal.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Image.asset(
              MyImages.appLogo,
              width: 180,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 12,),
            // Localized text (auto changes with language)
            Text(
              isArabic ? "مرحبًا بك في اسمعني" : "Welcome to Esma3ni",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
