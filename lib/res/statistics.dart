class Statistics {
  Statistics._();

  static final instance = Statistics._();

  final blindStat = <BlindStatItem>[];
  final pauseStat = <PauseStatItem>[];
}

class BlindStatItem {
  BlindStatItem(this.time, this.blindValue);

  final DateTime time;
  final int blindValue;
}

class PauseStatItem {
  PauseStatItem(this.time, {required this.pauseEnabled});

  final DateTime time;
  final bool pauseEnabled;
}
