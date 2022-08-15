import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:poker_assistant/pages/game/game_overlay/overlay_button.dart';
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
        child: Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: OverlayButton(
              image: Icons.not_started_outlined,
              text: 'START GAME',
              onTap: game.startNewGame,
              isVertical: true,
            ),
          ),
        ),
      ),
    );
  }
}
