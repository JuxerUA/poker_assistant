import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';

class PokerStyles extends TextStyle {
  factory PokerStyles(FontSize size, Color color, {double? height}) {
    return PokerStyles.fromTextStyle(
      fontFamily: 'Bitter',
      color: color,
      fontSize: size.size,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      height: height,
    );
  }

  const PokerStyles.fromTextStyle({
    super.fontFamily,
    super.color,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.height,
  });

  static const headerBlack = TextStyle(
    fontFamily: 'Bitter',
    color: PokerColors.lightBlack,
    fontSize: 50,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  static const headerYellow = TextStyle(
    fontFamily: 'Bitter',
    color: PokerColors.yellow,
    fontSize: 38,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );
}

enum FontSize {
  s16(16),
  s20(20),
  s24(24),
  s30(30),
  s38(38),
  s50(50),
  s80(80),
  s90(90),
  s100(100),
  s200(200),
  s220(220),
  s250(250);

  const FontSize(this.size);

  final double size;
}
