// ignore_for_file: unrelated_type_equality_checks, library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../model/history_singleton.dart';
import '../../utils/constant.dart';
import 'history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String currentOperation;
  late double first, second;
  String res = "";
  String text = "";

  void handleClick(String value) {
    switch (value) {
      case 'History':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CalculationHistoryPage(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          PopupMenuButton<String>(
            tooltip: "History",
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'History'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          inputAndOutput(),
          const Spacer(),
          gridViewBuilderForKeyboard(context),
        ],
      ),
    );
  }

  SizedBox gridViewBuilderForKeyboard(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.4,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.41,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        itemCount: calcButtonList.length,
        itemBuilder: (BuildContext context, int index) {
          String buttonText = calcButtonList[index];
          return Container(
            decoration: containerDecoration(),
            child: customOutlineButton(buttonText),
          );
        },
      ),
    );
  }

  Column inputAndOutput() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        // const Divider(color: Colors.black, thickness: 1),
        Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.topRight,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              res,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration containerDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.black.withOpacity(0.2),
      ),
    );
  }

  Widget customOutlineButton(String val) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: TextButton(
          onPressed: () => btnClicked(val),
          child: Text(
            val,
            style: TextStyle(
              fontSize: val == "CLEAR"
                  ? 15
                  : val == "DEL"
                      ? 18
                      : 24,
              fontWeight: val == "CLEAR" || val == "DEL"
                  ? FontWeight.bold
                  : FontWeight.w500,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
    );
  }

  void btnClicked(String btnText) {
    if (btnText == "CLEAR") {
      setState(() {
        text = "";
        res = "";
      });
    } else if (btnText == "+" ||
        btnText == "-" ||
        btnText == "x" ||
        btnText == "/") {
      setState(() {
        if (text.isNotEmpty) {
          text += " $btnText ";
        }
      });
    } else if (btnText == "=") {
      setState(() {
        if (text.isNotEmpty) {
          List<String> parts = text.split(" ");
          if (parts.length >= 3) {
            double result = double.parse(parts[0]);
            String op = "";
            for (int i = 1; i < parts.length; i++) {
              String part = parts[i];
              if (part == "+" || part == "-" || part == "x" || part == "/") {
                op = part;
              } else {
                double num = double.parse(part);
                if (op == "+") {
                  result += num;
                } else if (op == "-") {
                  result -= num;
                } else if (op == "x") {
                  result *= num;
                } else if (op == "/") {
                  result /= num;
                } else {
                  result = num;
                }
              }
            }
            if (result % 1 == 0) {
              res = result.toInt().toString();
            } else {
              res = result
                  .toStringAsFixed(2)
                  .replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
            }
            CalculationHistory().addCalculation({"text": text, "result": res});
          } else {
            res = text;
          }
        }
      });
    } else if (btnText == "DEL") {
      setState(() {
        if (text.isNotEmpty) {
          text = text.substring(0, text.length - 1);
        }
      });
    } else if (btnText == "%") {
      setState(() {
        if (text.isNotEmpty) {
          List<String> parts = text.split(" ");
          if (parts.length >= 1) {
            double num = double.parse(parts.last);
            num /= 100;
            text = text.substring(0, text.length - parts.last.length) +
                num.toString();
          }
        }
      });
    } else {
      setState(() {
        if (btnText == "0" && text.isEmpty && text.startsWith("0")) {
          text = "0 +$text";
        } else {
          text += btnText;
        }
      });
    }
  }
}
