import 'package:flutter/material.dart';
import 'package:isma_ni/screens/auth_screens/customer_signup_screen.dart';
import 'package:isma_ni/screens/auth_screens/service_provider_signup_screen.dart';
import 'package:isma_ni/screens/auth_screens/verify_number_screen.dart';
import 'package:isma_ni/utils/colors.dart';
import 'package:isma_ni/language/app_localization.dart'; // ✅ Added localization import

class ChooseAccountScreen extends StatefulWidget {
  const ChooseAccountScreen({super.key});

  @override
  State<ChooseAccountScreen> createState() => _ChooseAccountScreenState();
}

class _ChooseAccountScreenState extends State<ChooseAccountScreen> {
  String? selectedRole;

  final Color primaryColor = AppColors.primaryColor;

  Widget _buildRoleCard({
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    final bool isSelected = selectedRole == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = title;
        });
        onTap();
      },
      child: Container(
        width: 160,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 40,
              color: Colors.black,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const VerifyNumberScreen()),
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: AppBar(
                backgroundColor: primaryColor,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  translate("create_your_account") ?? "Create Your Account",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VerifyNumberScreen()),
                    );
                  },
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                // 🔹 First row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRoleCard(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CustomerSignupScreen()),
                        );
                      },
                      title: translate("customer") ?? "Customer",
                      icon: "assets/images/customer.png",
                    ),
                    _buildRoleCard(
                      onTap: () {
                                                Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ServiceProviderSignupScreen()),
                        );
                      },
                      title: translate("service_provider") ??
                          "Service Provider",
                      icon: "assets/images/serviceP.png",
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // 🔹 Second row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildRoleCard(
                      onTap: () {},
                      title: translate("store_owner"),
                      icon: "assets/images/store.png",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
