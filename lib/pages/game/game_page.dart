import 'package:flutter/material.dart';
import 'package:poker_assistant/pages/game/game_placeholder.dart';
import 'package:poker_assistant/pages/game/view_modes/view_mode_1.dart';
import 'package:poker_assistant/pages/game/view_modes/view_mode_2.dart';
import 'package:poker_assistant/pages/game/view_modes/view_mode_3.dart';
import 'package:poker_assistant/pages/game/view_modes/view_modes.dart';
import 'package:poker_assistant/res/res.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with AutomaticKeepAliveClientMixin<GamePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
      onTap: () => game.showGameOverlay.value = true,
      child: Container(
        color: PokerColors.black,
        child: ValueListenableBuilder<bool>(
          valueListenable: game.gameInProgress,
          builder: (context, inProgress, child) {
            if (inProgress) {
              return ValueListenableBuilder<ViewModes>(
                valueListenable: settings.viewMode,
                builder: (context, viewMode, child) {
                  switch (settings.viewMode.value) {
                    case ViewModes.viewMode1:
                      return const ViewMode1();
                    case ViewModes.viewMode2:
                      return const ViewMode2();
                    case ViewModes.viewMode3:
                      return const ViewMode3();
                  }
                },
              );
            }

            return const GamePlaceholder();
          },
        ),
      ),
    );
  }
}
