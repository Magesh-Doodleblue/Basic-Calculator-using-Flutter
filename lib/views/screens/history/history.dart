import 'package:flutter/material.dart';
import '../../../model/history_singleton.dart';
import '../../../utils/colors.dart';
import '../../../utils/history_styles.dart';
import '../../../utils/theme.dart';
import '../../../utils/toast.dart';

class CalculationHistoryPage extends StatefulWidget {
  const CalculationHistoryPage({super.key});

  @override
  State<CalculationHistoryPage> createState() => _CalculationHistoryPageState();
}

class _CalculationHistoryPageState extends State<CalculationHistoryPage> {
  final CalculationHistory _calculationHistory = CalculationHistory();

  dialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? blackColor
              : whiteColor,
          title: Text(
            "Clear History",
            style: dialogTextStyle(context, 24),
          ),
          content: SizedBox(
            width: 600,
            // height: 100.0,
            child: Text(
              "Do you want to Clear all History?",
              style: dialogTextStyle(context, 19),
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Nope",
                style: dialogTextStyle(context, 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Clear History",
                style: dialogTextStyle(context, 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _calculationHistory.removeHistory();
              },
            ),
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
            return history.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Theme.of(context).brightness == Brightness.dark
                            ? Image.asset("assets/no_history_dark.gif")
                            : Image.asset("assets/no_history_light.gif"),
                        Text(
                          'No history available',
                          style: dialogTextStyle(context, 24),
                        ),
                      ],
                    ),
                  )
                : listViewBuilderForHistory(history);
          }
        },
      ),
    );
  }

  SingleChildScrollView listViewBuilderForHistory(
      List<Map<String, String>> history) {
    return SingleChildScrollView(
      reverse: false,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: history.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, String> calculation = history[index];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    history.removeAt(index);
                  });
                  //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  // content: Text("Calculation deleted"),
                  // duration: Duration(seconds: 1)));
                  showToast("Calculation deleted", context);
                },
                direction: DismissDirection.endToStart,
                background: Container(
                  color: bgColorForListtile,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: whiteColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Container(
                    decoration: containerDecoration(),
                    child: ListTile(
                      title: listTextForHistory(calculation),
                      subtitle: listSubTextForHistory(calculation),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
