import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_assistant/poker.dart';
import 'package:poker_assistant/poker_options_page.dart';

void main() {
  Poker();

  runApp(
    MaterialApp(
      title: 'Poker Assistant',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        backgroundColor: Colors.black,
      ),
      home: const MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _needUpdateGameDrag = false;
  Color bgColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      backgroundColor: bgColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragStart: (_) {
          _needUpdateGameDrag = true;
        },
        onVerticalDragUpdate: (dragUpdateDetails) {
          if (dragUpdateDetails.delta.distance > 3 && _needUpdateGameDrag) {
            if (Poker.gameCount > 0) {
              if (DateTime.now()
                      .difference(Poker.startACurrentGameTime)
                      .inSeconds >
                  10) {
                Poker.startNextGame();
                bgColor = Poker.valueColor;
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Poker.timeLeftSec > 0
                        ? Text(
                            'Start new round. ${(Poker.timeLeftSec / 60).round()} minutes left',
                          )
                        : const Text('Start new round. No time left'),
                    duration: const Duration(seconds: 3),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Nope ;) Wait ${11 - DateTime.now().difference(Poker.startACurrentGameTime).inSeconds} seconds',
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
          SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        },
        child: Center(
          child: Poker.viewMode == 1
              ? FittedBox(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 50),
                        Text(
                          '${Poker.currentLittleBlind * 2}',
                          style: TextStyle(
                            fontSize: 250,
                            color: Poker.valueColor,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(width: 50),
                        Text(
                          '${Poker.currentLittleBlind}',
                          style: TextStyle(
                            fontSize: 100,
                            color: Poker.valueColor,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(width: 50),
                      ],
                    ),
                  ),
                )
              : Poker.viewMode == 2
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'BIG\nBLIND',
                          style: TextStyle(
                            fontSize: 80,
                            color: Poker.valueColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              const SizedBox(width: 50),
                              Text(
                                '${Poker.currentLittleBlind * 2}',
                                style: TextStyle(
                                  fontSize: 200,
                                  height: 0.5,
                                  color: Poker.valueColor,
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
                            color: Poker.valueColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              const SizedBox(width: 50),
                              Text(
                                '${Poker.currentLittleBlind}',
                                style: TextStyle(
                                  fontSize: 90,
                                  height: 0.1,
                                  color: Poker.valueColor,
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
                                  '${Poker.currentLittleBlind * 2}',
                                  style: TextStyle(
                                    fontSize: 220,
                                    color: Poker.valueColor,
                                    //decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  'BIG BLIND',
                                  style: TextStyle(
                                    height: 0.1,
                                    fontSize: 30,
                                    color: Poker.valueColor,
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
                                      '${Poker.currentLittleBlind}',
                                      style: TextStyle(
                                        fontSize: 100,
                                        color: Poker.valueColor,
                                        //decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    Text(
                                      'LITTLE BLIND',
                                      style: TextStyle(
                                        fontSize: 20,
                                        height: 1,
                                        color: Poker.valueColor,
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
                                      '${Poker.currentLittleBlind}',
                                      style: TextStyle(
                                        fontSize: 100,
                                        color: Poker.valueColor,
                                        //decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    Text(
                                      'LITTLE BLIND',
                                      style: TextStyle(
                                        fontSize: 20,
                                        height: 1,
                                        color: Poker.valueColor,
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
                                  '${Poker.currentLittleBlind * 2}',
                                  style: TextStyle(
                                    fontSize: 220,
                                    color: Poker.valueColor,
                                    //decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  'BIG BLIND',
                                  style: TextStyle(
                                    height: 0.1,
                                    fontSize: 30,
                                    color: Poker.valueColor,
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
