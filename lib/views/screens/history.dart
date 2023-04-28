import 'package:flutter/material.dart';

import '../../model/history_singleton.dart';

class CalculationHistoryPage extends StatelessWidget {
  final CalculationHistory _calculationHistory = CalculationHistory();

  CalculationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation History'),
        actions: [
          TextButton(
            onPressed: () {
              _calculationHistory.removeHistory();
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _calculationHistory.getHistory().length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, String> calculation =
              _calculationHistory.getHistory()[index];
          return ListTile(
            title: Text(calculation["text"]!),
            subtitle: Text(calculation["result"]!),
          );
        },
      ),
    );
  }
}
