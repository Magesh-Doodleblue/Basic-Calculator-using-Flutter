import 'package:flutter/material.dart';

import '../../model/history_singleton.dart';

class CalculationHistoryPage extends StatelessWidget {
  final CalculationHistory _calculationHistory = CalculationHistory();

  CalculationHistoryPage({super.key});

  dialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("History"),
          content: const Text("Do you want to Clear all History"),
          actions: [
            TextButton(
              child: const Text("Nope"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Clear History"),
              onPressed: () {
                Navigator.of(context).pop();
                _calculationHistory.removeHistory();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation History'),
        actions: [
          IconButton(
            onPressed: () {
              dialogBox(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      // body: ListView.builder(
      //   itemCount: _calculationHistory.getHistory().length,
      //   itemBuilder: (BuildContext context, int index) {
      //     Map<String, String> calculation =
      //         _calculationHistory.getHistory()[index];
      //     return Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(13),
      //           color: Colors.grey.withOpacity(0.42),
      //         ),
      //         height: 70,
      // child: ListTile(
      //   title: Text(
      //     calculation["text"]!,
      //     style: styleFont(21),
      //   ),
      //   subtitle: Text(
      //     calculation["result"]!,
      //     style: styleFont(18),
      //   ),
      // ),
      //       ),
      //     );
      //   },
      // ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: Future.delayed(const Duration(milliseconds: 0),
            () => CalculationHistory().getHistory()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, String>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, String>> history = snapshot.data!;
            return listViewBuilderForHistory(history);
          }
        },
      ),
    );
  }

  ListView listViewBuilderForHistory(List<Map<String, String>> history) {
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (BuildContext context, int index) {
        Map<String, String> calculation = history[index];
        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Container(
            decoration: containerDecoration(),
            child: ListTile(
              title: Text(
                calculation["text"]!,
                style: styleFont(18),
              ),
              subtitle: Text(
                calculation["result"]!,
                style: styleFont(16),
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration containerDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(9),
      color: Colors.grey.withOpacity(0.32),
    );
  }

  TextStyle styleFont(int size) {
    return TextStyle(
      fontSize: size.toDouble(),
    );
  }
}
