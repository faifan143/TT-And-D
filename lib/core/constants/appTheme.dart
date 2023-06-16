import 'package:flutter/material.dart';

// Define the English theme
ThemeData englishTheme = ThemeData(
  // Set the font family to Nunito
  fontFamily: "Nunito",
  // Define the text styles for the different typography elements
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.black,
    ),
    headline2: TextStyle(fontSize: 26, color: Colors.black),
    bodyText1: TextStyle(
      height: 2,
      fontWeight: FontWeight.bold,
      fontSize: 17,
      color: Colors.black,
    ),
  ),
);

// Define the Arabic theme
ThemeData arabicTheme = ThemeData(
  // Set the font family to Cairo
  fontFamily: "Cairo",
  // Define the text styles for the different typography elements
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 26,
      color: Colors.white,
    ),
    headline2: TextStyle(fontSize: 20, color: Colors.white),
    bodyText1: TextStyle(
      height: 2,
      fontSize: 17,
      color: Colors.white,
    ),
  ),
);
