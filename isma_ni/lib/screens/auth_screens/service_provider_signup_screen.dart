import 'package:flutter/material.dart';
import 'package:isma_ni/screens/auth_screens/choose_account_screen.dart';
import 'package:isma_ni/screens/auth_screens/under_review_screen.dart';
import 'package:isma_ni/utils/colors.dart';
import 'package:isma_ni/language/app_localization.dart';

class ServiceProviderSignupScreen extends StatefulWidget {
  const ServiceProviderSignupScreen({super.key});

  @override
  State<ServiceProviderSignupScreen> createState() =>
      _ServiceProviderSignupScreenState();
}

class _ServiceProviderSignupScreenState
    extends State<ServiceProviderSignupScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _yearsController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreeTerms = false;
  String? _selectedCategory;

late List<String> _categories;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  final translate = AppLocalizations.of(context)!.translate;
  final locale = Localizations.localeOf(context).languageCode;

  if (locale == 'ar') {
    _categories = [
      translate("plumber") ,
      translate("electrician") ?? "كهربائي",
      translate("cleaner") ?? "عامل نظافة",
      translate("mechanic") ?? "ميكانيكي",
      translate("technician") ?? "فني",
    ];
  } else {
    _categories = [
      translate("plumber") ?? "Plumber",
      translate("electrician") ?? "Electrician",
      translate("cleaner") ?? "Cleaner",
      translate("mechanic") ?? "Mechanic",
      translate("technician") ?? "Technician",
    ];
  }
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
            MaterialPageRoute(builder: (_) => const ChooseAccountScreen()),
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
                backgroundColor: AppColors.primaryColor,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  translate("service_provider_signup") ??
                      "Service Provider Signup",
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
                          builder: (context) => const ChooseAccountScreen()),
                    );
                  },
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(translate("full_name")),
                  _inputField(_fullNameController,
                      hint: translate("full_name_hint") ),
                  const SizedBox(height: 18),

                  _label(translate("email") ),
                  _inputField(_emailController,
                      hint: translate("email_hint") ,
                      keyboard: TextInputType.emailAddress),
                  const SizedBox(height: 18),

                  _label(translate("phone_number")),
                    SizedBox(height: 
                  7,),
                  _phoneField(),
                  const SizedBox(height: 18),

                  _label(translate("service_category")),
                  SizedBox(height: 
                  7,),
                  _dropdown(),
                  const SizedBox(height: 18),

                  _label(translate("years_experience") ),
                  _inputField(_yearsController,
                      hint: translate("enter_years_experience") ,
                          
                      keyboard: TextInputType.number),
                  const SizedBox(height: 18),

                  _label(translate("upload_id") ),
                    SizedBox(height: 
                  7,),
                  _uploadBox(translate("front_side") ),
                  const SizedBox(height: 12),
                  _uploadBox(translate("back_side") ),
                  const SizedBox(height: 18),

                  _label(translate("password") ),
                    SizedBox(height: 
                  7,),
                  _passwordField(
                      controller: _passwordController,
                      visible: _isPasswordVisible,
                      onToggle: (v) =>
                          setState(() => _isPasswordVisible = v)),
                  const SizedBox(height: 18),

                  _label(translate("confirm_password") ?? "Confirm Password"),
                    SizedBox(height: 
                  7,),
                  _passwordField(
                      controller: _confirmPasswordController,
                      visible: _isConfirmPasswordVisible,
                      onToggle: (v) =>
                          setState(() => _isConfirmPasswordVisible = v)),
                  const SizedBox(height: 18),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            setState(() => _agreeTerms = !_agreeTerms),
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              color: _agreeTerms
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade300,
                              width: 1.5,
                            ),
                            color: _agreeTerms
                                ? AppColors.primaryColor
                                : Colors.white,
                          ),
                          child: _agreeTerms
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 16)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(translate("i_agree_to") ?? "I agree to ",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black87)),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          translate("terms_conditions") ,
                          style: const TextStyle(
                            color: AppColors.cyanClr,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                         Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => UnderReviewScreen()),
                      );
                      },
                      child: Text(
                        translate("create_provider_account") 
                           ,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500));

  Widget _inputField(TextEditingController controller,
      {String? hint, TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:  TextStyle(color: Colors.grey.shade400),
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }

  Widget _phoneField() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.myGreyClr),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Text("+966",
                  style: TextStyle(fontSize: 16, color: Colors.black87)),
            ),
            Container(width: 1, height: 40, color: AppColors.myGreyClr),
            Expanded(
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration:  InputDecoration(
                  hintText: "85255454",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _dropdown() {
     final translate = AppLocalizations.of(context)!.translate;
    return
    Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.myGreyClr),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedCategory,
            hint: Text(
          translate("choose_category"),
          style: TextStyle(color: Colors.grey.shade400),
        ),
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.black54),
            items: _categories
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _selectedCategory = val),
          ),
        ),
  );}

  Widget _uploadBox(String label) => Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
          color: Colors.white,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/upload.png",height: 25,),
              SizedBox(width: 10,),
              Text(label,
                  style: const TextStyle(color: Colors.grey, fontSize: 15)),
            ],
          ),
        ),
      );

  Widget _passwordField({
    required TextEditingController controller,
    required bool visible,
    required ValueChanged<bool> onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: !visible,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        hintText: "********",
        hintStyle: TextStyle(color: Colors.grey.shade400),
        suffixIcon: IconButton(
          icon: Image.asset('assets/images/eye.png',
              width: 22, height: 22, color: Colors.grey),
          onPressed: () => onToggle(!visible),
        ),
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}
