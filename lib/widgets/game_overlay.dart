import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';
import 'package:poker_assistant/res/settings.dart';
import 'package:poker_assistant/widgets/overlay_button.dart';

class GameOverlay extends StatelessWidget {
  const GameOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Game.instance.showGameOverlay,
      builder: (context, showGameOverlay, child) {
        return Offstage(
          offstage: !showGameOverlay,
          child: Container(
            color: PokerColors.black.withOpacity(0.2),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                OverlayButton(
                  image: Icons.arrow_upward,
                  text: 'Go up!',
                  onTap: _goUp,
                ),
                OverlayButton(
                  image: Icons.cancel_outlined,
                  text: 'Next round!',
                  onTap: Game.instance.startNextRound,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OverlayButton(
                        image: Icons.person_add,
                        text: 'Add player',
                        onTap: Game.instance.addPlayer,
                      ),
                      OverlayButton(
                        image: Icons.person_remove,
                        text: 'Remove player',
                        onTap: Game.instance.removePlayer,
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: Game.instance.pause,
                  builder: (context, pause, child) {
                    return OverlayButton(
                      image: Icons.pause,
                      text: 'Pause',
                      onTap: Game.instance.pauseGame,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _goUp() {
    //TODO
  }
}
