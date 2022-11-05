import 'dart:async';

import 'package:flutter/material.dart';
import 'package:poker_assistant/pages/game/view_modes/view_modes.dart';
import 'package:poker_assistant/res/res.dart';

/// Variables responsible for application settings (shows blinds or bet)
class Settings {
  Settings._();

  static final Settings instance = Settings._();

  late ValueNotifier<ViewModes> viewMode = ValueNotifier(ViewModes.viewMode1);

  bool withBlinds = true;
  int minChipValue = 1; // 1, 2, 5, 10, 20, 25, 50 ???
}

/// Variables that set the settings at the start of the game (total cash, players count, blinds settings)
class GameSettings {
  GameSettings._();

  static final GameSettings instance = GameSettings._();

  int blindGrowDivider = 6;
  int blindGrowPower = 3;
  double minLittleBlindPercentage = 1.5;
}

/// Variables that change during the game (game time, players count)
class Game {
  Game._();

  static final Game instance = Game._();

  late ValueNotifier<bool> pause = ValueNotifier(false);
  late ValueNotifier<bool> showGameOverlay = ValueNotifier(false);
  late ValueNotifier<bool> gameInProgress = ValueNotifier(false);
  late ValueNotifier<String> currentGameTimeString =
      ValueNotifier('Not started');

  late Timer? timer = Timer.periodic(
    const Duration(seconds: 1),
    _onTimerCallback,
  );

  DateTime startGameTime = DateTime.now();

  bool withBlinds = true;
  int littleBlind = 0;

  int get bigBlind => littleBlind * 2;

  Color get getCurrentBlindsColor {
    // TODO should be red if time is over
    return PokerColors.orange;
  }

  void dispose() {
    pause.dispose();
    showGameOverlay.dispose();
  }

  void startNewGame() {
    gameInProgress.value = true;
    showGameOverlay.value = false;
  }

  void startNextRound() {
    gameInProgress.value = true;
    showGameOverlay.value = false;
  }

  void addPlayer() {}

  void removePlayer() {}

  void changePause() => pause.value = !pause.value;

  int calculateNextLittleBlind({
    required int prevLittleBlind,
    required double timePercentage,
    required double averagePlayerCash,
  }) {
    var timeFactor = 1.0;
    for (var index = 0; index < gameSettings.blindGrowPower; index++) {
      timeFactor *= timePercentage;
    }

    var result =
        (averagePlayerCash / gameSettings.blindGrowDivider * timeFactor)
            .round();
    if (result < prevLittleBlind) {
      result = prevLittleBlind;
    }

    final minLittleBlind =
        (averagePlayerCash * gameSettings.minLittleBlindPercentage).round();
    if (result < minLittleBlind) {
      result = minLittleBlind;
    }

    if (result % settings.minChipValue != 0) {
      result = ((result / settings.minChipValue).floor() + 1) *
          settings.minChipValue;
    }

    /// Returns new little blind value
    return result;
  }

  void updateRates() {}

  void _onTimerCallback(Timer timer) {
    final duration = startGameTime.difference(DateTime.now());
    final sDuration =
        '${duration.inHours}:${duration.inMinutes.remainder(60)}:${duration.inSeconds.remainder(60)}';
    currentGameTimeString.value = sDuration;
  }
}
