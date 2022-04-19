import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_assistant/blind_constructor_page.dart';
import 'package:poker_assistant/progdata.dart';

class PokerOptionsPage extends StatefulWidget {
  @override
  _PokerOptionsPageState createState() => _PokerOptionsPageState();
}

class _PokerOptionsPageState extends State<PokerOptionsPage> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Poker.gameCount == 0 ? Text('Game not started') : Text('Game time: ${Poker.getGameTimeMinutes()} m'),
        elevation: 1.0,
      ),
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                const Divider(),
                Text('Game stats',
                  style: TextStyle(color: Colors.orange, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    SizedBox(width: 50,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rounds count: ${Poker.gameCount}',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                        Text('Game time: ${Poker.getGameTimeMinutes()} m ${Poker.getGameTimeSeconds()} s',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                        Text('Average round time: ${(Poker.getAverageGameTimeSeconds() / 60).floor()} m ${Poker.getAverageGameTimeSeconds() % 60} s',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                        Text('The longest round: ${(Poker.theLongestGameSec / 60).floor()} m ${Poker.theLongestGameSec % 60} s',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                        Text(Poker.theShortestGameSec == 999999 ? 'The shortest round: 0 m 0 s' : 'The shortest round: ${(Poker.theShortestGameSec / 60).floor()} m ${Poker.theShortestGameSec % 60} s',
                          style: TextStyle(color: Colors.black, fontSize: 18),
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
                    controller: TextEditingController(text: '${(Poker.timeLeftSec / 60).floor()}'),
                    decoration: InputDecoration(
                      icon: const Icon(Icons.timer),
                      labelText: 'Left game time (in minutes)',
                    ),
                    onSubmitted: (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Time ${Poker.changeTimeLeft(int.tryParse(value)) ? 'added' : 'removed'}'),
                          duration: Duration(seconds: 1),
                        )
                      );
                    },
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.headline5,
                    controller: TextEditingController(text: '${Poker.allCash}'),
                    decoration: InputDecoration(
                      icon: const Icon(Icons.attach_money),
                      labelText: 'Total cash of the game',
                    ),
                    onSubmitted: (value) {
                      int d = Poker.allCash;
                      Poker.allCash = int.tryParse(value);
                      d = Poker.allCash - d;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: d > 0 ? Text('+$d to cash') : Text('$d to cash'),
                          duration: Duration(seconds: 1),
                        )
                      );
                    },
                  ),
                ),
                const Divider(),
                Text('Players count - ${Poker.playersCount}',
                  style: TextStyle(color: Colors.orange, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Slider(
                  value: Poker.playersCount.toDouble(),
                  min: 2,
                  max: 8,
                  divisions: 6,
                  label: '${Poker.playersCount}',
                  onChanged: (value) {
                    Poker.playersCount = value.toInt();
                    setState(() {});
                  },
                ),
                const Divider(),
                Text('View mode',
                  style: TextStyle(color: Colors.orange, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Slider(
                  value: Poker.viewMode.toDouble(),
                  min: 1,
                  max: 3,
                  divisions: 2,
                  onChanged: (value) {
                    Poker.viewMode = value.toInt();
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
                          builder: (_) => BlindConstructorPage(),
                        ),
                      );
                    },
                    child: Text('Blind constructor'),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(
                    onPressed: Poker.gameCount == 0 ? null : () {
                      Poker.needResetLittleBlind = true;
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Value changed'),
                          duration: Duration(seconds: 1),
                        )
                      );
                    },
                    child: Text('Reset little blind'),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(
                    onPressed: Poker.gameCount == 0 ? null : () {
                      Poker.startNextGame(restart: true);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Poker.timeLeftSec > 0 ? Text('${(Poker.timeLeftSec / 60).round()} minutes left') : Text('No time left'),
                          duration: Duration(seconds: 3),
                        )
                      );
                    },
                    child: Text('Restart a round'),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(
                    onPressed: Poker.gameCount == 0 ? null : () {
                      Poker.stopTheGame();
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Time & little blind updated'),
                          duration: Duration(seconds: 2),
                        )
                      );
                    },
                    child: Text('Stop the game'),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5.0),
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(40.0),
                child: Text('Start Next Round',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                if (Poker.gameCount == 0 || DateTime.now().difference(Poker.startACurrentGameTime).inSeconds > 10) {
                  Poker.startNextGame();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Poker.timeLeftSec > 0 ? Text('${(Poker.timeLeftSec / 60).round()} minutes left') : Text('No time left'),
                      duration: Duration(seconds: 3),
                    )
                  );
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Nope ;) Wait ${11 - DateTime.now().difference(Poker.startACurrentGameTime).inSeconds} seconds'),
                      duration: Duration(seconds: 1),
                    )
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}