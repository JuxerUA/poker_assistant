import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:poker_assistant/constants.dart';
import 'package:poker_assistant/game_data.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  final _game = GameData.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Row(
        children: [
          /// Number of players
          const RotatedBox(
            quarterTurns: 3,
            child: Text(
              'Number of players',
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ),
          ),
          const SizedBox(width: 6),
          NumberPicker(
            minValue: kMinPlayersCount,
            maxValue: kMaxPlayersCount,
            itemWidth: 30,
            value: _game.playersCount,
            onChanged: (count) => _game.playersCount = count,
            haptics: true,
          ),

          /// Number of players
          const RotatedBox(
            quarterTurns: 3,
            child: Text(
              'Number of players',
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ),
          ),
          const SizedBox(width: 6),
          NumberPicker(
            minValue: kMinPlayersCount,
            maxValue: kMaxPlayersCount,
            itemWidth: 30,
            value: _game.playersCount,
            onChanged: (count) => _game.playersCount = count,
            haptics: true,
          ),

          /// Number of players
          const RotatedBox(
            quarterTurns: 3,
            child: Text(
              'Number of players',
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ),
          ),
          const SizedBox(width: 6),
          NumberPicker(
            minValue: kMinPlayersCount,
            maxValue: kMaxPlayersCount,
            itemWidth: 30,
            value: _game.playersCount,
            onChanged: (count) => _game.playersCount = count,
            haptics: true,
          ),
        ],
      ),
    );
  }
}
