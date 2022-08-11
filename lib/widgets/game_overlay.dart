import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';
import 'package:poker_assistant/res/settings.dart';
import 'package:poker_assistant/widgets/overlay_button.dart';

class GameOverlay extends StatelessWidget {
  const GameOverlay({
    required this.goUp,
    Key? key,
  }) : super(key: key);

  final VoidCallback goUp;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Game.instance.showGameOverlay,
      builder: (context, showGameOverlay, child) {
        return Offstage(
          offstage: !showGameOverlay,
          child: Container(
            color: PokerColors.black.withOpacity(0.9),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: OverlayButton(
                    image: Icons.arrow_upward,
                    text: 'Go up!',
                    onTap: goUp,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: OverlayButton(
                    image: Icons.play_arrow,
                    text: 'Next round!',
                    onTap: Game.instance.startNextRound,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: OverlayButton(
                          image: Icons.person_add,
                          text: 'Add player',
                          onTap: Game.instance.addPlayer,
                        ),
                      ),
                      Flexible(
                        child: OverlayButton(
                          image: Icons.person_remove,
                          text: 'Player out',
                          onTap: Game.instance.removePlayer,
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: Game.instance.pause,
                  builder: (context, pause, child) {
                    return Flexible(
                      flex: 3,
                      child: OverlayButton(
                        image: pause ? Icons.play_arrow_outlined : Icons.pause,
                        text: pause ? 'Continue' : 'Pause',
                        onTap: Game.instance.changePause,
                      ),
                    );
                  },
                ),
                Flexible(
                  flex: 4,
                  child: OverlayButton(
                    image: Icons.cancel,
                    text: 'Back to game',
                    onTap: () => Game.instance.showGameOverlay.value = false,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
