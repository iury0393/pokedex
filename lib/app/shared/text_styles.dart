import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeviceHeight {
  static const iphone5S = 568.0;
  static const iphone6S = 667.0;
  static const iphone11ProMax = 896.0;
}

class TextSize {
  static double _screenHeight = 0.0;

  static double xxxSmall = 10.0;
  static double xxSmall = 12.0;
  static double xSmall = 14.0;
  static double small = 16.0;
  static double medium = 18.0;
  static double large = 20.0;
  static double xLarge = 22;
  static double xxLarge = 24;
  static double big = 26;
  static double xBig = 28;
  static double xxBig = 32;
  static double profileSize = 55;

  void init(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;

    small = _screenHeight <= DeviceHeight.iphone5S ? 16 : 18;
    big = _screenHeight <= DeviceHeight.iphone5S ? 26 : 28;
    xBig = _screenHeight <= DeviceHeight.iphone5S ? 28 : 30;
  }
}

class TextStyles {
  static TextStyle appBarTitle({Color textColor = Colors.black}) {
    return GoogleFonts.lato(
      fontSize: TextSize.medium,
      color: textColor,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle paragraph(
    double size, {
    FontWeight weight = FontWeight.normal,
    Color color = Colors.black,
    double lineHeight = 1.010,
    bool isLink = false,
  }) {
    return GoogleFonts.lato(
      decoration: isLink ? TextDecoration.underline : TextDecoration.none,
      fontSize: size,
      height: lineHeight,
      color: color,
      fontWeight: weight,
    );
  }

  static TextStyle textField(
    double size, {
    FontWeight weight = FontWeight.normal,
    Color color = Colors.black,
  }) {
    return GoogleFonts.lato(
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }
}
