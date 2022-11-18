import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream_timer/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Timer UI',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.cabinTextTheme(),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
