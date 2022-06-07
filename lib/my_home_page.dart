import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_assistant/game_data.dart';
import 'package:poker_assistant/poker_options_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _needUpdateGameDrag = false;
  Color bgColor = Colors.black;

  final poker = GameData.instance;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return Scaffold(
      backgroundColor: bgColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragStart: (_) {
          _needUpdateGameDrag = true;
        },
        onVerticalDragUpdate: (dragUpdateDetails) {
          if (dragUpdateDetails.delta.distance > 3 && _needUpdateGameDrag) {
            if (poker.gameCount > 0) {
              if (DateTime.now()
                      .difference(poker.startACurrentGameTime)
                      .inSeconds >
                  10) {
                poker.startNextGame();
                bgColor = poker.valueColor;
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: poker.timeLeftSec > 0
                        ? Text(
                            'Start new round. ${(poker.timeLeftSec / 60).round()} minutes left',
                          )
                        : const Text('Start new round. No time left'),
                    duration: const Duration(seconds: 3),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Nope ;) Wait ${11 - DateTime.now().difference(poker.startACurrentGameTime).inSeconds} seconds',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Game not started! Please use double tap'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
            _needUpdateGameDrag = false;
          }
        },
        onVerticalDragEnd: (_) {
          bgColor = Colors.black;
          setState(() {});
        },
        onDoubleTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PokerOptionsPage(),
            ),
          ).then((value) {
            setState(() {});
          });

          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          );
        },
        child: Center(
          child: poker.viewMode == 1
              ? FittedBox(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 50),
                        Text(
                          '${poker.currentLittleBlind * 2}',
                          style: TextStyle(
                            fontSize: 250,
                            color: poker.valueColor,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(width: 50),
                        Text(
                          '${poker.currentLittleBlind}',
                          style: TextStyle(
                            fontSize: 100,
                            color: poker.valueColor,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(width: 50),
                      ],
                    ),
                  ),
                )
              : poker.viewMode == 2
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'BIG\nBLIND',
                          style: TextStyle(
                            fontSize: 80,
                            color: poker.valueColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              const SizedBox(width: 50),
                              Text(
                                '${poker.currentLittleBlind * 2}',
                                style: TextStyle(
                                  fontSize: 200,
                                  height: 0.5,
                                  color: poker.valueColor,
                                ),
                              ),
                              const SizedBox(width: 50),
                            ],
                          ),
                        ),
                        Text(
                          'LITTLE\nBLIND',
                          style: TextStyle(
                            fontSize: 50,
                            color: poker.valueColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              const SizedBox(width: 50),
                              Text(
                                '${poker.currentLittleBlind}',
                                style: TextStyle(
                                  fontSize: 90,
                                  height: 0.1,
                                  color: poker.valueColor,
                                ),
                              ),
                              const SizedBox(width: 50),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FittedBox(
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${poker.currentLittleBlind * 2}',
                                  style: TextStyle(
                                    fontSize: 220,
                                    color: poker.valueColor,
                                    //decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  'BIG BLIND',
                                  style: TextStyle(
                                    height: 0.1,
                                    fontSize: 30,
                                    color: poker.valueColor,
                                    //decoration: TextDecoration.underline,
                                  ),
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
                                      '${poker.currentLittleBlind}',
                                      style: TextStyle(
                                        fontSize: 100,
                                        color: poker.valueColor,
                                        //decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    Text(
                                      'LITTLE BLIND',
                                      style: TextStyle(
                                        fontSize: 20,
                                        height: 1,
                                        color: poker.valueColor,
                                        //decoration: TextDecoration.underline,
                                      ),
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
                                      '${poker.currentLittleBlind}',
                                      style: TextStyle(
                                        fontSize: 100,
                                        color: poker.valueColor,
                                        //decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    Text(
                                      'LITTLE BLIND',
                                      style: TextStyle(
                                        fontSize: 20,
                                        height: 1,
                                        color: poker.valueColor,
                                        //decoration: TextDecoration.underline,
                                      ),
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
                                  '${poker.currentLittleBlind * 2}',
                                  style: TextStyle(
                                    fontSize: 220,
                                    color: poker.valueColor,
                                    //decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  'BIG BLIND',
                                  style: TextStyle(
                                    height: 0.1,
                                    fontSize: 30,
                                    color: poker.valueColor,
                                    //decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
