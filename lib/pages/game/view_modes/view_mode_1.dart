import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';

class ViewMode1 extends StatelessWidget {
  const ViewMode1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO should be red if time left
    const textColor = PokerColors.orange;

    return FittedBox(
      child: RotatedBox(
        quarterTurns: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 50),
            Text(
              '${game.bigBlind}',
              style: PokerStyles(FontSize.s250, textColor),
            ),
            const SizedBox(width: 50),
            Text(
              '${game.littleBlind}',
              style: PokerStyles(FontSize.s100, textColor),
            ),
            const SizedBox(width: 50),
          ],
        ),
      ),
    );
  }
}
