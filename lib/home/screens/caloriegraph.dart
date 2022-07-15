import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class CalorieGraph {
  final double calorieInTake;
  final String totalCalorie;
  final charts.Color barColor;

  CalorieGraph(
      {@required this.calorieInTake,
      @required this.totalCalorie,
      @required this.barColor});
}
