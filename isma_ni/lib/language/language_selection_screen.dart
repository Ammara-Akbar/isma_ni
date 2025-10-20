import 'package:flutter/material.dart';
import 'package:isma_ni/screens/auth_screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isma_ni/utils/colors.dart';
import 'package:isma_ni/utils/my_images.dart';
import 'package:isma_ni/language/app_language_provider.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLang;

  @override
  void initState() {
    super.initState();
    final appLanguage = Provider.of<AppLanguageProvider>(context, listen: false);
    _selectedLang = appLanguage.appLocal.languageCode;
  }Future<void> _saveLanguageAndProceed() async {
  if (_selectedLang == null) return;

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('language_code', _selectedLang!);

  final appLanguage = Provider.of<AppLanguageProvider>(context, listen: false);

  if (_selectedLang == 'ar') {
    await appLanguage.changeLanguage(const Locale('ar', 'SA'));
  } else {
    await appLanguage.changeLanguage(const Locale('en', 'US'));
  }

  // 👇 Wait for the MaterialApp to rebuild with the new locale
  await Future.delayed(const Duration(milliseconds: 200));

  if (mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }
}

@override
Widget build(BuildContext context) {

  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Logo
            Center(
              child: Image.asset(
                MyImages.appLogo,
                width: 150,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 80),

            // Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select language",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Language options row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<String>(
                  value: 'ar',
                  groupValue: _selectedLang,
                  activeColor: AppColors.primaryColor,
                  onChanged: (value) {
                    setState(() => _selectedLang = value);
                  },
                ),
                const Text("Arabic",
                    style: TextStyle(fontSize: 14, color: Colors.black87)),
                const SizedBox(width: 25),
                Radio<String>(
                  value: 'en',
                  groupValue: _selectedLang,
                  activeColor: AppColors.primaryColor,
                  onChanged: (value) {
                    setState(() => _selectedLang = value);
                  },
                ),
                const Text("English",
                    style: TextStyle(fontSize: 14, color: Colors.black87)),
              ],
            ),

            const SizedBox(height: 60),

            // Next button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                ),
                onPressed: _selectedLang == null
                    ? null
                    : _saveLanguageAndProceed,
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
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
  );
}
}