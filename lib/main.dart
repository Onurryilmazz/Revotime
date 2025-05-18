import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/view/login_view.dart';
import 'features/home/view/home_view.dart';
import 'core/localization/app_localizations.dart';
import 'features/splash/view/splash_view.dart';
import 'features/auth/view/code_verification_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RevoTime',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      locale: const Locale('en'), // Set default locale to English
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('tr'), // Turkish
      ],
      routes: {
        '/': (context) => const SplashView(), // Set SplashView as the initial route
        '/login': (context) => const LoginView(),
        '/home': (context) => const HomeView(),
        '/verify-code': (context) => const CodeVerificationView(email: ''), // Add route for code verification
      },
    );
  }
}