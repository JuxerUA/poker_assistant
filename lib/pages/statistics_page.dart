import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';
import 'package:poker_assistant/widgets/poker_page_scaffold.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with AutomaticKeepAliveClientMixin<StatisticsPage> {  final maxYValue = 80;
final minYValue = 0;
  @override
  bool get wantKeepAlive => true;



  @override
  Widget build(BuildContext context) {
    super.build(context);



    return PokerPageScaffold(
      title: 'Statistics',
      background: PokerColors.grey,
      body: Column(
        children: [
          const Text('in progress..'),
          Center(
            child: SfCartesianChart(
              plotAreaBackgroundColor: PokerColors.grey,
              series: getDefaultData(),
              plotAreaBorderWidth: 0,
              primaryXAxis: DateTimeAxis(
                majorGridLines: const MajorGridLines(width: 0),
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
              ),
              primaryYAxis: NumericAxis(
                interval: 5,
                maximum: maxYValue.toDouble(),
                minimum: minYValue.toDouble(),
                majorGridLines: const MajorGridLines(width: 0),
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
            ),
          ),
        ],
      ),
    );
  }

  List<StepAreaSeries<BlindData, DateTime>> getDefaultData() {
    final blindsData = <BlindData>[
      BlindData(DateTime.fromMillisecondsSinceEpoch(150), 21),
      BlindData(DateTime.fromMillisecondsSinceEpoch(340), 24),
      BlindData(DateTime.fromMillisecondsSinceEpoch(803), 36),
      BlindData(DateTime.fromMillisecondsSinceEpoch(890), 38),
      BlindData(DateTime.fromMillisecondsSinceEpoch(1001), 54),
      BlindData(DateTime.fromMillisecondsSinceEpoch(1545), 57),
      BlindData(DateTime.fromMillisecondsSinceEpoch(1683), 70),
    ];

    final pauseData = <BlindData>[
      BlindData(DateTime.fromMillisecondsSinceEpoch(400), maxYValue),
      BlindData(DateTime.fromMillisecondsSinceEpoch(700), minYValue),
      BlindData(DateTime.fromMillisecondsSinceEpoch(1130), maxYValue),
      BlindData(DateTime.fromMillisecondsSinceEpoch(1500), minYValue),
    ];

    /// https://github.com/syncfusion/flutter-examples/blob/master/lib/samples/chart/cartesian_charts/chart_types/step_area.dart

    return <StepAreaSeries<BlindData, DateTime>>[
      StepAreaSeries<BlindData, DateTime>(
        dataSource: blindsData,
        color: PokerColors.lightBlack,
        borderColor: PokerColors.orange,
        markerSettings: const MarkerSettings(
          isVisible: true,
          shape: DataMarkerType.circle,
          width: 10,
          height: 10,
          color: PokerColors.red,
          borderColor: PokerColors.black,
          borderWidth: 1,
        ),
        name: 'Blinds chart',
        borderWidth: 2,
        xValueMapper: (BlindData sales, _) => sales.time,
        yValueMapper: (BlindData sales, _) => sales.blindValue,
      ),
      StepAreaSeries<BlindData, DateTime>(
        dataSource: pauseData,
        color: PokerColors.yellow.withOpacity(0.5),
        name: 'Pause',
        xValueMapper: (BlindData sales, _) => sales.time,
        yValueMapper: (BlindData sales, _) => sales.blindValue,
      ),
    ];
  }
}

class BlindData {
  BlindData(this.time, this.blindValue);

  final DateTime time;
  final int blindValue;
}
