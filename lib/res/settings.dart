import 'package:flutter/material.dart';
import 'package:poker_assistant/pages/game/view_modes/view_modes.dart';

/// Variables responsible for application settings (shows blinds or bet)
class Settings {
  Settings._();

  static final Settings instance = Settings._();

  bool withBlinds = true;

  late ValueNotifier<ViewModes> viewMode = ValueNotifier(ViewModes.viewMode1);
}

/// Variables that set the settings at the start of the game (total cash, players count)
class GameSettings {
  GameSettings._();

  static final GameSettings instance = GameSettings._();
// TODO
}

/// Variables that change during the game (game time, players count)
class Game {
  Game._();

  static final Game instance = Game._();

  late ValueNotifier<bool> pause = ValueNotifier(false);
  late ValueNotifier<bool> showGameOverlay = ValueNotifier(false);
  late ValueNotifier<bool> gameInProgress = ValueNotifier(false);

  bool withBlinds = true;
  int littleBlind = 2;

  int get bigBlind => littleBlind * 2;

  void dispose() {
    pause.dispose();
    showGameOverlay.dispose();
  }

  void startNextRound() {
    gameInProgress.value = true;
  }

  void addPlayer() {}

  void removePlayer() {}

  void changePause() => pause.value = !pause.value;
}
