import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:poker_assistant/game_data.dart';

class BlindConstructorPage extends StatefulWidget {
  const BlindConstructorPage({Key? key}) : super(key: key);

  @override
  _BlindConstructorPageState createState() => _BlindConstructorPageState();
}

class _BlindConstructorPageState extends State<BlindConstructorPage> {
  final poker = GameData.instance;

  int _divider = GameData.instance.blindGrowDivider;
  int _power = GameData.instance.blindGrowPower;
  double _minLittleBlindPercent = GameData.instance.minLittleBlindPerc;
  int _mChipVal = GameData.instance.minChipValue;

  int _currentStartBigBlindValue = 0;
  int _currentMiddleBigBlindValue = 0;
  int _currentEndBigBlindValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blind constructor')),
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          const SizedBox(height: 8),
          const Text(
            'BIG BLIND chart',
            style: TextStyle(color: Colors.orange, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: charts.LineChart(
              _createSampleData(),
              animate: false,
            ),
          ),
          const Divider(),
          const FittedBox(
            child: Text(
              'Expected BIG BLIND values',
              style: TextStyle(color: Colors.orange, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'First round: $_currentStartBigBlindValue (stack eff. - ${(poker.allCash / poker.playersCount / _currentStartBigBlindValue).floor()} bb)',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Middle game: $_currentMiddleBigBlindValue (stack eff. - ${(poker.allCash / poker.playersCount / _currentMiddleBigBlindValue).floor()} bb)',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Last round: $_currentEndBigBlindValue (stack eff. - ${(poker.allCash / poker.playersCount / _currentEndBigBlindValue).floor()} bb)',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          FittedBox(
            child: Text(
              'Minimum LITTLE BLIND value - $_minLittleBlindPercent%',
              style: const TextStyle(color: Colors.orange, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Slider(
            value: _minLittleBlindPercent,
            max: 10,
            divisions: 20,
            onChanged: (value) {
              setState(() {
                _minLittleBlindPercent = value;
              });
            },
          ),
          //const Divider(),
          Text(
            'Blinds grow power - $_power',
            style: const TextStyle(color: Colors.orange, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Slider(
            value: _power.toDouble(),
            min: 1,
            max: 6,
            divisions: 5,
            onChanged: (value) {
              _power = value.toInt();
              setState(() {});
            },
          ),
          //const Divider(),
          Text(
            'Blinds grow divider - $_divider',
            style: const TextStyle(color: Colors.orange, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Slider(
            value: _divider.toDouble(),
            min: 2,
            max: 20,
            divisions: 18,
            onChanged: (value) {
              _divider = value.toInt();
              setState(() {});
            },
          ),
          //const Divider(),
          Text(
            'Blinds add - $_mChipVal',
            style: const TextStyle(color: Colors.orange, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Slider(
            value: _mChipVal == 1 ? 1 : (_mChipVal / 5) + 1,
            min: 1,
            max: 3,
            divisions: 2,
            onChanged: (value) {
              final tmp = value.toInt() - 1;
              _mChipVal = tmp == 0 ? 1 : tmp * 5;
              setState(() {});
            },
          ),
          //const Divider(),
          Text(
            'Minimum chip value - $_mChipVal',
            style: const TextStyle(color: Colors.orange, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Slider(
            value: _mChipVal == 1 ? 1 : (_mChipVal / 5) + 1,
            min: 1,
            max: 3,
            divisions: 2,
            onChanged: (value) {
              final tmp = value.toInt() - 1;
              _mChipVal = tmp == 0 ? 1 : tmp * 5;
              setState(() {});
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: TextField(
          //     keyboardType: TextInputType.number,
          //     style: Theme.of(context).textTheme.headline5,
          //     controller: TextEditingController(text: '${Poker.minLittleBlind}'),
          //     decoration: InputDecoration(
          //       icon: const Icon(Icons.arrow_drop_down),
          //       labelText: 'Minimum little blind value',
          //     ),
          //     onSubmitted: (value) {
          //       Poker.minLittleBlind = int.tryParse(value);
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(
          //           content: Text('Value changed'),
          //           duration: Duration(seconds: 1),
          //         )
          //       );
          //     },
          //   ),
          // ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: ElevatedButton(
              onPressed: () {
                poker
                  ..blindGrowPower = _power
                  ..blindGrowDivider = _divider
                  ..minLittleBlindPerc = _minLittleBlindPercent
                  ..minChipValue = _mChipVal;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Options saved'),
                    duration: Duration(seconds: 1),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Save blind options'),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  List<charts.Series<ChartBlindData, double>> _createSampleData() {
    final data = <ChartBlindData>[];
    for (var iii = 0; iii <= 100; iii++) {
      final xxx = iii * 1;

      final tmpTimeK = xxx / 100;
      var timeK = 1.0;
      for (var iii = 0; iii < _power; iii++) {
        timeK *= tmpTimeK;
      }

      final chipsOfOnePlayer = (poker.allCash / poker.playersCount).round();
      var yyy = (chipsOfOnePlayer / _divider * timeK) / chipsOfOnePlayer * 100;

      if (yyy < _minLittleBlindPercent) {
        yyy = _minLittleBlindPercent;
      }

      //малый блайнд не может быть меньше 1 фишки
      final minMinLBPerc = 1 / chipsOfOnePlayer * 100;
      if (yyy < minMinLBPerc) {
        yyy = minMinLBPerc;
      }

      var yInChipCount = (chipsOfOnePlayer * yyy * 0.01).floor();
      if (yInChipCount % _mChipVal != 0) {
        yInChipCount = ((yInChipCount / _mChipVal).floor() + 1) * _mChipVal;
      }
      if ((chipsOfOnePlayer * yyy * 0.01).floor() != yInChipCount) {
        yyy = yInChipCount / chipsOfOnePlayer * 100;
      }

      if (iii == 1) {
        _currentStartBigBlindValue =
            (chipsOfOnePlayer * yyy * 0.01).round() * 2;
      }
      if (iii == 50) {
        _currentMiddleBigBlindValue =
            (chipsOfOnePlayer * yyy * 0.01).round() * 2;
      }
      if (iii == 100) {
        _currentEndBigBlindValue = (chipsOfOnePlayer * yyy * 0.01).round() * 2;
      }

      data.add(ChartBlindData(xxx.toDouble(), yyy * 2));
    }

    return [
      charts.Series<ChartBlindData, double>(
        id: 'little blind',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (ChartBlindData sales, _) => sales.time,
        measureFn: (ChartBlindData sales, _) => sales.value,
        data: data,
      ),
      charts.Series<ChartBlindData, double>(
        id: 'maxPlanka',
        colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
        domainFn: (ChartBlindData sales, _) => sales.time,
        measureFn: (ChartBlindData sales, _) => sales.value,
        data: [ChartBlindData(0, 100), ChartBlindData(100, 100)],
      ),
      charts.Series<ChartBlindData, double>(
        id: 'minPlanka',
        colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
        domainFn: (ChartBlindData sales, _) => sales.time,
        measureFn: (ChartBlindData sales, _) => sales.value,
        data: [ChartBlindData(0, 0), ChartBlindData(100, 0)],
      ),
    ];
  }
}

class ChartBlindData {
  ChartBlindData(this.time, this.value);

  final double time;
  final double value;
}
