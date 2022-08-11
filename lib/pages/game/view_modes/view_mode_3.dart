import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';

class ViewMode3 extends StatelessWidget {
  const ViewMode3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textColor = PokerColors.grey;
    final littleBlindText = Game.instance.littleBlind.toString();
    final bigBlindText = Game.instance.bigBlind.toString();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FittedBox(
          child: RotatedBox(
            quarterTurns: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bigBlindText,
                  style: PokerStyles(FontSize.s220, textColor),
                ),
                Text(
                  'BIG BLIND',
                  style: PokerStyles(FontSize.s30, textColor, height: 0.1),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FittedBox(
              child: RotatedBox(
                quarterTurns: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      littleBlindText,
                      style: PokerStyles(FontSize.s100, textColor),
                    ),
                    Text(
                      'LITTLE BLIND',
                      style: PokerStyles(FontSize.s20, textColor, height: 1),
                    ),
                  ],
                ),
              ),
            ),
            FittedBox(
              child: RotatedBox(
                quarterTurns: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      littleBlindText,
                      style: PokerStyles(FontSize.s100, textColor),
                    ),
                    Text(
                      'LITTLE BLIND',
                      style: PokerStyles(FontSize.s20, textColor, height: 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        FittedBox(
          child: RotatedBox(
            quarterTurns: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bigBlindText,
                  style: PokerStyles(FontSize.s220, textColor),
                ),
                Text(
                  'BIG BLIND',
                  style: PokerStyles(FontSize.s30, textColor, height: 0.1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
