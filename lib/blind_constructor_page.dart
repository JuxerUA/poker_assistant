import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:poker_assistant/progdata.dart';

class BlindConstructorPage extends StatefulWidget {

  @override
  _BlindConstructorPageState createState() => _BlindConstructorPageState();

 
}

class _BlindConstructorPageState extends State<BlindConstructorPage> {
  int _divider = Poker.blindGrowDivider;
  int _power = Poker.blindGrowPower;
  double _minLittleBlindPerc = Poker.minLittleBlindPerc;
  int _mChipVal = Poker.minChipValue;

  int _currentStartBigBlindValue = 0;
  int _currentMiddleBigBlindValue = 0;
  int _currentEndBigBlindValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blind constructor')),
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          SizedBox(height: 8),
           Text('BIG BLIND chart',
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
          FittedBox(
            child: Text('Expected BIG BLIND values',
              style: TextStyle(color: Colors.orange, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              SizedBox(width: 50,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('First round: $_currentStartBigBlindValue (stack eff. - ${(Poker.allCash / Poker.playersCount / _currentStartBigBlindValue).floor()} bb)',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  Text('Middle game: $_currentMiddleBigBlindValue (stack eff. - ${(Poker.allCash / Poker.playersCount / _currentMiddleBigBlindValue).floor()} bb)',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  Text('Last round: $_currentEndBigBlindValue (stack eff. - ${(Poker.allCash / Poker.playersCount / _currentEndBigBlindValue).floor()} bb)',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          FittedBox(
            child: Text('Minimum LITTLE BLIND value - $_minLittleBlindPerc%',
              style: TextStyle(color: Colors.orange, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Slider(
            value: _minLittleBlindPerc,
            min: 0,
            max: 10,
            divisions: 20,
            onChanged: (value) {
              _minLittleBlindPerc = value;
              setState(() {});
            },
          ),
          //const Divider(),
          Text('Blinds grow power - $_power',
            style: TextStyle(color: Colors.orange, fontSize: 20),
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
          Text('Blinds grow divider - $_divider',
            style: TextStyle(color: Colors.orange, fontSize: 20),
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
          Text('Blinds add - $_mChipVal',
            style: TextStyle(color: Colors.orange, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Slider(
            value: _mChipVal == 1 ? 1 : (_mChipVal / 5) + 1,
            min: 1,
            max: 3,
            divisions: 2,
            onChanged: (value) {
              int tmp = value.toInt() - 1;
              _mChipVal = tmp == 0 ? 1 : tmp * 5;
              setState(() {});
            },
          ),
          //const Divider(),
          Text('Minimum chip value - $_mChipVal',
            style: TextStyle(color: Colors.orange, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Slider(
            value: _mChipVal == 1 ? 1 : (_mChipVal / 5) + 1,
            min: 1,
            max: 3,
            divisions: 2,
            onChanged: (value) {
              int tmp = value.toInt() - 1;
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
                Poker.blindGrowPower = _power;
                Poker.blindGrowDivider = _divider;
                Poker.minLittleBlindPerc = _minLittleBlindPerc;
                Poker.minChipValue = _mChipVal;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Options saved'),
                    duration: Duration(seconds: 1),
                  )
                );
                Navigator.pop(context);
              },
              child: Text('Save blind options'),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  List<charts.Series<ChartBlindData, double>> _createSampleData() {
    List<ChartBlindData> data = [];
    for (int i = 0; i <= 100; i++) {
      int x = i * 1;

      double tmpTimeK = x / 100;
      double timeK = 1;
      for (int i = 0; i < _power; i++) timeK *= tmpTimeK; 

      int chipsOfOnePlayer = (Poker.allCash / Poker.playersCount).round();
      double y = (chipsOfOnePlayer / _divider * timeK) / chipsOfOnePlayer * 100;

      if (y < _minLittleBlindPerc) y = _minLittleBlindPerc;

      //малый блайнд не может быть меньше 1 фишки
      double minMinLBPerc = 1 / chipsOfOnePlayer * 100; 
      if (y < minMinLBPerc) y = minMinLBPerc;

      int yInChipCount = (chipsOfOnePlayer * y * 0.01).floor();
      if (yInChipCount % _mChipVal != 0) {
        yInChipCount = ((yInChipCount / _mChipVal).floor() + 1) * _mChipVal;
      }
      if ((chipsOfOnePlayer * y * 0.01).floor() != yInChipCount) y = yInChipCount / chipsOfOnePlayer * 100;

      if (i == 1) _currentStartBigBlindValue = (chipsOfOnePlayer * y * 0.01).round() * 2;
      if (i == 50) _currentMiddleBigBlindValue = (chipsOfOnePlayer * y * 0.01).round() * 2;
      if (i == 100) _currentEndBigBlindValue = (chipsOfOnePlayer * y * 0.01).round() * 2;

      data.add(ChartBlindData(x.toDouble(), y * 2));
    }

    return [
      new charts.Series<ChartBlindData, double>(
        id: 'little blind',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (ChartBlindData sales, _) => sales.time,
        measureFn: (ChartBlindData sales, _) => sales.value,
        data: data,
      ),
      new charts.Series<ChartBlindData, double>(
        id: 'maxPlanka',
        colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
        domainFn: (ChartBlindData sales, _) => sales.time,
        measureFn: (ChartBlindData sales, _) => sales.value,
        data: [ChartBlindData(0, 100), ChartBlindData(100, 100)],
      ),
      new charts.Series<ChartBlindData, double>(
        id: 'minPlanka',
        colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
        domainFn: (ChartBlindData sales, _) => sales.time,
        measureFn: (ChartBlindData sales, _) => sales.value,
        data: [ChartBlindData(0, 0), ChartBlindData(100, 0)],
      )
    ];
  }
}

class ChartBlindData {
  final double time;
  final double value;

  ChartBlindData(this.time, this.value);
}