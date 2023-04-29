// ignore_for_file: unrelated_type_equality_checks, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../model/history_singleton.dart';
import '../../utils/constant.dart';
import 'history.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleDarkMode;
  final bool isDarkEnable;

  const HomePage(
      {Key? key, required this.toggleDarkMode, required this.isDarkEnable})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          IconButton(
            onPressed: widget.toggleDarkMode,
            icon: Icon(widget.isDarkEnable ? Icons.dark_mode : Icons.sunny),
          ),
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
          Align(alignment: Alignment.topRight, child: inputAndOutput()),
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
          return InkWell(
            onTap: () {
              btnClicked(buttonText);
            },
            child: Container(
              decoration: containerDecoration(context),
              child: customOutlineButton(buttonText),
            ),
          );
        },
      ),
    );
  }

  Column inputAndOutput() {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedDefaultTextStyle(
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: isEqualto ? 48 : 36,
              fontWeight: FontWeight.w500,
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            duration: const Duration(milliseconds: 200),
            child: Text(
              text,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedDefaultTextStyle(
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: isEqualto ? 36 : 48,
              fontWeight: FontWeight.w500,
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            duration: const Duration(milliseconds: 200),
            child: Text(
              res,
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration containerDecoration(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
      border: Border.all(
        width: 1,
        color: theme.brightness == Brightness.dark
            ? Colors.white.withOpacity(0.2)
            : Colors.black.withOpacity(0.2),
      ),
    );
  }

  Widget customOutlineButton(String val) {
    final theme = Theme.of(context);

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Text(
          val,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: val == "CLEAR"
                ? 15
                : val == "DEL"
                    ? 18
                    : 24,
            fontWeight: val == "CLEAR" || val == "DEL"
                ? FontWeight.bold
                : FontWeight.w500,
            // color: const Color.fromARGB(255, 0, 0, 0),
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }

  void btnClicked(String btnText) {
    if (btnText == "CLEAR") {
      setState(() {
        isEqualto = true;
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
        isEqualto = false;
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
          if (parts.isNotEmpty) {
            double num = double.parse(parts.last);
            num /= 100;
            text = text.substring(0, text.length - parts.last.length) +
                num.toString();
          }
        }
      });
    } else {
      setState(() {
        text += btnText;
      });
    }
  }
}
