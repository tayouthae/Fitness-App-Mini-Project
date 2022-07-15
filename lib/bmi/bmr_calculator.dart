class BMRcalculator {
  final int height;
  final int weight;
  final int age;
  final String gender;

  double lowActive = 1.5;
  double moderateActive = 1.7;
  double highActive = 1.9;

  double _bmr;
  double _weight;

  BMRcalculator({this.height, this.weight, this.gender, this.age});

  String calculateBMR() {
    if (gender == "Male") {
      _bmr = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
      return _bmr.toStringAsFixed(1);
    } else if (gender == "Female") {
      _bmr = 655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age);
      return _bmr.toStringAsFixed(1);
    } else {
      return "Please Select Gender";
    }
  }

  String weightLoss() {
    _weight = ((_bmr * lowActive) - 500);

    return _weight.toStringAsFixed(1);
  }
}
