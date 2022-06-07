import 'package:flutter/material.dart';
import 'package:poker_assistant/blind_constructor_page.dart';
import 'package:poker_assistant/game_data.dart';

class PokerOptionsPage extends StatefulWidget {
  const PokerOptionsPage({Key? key}) : super(key: key);

  @override
  _PokerOptionsPageState createState() => _PokerOptionsPageState();
}

class _PokerOptionsPageState extends State<PokerOptionsPage> {
  final poker = GameData.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: poker.gameCount == 0
            ? const Text('Game not started')
            : Text('Game time: ${poker.getGameTimeMinutes()} m'),
        elevation: 1,
      ),
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                const Divider(),
                const Text(
                  'Game stats',
                  style: TextStyle(color: Colors.orange, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    const SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rounds count: ${poker.gameCount}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Game time: ${poker.getGameTimeMinutes()} m ${poker.getGameTimeSeconds()} s',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Average round time: ${(poker.getAverageGameTimeSeconds() / 60).floor()} m ${poker.getAverageGameTimeSeconds() % 60} s',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'The longest round: ${(poker.theLongestGameSec / 60).floor()} m ${poker.theLongestGameSec % 60} s',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          poker.theShortestGameSec == 999999
                              ? 'The shortest round: 0 m 0 s'
                              : 'The shortest round: ${(poker.theShortestGameSec / 60).floor()} m ${poker.theShortestGameSec % 60} s',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.headline5,
                    controller: TextEditingController(
                      text: '${(poker.timeLeftSec / 60).floor()}',
                    ),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.timer),
                      labelText: 'Left game time (in minutes)',
                    ),
                    onSubmitted: (value) {
                      final leftTime = int.tryParse(value);
                      if (leftTime != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Time ${poker.changeTimeLeft(leftTime) ? 'added' : 'removed'}',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.headline5,
                    controller: TextEditingController(text: '${poker.allCash}'),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.attach_money),
                      labelText: 'Total cash of the game',
                    ),
                    onSubmitted: (value) {
                      final newCashValue = int.tryParse(value);
                      if (newCashValue != null) {
                        final delta = newCashValue - poker.allCash;
                        poker.allCash = newCashValue;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: delta > 0
                                ? Text('+$delta to cash')
                                : Text('$delta to cash'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const Divider(),
                Text(
                  'Players count - ${poker.playersCount}',
                  style: const TextStyle(color: Colors.orange, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Slider(
                  value: poker.playersCount.toDouble(),
                  min: 2,
                  max: 8,
                  divisions: 6,
                  label: '${poker.playersCount}',
                  onChanged: (value) {
                    poker.playersCount = value.toInt();
                    setState(() {});
                  },
                ),
                const Divider(),
                const Text(
                  'View mode',
                  style: TextStyle(color: Colors.orange, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Slider(
                  value: poker.viewMode.toDouble(),
                  min: 1,
                  max: 3,
                  divisions: 2,
                  onChanged: (value) {
                    poker.viewMode = value.toInt();
                    setState(() {});
                  },
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BlindConstructorPage(),
                        ),
                      );
                    },
                    child: const Text('Blind constructor'),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(
                    onPressed: poker.gameCount == 0
                        ? null
                        : () {
                            poker.needResetLittleBlind = true;
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Value changed'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                    child: const Text('Reset little blind'),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(
                    onPressed: poker.gameCount == 0
                        ? null
                        : () {
                            poker.startNextGame(restart: true);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: poker.timeLeftSec > 0
                                    ? Text(
                                        '${(poker.timeLeftSec / 60).round()} minutes left',
                                      )
                                    : const Text('No time left'),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          },
                    child: const Text('Restart a round'),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(
                    onPressed: poker.gameCount == 0
                        ? null
                        : () {
                            poker.stopTheGame();
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Time & little blind updated'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                    child: const Text('Stop the game'),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5),
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(40),
                child: const Text(
                  'Start Next Round',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                if (poker.gameCount == 0 ||
                    DateTime.now()
                            .difference(poker.startACurrentGameTime)
                            .inSeconds >
                        10) {
                  poker.startNextGame();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: poker.timeLeftSec > 0
                          ? Text(
                              '${(poker.timeLeftSec / 60).round()} minutes left',
                            )
                          : const Text('No time left'),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
