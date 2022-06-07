import 'package:flutter/material.dart';

class GameData {
  GameData._();

  static final instance = GameData._();

  int allGameTimeSec = 3600;
  int timeLeftSec = 3600;
  int allCash = 1000;
  int playersCount = 3;
  int viewMode = 3;
  int minChipValue = 1;
  int minLittleBlind = 5;
  double minLittleBlindPerc = 1.5;
  int currentLittleBlind = 0;
  DateTime startGameTime = DateTime.now();
  DateTime startACurrentGameTime = DateTime.now();
  Color valueColor = Colors.grey;
  int gameCount = 0;
  int theLongestGameSec = 0;
  int theShortestGameSec = 999999;
  bool needResetLittleBlind = false;

  int blindGrowDivider = 6;
  int blindGrowPower = 3;

  void startNextGame({bool restart = false}) {
    if (restart) {
      --gameCount;
    }

    if (gameCount == 0) {
      currentLittleBlind = 1;
      startGameTime = DateTime.now();
      startACurrentGameTime = startGameTime;
    } else {
      if (!restart) {
        final tmp = DateTime.now().difference(startACurrentGameTime).inSeconds;
        if (tmp > theLongestGameSec) {
          theLongestGameSec = tmp;
        }
        if (tmp < theShortestGameSec) {
          theShortestGameSec = tmp;
        }
      }
      startACurrentGameTime = DateTime.now();
    }
    ++gameCount;

    final realCurrentGameTime =
        DateTime.now().difference(startGameTime).inSeconds;
    if (realCurrentGameTime > allGameTimeSec) {
      allGameTimeSec = realCurrentGameTime;
    }
    timeLeftSec = allGameTimeSec - realCurrentGameTime;

    //old if (timeLeftMinutes == allGameTime) timeLeftMinutes--;

    if (timeLeftSec < 0) {
      timeLeftSec = 0;
    }
    //считаем коефициент времени 0.0 .. 1.0

    //old double timeK = (sqrt(allGameTime) - sqrt(timeLeftMinutes)) / sqrt(allGameTime);

    final tmpTimeK = 1 - timeLeftSec / allGameTimeSec;

    if (needResetLittleBlind) {
      currentLittleBlind = 1;
      needResetLittleBlind = false;
    }

    final onePlayerCash = allCash / playersCount;

    valueColor = (timeLeftSec > 0) ? Colors.orange : Colors.red.shade900;
//////////////////////////////////////////////////////////////////

    var timeK = 1.0;
    for (var index = 0; index < blindGrowPower; index++) {
      timeK *= tmpTimeK;
    }

    //считаем размер малого блайнда

    final newLittleBlind = (onePlayerCash / blindGrowDivider * timeK).round();
    if (newLittleBlind > currentLittleBlind) {
      currentLittleBlind = newLittleBlind;
    }

    minLittleBlind = (onePlayerCash * minLittleBlindPerc * 0.01).round();

    if (currentLittleBlind < minLittleBlind) {
      currentLittleBlind = minLittleBlind;
    }
    if (currentLittleBlind % minChipValue != 0) {
      currentLittleBlind =
          ((currentLittleBlind / minChipValue).floor() + 1) * minChipValue;
    }

//////////////////////////////////////////////////////////////////

    // if (currentLittleBlind > 490) {
    //   currentLittleBlind = 490;
    //   valueColor = Colors.red[900];
    // }
  }

//todo
//   int littleBlindCalculator(
//     double timePerc,
//     double averagePlayerCash,
//     double minPerc,
//     double addPerc,
//     int growDivider,
//     int growPower,
//   ) {
//     var timeK = 1.0;
//     for (var iii = 0; iii < growPower; iii++) {
//       timeK *= timePerc;
//     }
//
//     final newLittleBlind = (averagePlayerCash / growDivider * timeK).round();
//     if (newLittleBlind > currentLittleBlind) {
//       currentLittleBlind = newLittleBlind;
//     }
//
//     minLittleBlind = (averagePlayerCash * minPerc).round();
//
//     if (currentLittleBlind < minLittleBlind) {
//       currentLittleBlind = minLittleBlind;
//     }
//     if (currentLittleBlind % minChipValue != 0) {
//       currentLittleBlind =
//           ((currentLittleBlind / minChipValue).floor() + 1) * minChipValue;
//     }
//   }

  bool changeTimeLeft(int newTimeLeftMin) {
    final dTimeSec = newTimeLeftMin * 60 - timeLeftSec;
    allGameTimeSec += dTimeSec;
    timeLeftSec = newTimeLeftMin * 60;

    return dTimeSec >= 0;
  }

  void stopTheGame() {
    allGameTimeSec = 3600;
    timeLeftSec = 3600;
    currentLittleBlind = 0;
    valueColor = Colors.grey;
    gameCount = 0;
    minLittleBlind = (allCash / playersCount * 0.01).floor();
    if (minLittleBlind < 1) {
      minLittleBlind = 1;
    }
    theLongestGameSec = 0;
    theShortestGameSec = 999999;
  }

  int getGameTimeMinutes() =>
      gameCount > 0 ? DateTime.now().difference(startGameTime).inMinutes : 0;

  int getGameTimeSeconds() => gameCount > 0
      ? DateTime.now().difference(startGameTime).inSeconds % 60
      : 0;

  int getAverageGameTimeSeconds() => gameCount > 0
      ? (DateTime.now().difference(startGameTime).inSeconds / gameCount).floor()
      : 0;
}

// List<ChartBlindData> getChartData() {
//     List<ChartBlindData> list = [];
//     for (int i = 0; i < 20; i++) {
//       int x = i * 5;

//       double timeK = x / 100;
//       print(timeK);
//       timeK *= timeK;

//     //считаем размер малого блайнда
//       int chipsOfOnePlayer = (Poker.allCash / Poker.playersCount).round();
//       print(chipsOfOnePlayer);
//       double y = (chipsOfOnePlayer / 16 * timeK) / chipsOfOnePlayer * 100;
//       print(y);

//       list.add(ChartBlindData(x, y.round()));
//     }
//     return list;
//   }
