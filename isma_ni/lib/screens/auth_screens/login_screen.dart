import 'package:flutter/material.dart';
import 'package:isma_ni/screens/auth_screens/verify_number_screen.dart';
import 'package:isma_ni/utils/colors.dart';
import 'package:isma_ni/utils/my_images.dart';
import 'package:isma_ni/language/app_localization.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;

    // 👇 Detect current direction automatically
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Logo
                Center(
                  child: Image.asset(
                    MyImages.appLogo,
                    width: 130,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),

                // 🔹 Title
                Text(
                  translate("welcome_back"),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),

                // 🔹 Subtitle
                Text(
                  translate("login_subtitle"),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),

                // 🔹 Phone Field
                Text(
                  translate("phone_number"),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.myGreyClr),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: const Text(
                          "+966",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                          width: 1, height: 40, color: AppColors.myGreyClr),
                      Expanded(
                        child: TextField(
                          cursorColor: AppColors.primaryColor,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: translate("phone_hint"),
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 🔹 Password Field
                Text(
                  translate("password"),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    hintText: "********",
                    suffixIcon: IconButton(
                      icon: Image.asset(
                        _isPasswordVisible
                            ? 'assets/images/eye.png' // 👁 when visible
                            : 'assets/images/eye.png', // same or another eye-closed image if you have it
                        width: 22,
                        height: 22,
                        color: Colors.grey, // optional tint
                      ),
                      onPressed: () {
                        setState(
                            () => _isPasswordVisible = !_isPasswordVisible);
                      },
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.myGreyClr),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.myGreyClr),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.myGreyClr),
                    ),
                  ),
                ),

                // 🔹 Forgot Password
                Align(
                  alignment:
                      isArabic ? Alignment.centerLeft : Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      translate("forgot_password"),
                      style: const TextStyle(
                        color: AppColors.greyText,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // 🔹 Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => VerifyNumberScreen()),
      );
                    },
                    child: Text(
                      translate("login"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // 🔹 Signup text
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: RichText(
                      text: TextSpan(
                        text: translate("no_account"),
                        style: const TextStyle(
                          color: AppColors.greyText,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: translate("signup"),
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
