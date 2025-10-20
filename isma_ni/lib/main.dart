import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isma_ni/language/language_selection_screen.dart';
import 'package:isma_ni/screens/splash_onboarding/onboarding_screen.dart';
import 'package:isma_ni/screens/splash_onboarding/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'language/app_localization.dart';
import 'language/app_language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize language provider
  final appLanguage = AppLanguageProvider();
  await appLanguage.fetchLocale();

  // Force portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Transparent status bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ));

  // Provide the app-wide language provider
  runApp(
    ChangeNotifierProvider<AppLanguageProvider>.value(
      value: appLanguage,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1047),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer<AppLanguageProvider>(
          builder: (context, model, child) {
            return MaterialApp(
              title: "Isma'ni",
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: "Arial",
                scaffoldBackgroundColor: Colors.white,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: false,
              ),
              // 👇 Apply the saved or selected language globally
              locale: model.appLocal,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ar', 'SA'),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],

              // 👇 RTL/LTR direction handling based on language
              builder: (context, child) {
                return Directionality(
                  textDirection: model.appLocal.languageCode == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: child!,
                );
              },

              // 👇 Start with splash or onboarding
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:isma_ni/screens/splash_screen.dart';
// import 'package:provider/provider.dart';
// import '../../language/app_localization.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'language/app_language_provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   AppLanguageProvider appLanguage = AppLanguageProvider();
//   await appLanguage.fetchLocale();

//   // Set default orientation to portrait for mobile
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent, // Transparent background
//       statusBarIconBrightness: Brightness.light, // ✅ Android icons white
//       statusBarBrightness: Brightness.light, // ✅ iOS icons white
//     ),
//   );

//   runApp(
//     ChangeNotifierProvider<AppLanguageProvider>.value(
//       value: appLanguage,

//       child: MyApp(appLanguage: AppLanguageProvider()),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key, required AppLanguageProvider appLanguage});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(1440, 1047),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return Consumer<AppLanguageProvider>(
//           builder: (context, model, child) {
//             return MaterialApp(
//               title: 'Isma\'ni',
//               debugShowCheckedModeBanner: false,
//               theme: ThemeData(
//                 fontFamily: "Arial",
//                 scaffoldBackgroundColor: Colors.black,
//                 colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//                 useMaterial3: false,
//               ),
//               home: SplashScreen(),
//               // DeviceTypeSelector(),
//               locale: model.appLocal,
//               supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
//               localizationsDelegates: const [
//                 AppLocalizations.delegate,
//                 GlobalMaterialLocalizations.delegate,
//                 GlobalWidgetsLocalizations.delegate,
//                 GlobalCupertinoLocalizations.delegate,
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class DeviceTypeSelector extends StatelessWidget {
//   const DeviceTypeSelector({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Get screen dimensions
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final shortestSide = MediaQuery.of(context).size.shortestSide;

//     // Determine if it's a TV/large screen
//     // TV screens are typically >= 960dp in width and have large aspect ratios
//     final isTv = screenWidth >= 960 || (screenWidth > 800 && shortestSide > 600);

//     print('Screen Width: $screenWidth, Height: $screenHeight, Shortest: $shortestSide');
//     print('Is TV: $isTv');

//     // Route to appropriate splash screen
//     return Container();
//   }
// }
