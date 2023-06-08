// ignore_for_file: unused_import

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
  //creating instance for singletonclass.

  dialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //dialogbox name is AlertDialog.
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.blackColor
              : AppColors.whiteColor,
          //checkiing theme for showing dialogbox color.
          title: Text(
            "Clear History",
            style: dialogTextStyle(context, 22),
          ),
          content: SizedBox(
            width: 600, //dialogbox width
            // height: 100.0,
            child: Text(
              "Do you want to Clear all History?",
              style: dialogTextStyle(context, 17),
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Nope",
                style: dialogTextStyle(context, 16),
              ),
              onPressed: () {
                Navigator.of(context).pop(); //closes the dialogbox
              },
            ),
            TextButton(
              child: Text(
                "Clear History",
                style: dialogTextStyle(context, 16),
              ),
              onPressed: () {
                _calculationHistory.removeHistory();
                setState(() {
                  isDialogData = !isDialogData;
                });
                //delete all the values in singleton class of map for calc history.
                Navigator.of(context).pop(); //closes the dialogbox
                ShowFlutterToast().showToast("Calculation deleted", context);
              },
            ),
          ],
        );
      },
    );
  }

  bool isDialogData = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation History'),
        actions: [
          IconButton(
            onPressed: () {
              dialogBox(context); //calling dialogbox when clicking delete icon
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: isDialogData
          ? futureBuilderForGettingHistory()
          : futureBuilderForGettingHistory(),
    );
  }

  FutureBuilder<List<Map<String, String>>> futureBuilderForGettingHistory() {
    return FutureBuilder<List<Map<String, String>>>(
      future: Future.delayed(const Duration(milliseconds: 0),
          () => CalculationHistory().getHistory()),
      //frequently calling the getHistory() data inside of singketon class. when the data changes it reflected in the UI simultaneouly.
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, String>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'), //showinig error in UI
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
                      //showing gif for each themes by checking the brightness.
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
    );
  }

  SingleChildScrollView listViewBuilderForHistory(
      List<Map<String, String>> history) {
    return SingleChildScrollView(
      reverse: false, //change the focus to reverse in listview builder
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            reverse: true,
            //to show the items in the UI reverse order.
            physics: const NeverScrollableScrollPhysics(), //used to scroll
            itemCount: history.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, String> calculation = history[index];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    history.removeAt(index);
                    //remove the item inside of map when user swipes in UI.
                  });
                  //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  // content: Text("Calculation deleted"),
                  // duration: Duration(seconds: 1)));
                  ShowFlutterToast().showToast("Calculation deleted", context);
                  //toast for deleting
                },
                direction: DismissDirection.endToStart,
                background: Container(
                  color: AppColors.bgColorForListtile,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: AppColors.whiteColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Container(
                    decoration: containerDecoration(),
                    child: ListTile(
                      title: listTextForHistory(calculation),
                      //calculation inputs in UI
                      subtitle: listSubTextForHistory(calculation),
                      //calculation result in UI
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
