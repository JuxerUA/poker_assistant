import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';

class ViewMode2 extends StatelessWidget {
  const ViewMode2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO should be red if time left
    const textColor = PokerColors.orange;
    final game = Game.instance;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'BIG\nBLIND',
          style: PokerStyles(FontSize.s80, textColor),
          textAlign: TextAlign.center,
        ),
        FittedBox(
          child: Row(
            children: [
              const SizedBox(width: 50),
              Text(
                '${game.bigBlind}',
                style: PokerStyles(FontSize.s200, textColor, height: 0.5),
              ),
              const SizedBox(width: 50),
            ],
          ),
        ),
        Text(
          'LITTLE\nBLIND',
          style: PokerStyles(FontSize.s50, textColor),
          textAlign: TextAlign.center,
        ),
        FittedBox(
          child: Row(
            children: [
              const SizedBox(width: 50),
              Text(
                '${game.littleBlind}',
                style: PokerStyles(FontSize.s90, textColor, height: 0.1),
              ),
              const SizedBox(width: 50),
            ],
          ),
        ),
      ],
    );
  }
}
