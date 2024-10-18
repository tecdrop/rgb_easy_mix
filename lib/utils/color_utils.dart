import 'package:flutter/material.dart';

/// Returns the black or white contrast color of a given color.
Color contrastOf(Color color) {
  return ThemeData.estimateBrightnessForColor(color) == Brightness.light
      ? Colors.black
      : Colors.white;
}
