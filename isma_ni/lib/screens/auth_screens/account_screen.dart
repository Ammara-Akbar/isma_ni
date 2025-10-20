import 'package:flutter/material.dart';
import 'package:isma_ni/screens/auth_screens/customer_signup_screen.dart';
import 'package:isma_ni/screens/auth_screens/verify_number_screen.dart';
import 'package:isma_ni/utils/colors.dart';

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
    required VoidCallback onTap, // ✅ Added required onTap parameter
  }) {
    final bool isSelected = selectedRole == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = title;
        });
        onTap(); // ✅ Trigger custom onTap action
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => VerifyNumberScreen()),
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
              title: const Text(
                "Create Your Account",
                style: TextStyle(
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
              // 2 cards in the first row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRoleCard(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CustomerSignupScreen()),
                      );
                    },
                    title: "Customer",
                    icon: "assets/images/customer.png",
                  ),
                  _buildRoleCard(
                    onTap: () {},
                    title: "Service Provider",
                    icon: "assets/images/serviceP.png",
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // 1 card in the second row (centered)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildRoleCard(
                    onTap: () {},
                    title: "Store Owner",
                    icon: "assets/images/store.png",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
