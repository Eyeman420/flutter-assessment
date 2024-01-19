//Disclaimer: I try my best to complete this assesment as much as possible
//even though I'm currently very busy with my FYP presentation
//and sorry if my postman implementation very bad because this API is new to me

import 'package:dummy_profile_listing/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dummy Profile Listing',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 46, 160, 148),
        ),
        colorScheme: ColorScheme.fromSeed(
          // seedColor: Colors.teal.shade200,
          seedColor: const Color.fromARGB(255, 46, 160, 148),
        ).copyWith(background: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 46, 160, 148),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
