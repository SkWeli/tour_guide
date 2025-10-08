import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'router/app_router.dart';

class GuideApp extends StatelessWidget {
  const GuideApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TurGuide — Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF1155CC),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      routerConfig: appRouter,
    );
  }
}
