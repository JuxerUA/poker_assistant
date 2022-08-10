import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';

class PokerStyles extends TextStyle {
  factory PokerStyles(FontSize size, Color color) {
    return PokerStyles.fromTextStyle(
      fontFamily: 'Bitter',
      color: color,
      fontSize: size.size,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    );
  }

  const PokerStyles.fromTextStyle({
    super.fontFamily,
    super.color,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
  });

  static const headerBlack = TextStyle(
    fontFamily: 'Bitter',
    color: PokerColors.black,
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
  s38(38),
  s50(50);

  const FontSize(this.size);

  final double size;
}
