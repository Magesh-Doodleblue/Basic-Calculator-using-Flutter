class CalculationHistory {
  static final CalculationHistory _instance = CalculationHistory._internal();

  final List<Map<String, String>> _history = [];

  factory CalculationHistory() {
    return _instance;
  }

  CalculationHistory._internal();

  void addCalculation(Map<String, String> calculation) {
    _history.add(calculation);
  }

  List<Map<String, String>> getHistory() {
    return _history;
  }

  void removeHistory() {
    _history.clear();
  }
}
