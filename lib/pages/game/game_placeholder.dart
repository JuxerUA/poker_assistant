import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';

class GamePlaceholder extends StatelessWidget {
  const GamePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: PokerColors.yellow,
      strokeWidth: 30,
      dashPattern: const <double>[20, 20],
      padding: const EdgeInsets.all(20),
      radius: const Radius.circular(40),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          color: PokerColors.black,
          child: const Center(
            child: Text('Poker', style: PokerStyles.headerYellow),
          ),
        ),
      ),
    );
  }
}
