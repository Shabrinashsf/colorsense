import 'package:flutter/material.dart';
import 'dart:math' as math;

class WcagChecker {
  static double getLuminance(Color color) {
    double r = color.r;
    double g = color.g;
    double b = color.b;

    r = r <= 0.03928 ? r / 12.92 : math.pow((r + 0.055) / 1.055, 2.4).toDouble();
    g = g <= 0.03928 ? g / 12.92 : math.pow((g + 0.055) / 1.055, 2.4).toDouble();
    b = b <= 0.03928 ? b / 12.92 : math.pow((b + 0.055) / 1.055, 2.4).toDouble();

    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  static double getContrastRatio(Color c1, Color c2) {
    double l1 = getLuminance(c1);
    double l2 = getLuminance(c2);

    if (l1 < l2) {
      double temp = l1;
      l1 = l2;
      l2 = temp;
    }

    return (l1 + 0.05) / (l2 + 0.05);
  }
}
