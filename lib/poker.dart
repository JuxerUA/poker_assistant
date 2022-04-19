import 'package:flutter/material.dart';

class Poker {
  Poker() {
    startGameTime = DateTime.now();
    valueColor = Colors.grey;
  }

  static int allGameTimeSec = 3600;
  static int timeLeftSec = 3600;
  static int allCash = 1000;
  static int playersCount = 2;
  static int viewMode = 3;
  static int minChipValue = 1;
  static int minLittleBlind = 5;
  static double minLittleBlindPerc = 1.5;
  static int currentLittleBlind = 0;
  static DateTime startGameTime;
  static DateTime startACurrentGameTime;
  static Color valueColor;
  static int gameCount = 0;
  static int theLongestGameSec = 0;
  static int theShortestGameSec = 999999;
  static bool needResetLittleBlind = false;

  static int blindGrowDivider = 6;
  static int blindGrowPower = 3;

  static void startNextGame({bool restart = false}) {
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

    valueColor = timeLeftSec > 0 ? Colors.orange : Colors.red[900];
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
  static int littleBlindCalculator(
    double timePerc,
    double averagePlayerCash,
    double minPerc,
    double addPerc,
    int growDivider,
    int growPower,
  ) {
    var timeK = 1.0;
    for (int i = 0; i < growPower; i++) timeK *= timePerc;

    final newLittleBlind = (averagePlayerCash / growDivider * timeK).round();
    if (newLittleBlind > currentLittleBlind)
      currentLittleBlind = newLittleBlind;

    minLittleBlind = (averagePlayerCash * minPerc).round();

    if (currentLittleBlind < minLittleBlind) {
      currentLittleBlind = minLittleBlind;
    }
    if (currentLittleBlind % minChipValue != 0) {
      currentLittleBlind =
          ((currentLittleBlind / minChipValue).floor() + 1) * minChipValue;
    }
  }

  static bool changeTimeLeft(int newTimeLeftMin) {
    final dTimeSec = newTimeLeftMin * 60 - timeLeftSec;
    allGameTimeSec += dTimeSec;
    timeLeftSec = newTimeLeftMin * 60;

    return dTimeSec >= 0;
  }

  static void stopTheGame() {
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

  static int getGameTimeMinutes() =>
      gameCount > 0 ? DateTime.now().difference(startGameTime).inMinutes : 0;

  static int getGameTimeSeconds() => gameCount > 0
      ? DateTime.now().difference(startGameTime).inSeconds % 60
      : 0;

  static int getAverageGameTimeSeconds() => gameCount > 0
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
