// ignore_for_file: unrelated_type_equality_checks, library_private_types_in_public_api

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:calculator/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../model/history_singleton.dart';
import '../../../utils/constant.dart';
import '../../../utils/homepage_styles.dart';
import '../history/history.dart';

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
  void showNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'important_channel',
        title: 'New Notification',
        body:
            'You have a new message You have a new message You have a new message You have a new message',
        notificationLayout: NotificationLayout.BigPicture,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'History':
        showNotification();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CalculationHistoryPage()));
        // page navigation to calculator history
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
            //toggle function for darkmode value getting and changing
            icon: Icon(widget.isDarkEnable ? Icons.dark_mode : Icons.sunny),
          ),
          PopupMenuButton<String>(
            tooltip: "Options",
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'History'}.map(
                (String choice) {
                  //add more items in option menu by add extra items inside of return statement with the "history".
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                },
              ).toList();
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
        itemCount: calcButtonList.length, //length for gridview builder.
        itemBuilder: (BuildContext context, int index) {
          String buttonText = calcButtonList[index];
          return InkWell(
            //used for gesture detection in smooth way
            onTap: () {
              btnClicked(buttonText);
              //calling the function whenever the user clicks any button in UI of gridview builder.
            },
            child: Container(
              //creating each container for calc buttons
              decoration: gridContainerDecoration(context),
              //decoration in separate file
              child: customOutlineButton(buttonText),
            ),
          );
        },
      ),
    );
  }

  Column inputAndOutput() {
    final theme = Theme.of(context); //theme variable for chceking theme
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedDefaultTextStyle(
            //used for transition of text and has duration of 200ms
            textAlign: TextAlign.end,
            style: GoogleFonts.poppins(
              fontSize: isEqualto ? 48 : 36,
              fontWeight: FontWeight.w500,
              color:
                  theme.brightness == Brightness.dark ? whiteColor : blackColor,
              //checking theme for lightmode and darkmode
            ),
            duration: const Duration(milliseconds: 200),
            child: Text(
              text, //Given input by the USER in UI.
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedDefaultTextStyle(
            //used for transition of text and has duration of 200ms
            textAlign: TextAlign.end,
            style: GoogleFonts.poppins(
              fontSize: isEqualto ? 36 : 48,
              fontWeight: FontWeight.w500,
              color:
                  theme.brightness == Brightness.dark ? whiteColor : blackColor,
              //checking theme for lightmode and darkmode
            ),
            duration: const Duration(milliseconds: 200),
            child: Text(
              res, //Results of calculation in UI.
            ),
          ),
        ),
      ],
    );
  }

  Widget customOutlineButton(String val) {
    final theme = Theme.of(context); //theme variable for chceking theme
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Text(
          val, //numbers and symbols in calc
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: val == "CLEAR"
                ? 15
                : val == "DEL"
                    ? 17
                    : 24,
            fontWeight: val == "CLEAR" || val == "DEL"
                ? FontWeight.bold
                : FontWeight.w600,
            color:
                theme.brightness == Brightness.dark ? whiteColor : blackColor,
            //checking theme for lightmode and darkmode
          ),
        ),
      ),
    );
  }

  void btnClicked(String btnText) {
    if (btnText == "CLEAR") {
      setState(() {
        isEqualto = true;
        //bool used for text transition using AnimatedDefaultTextStyle two texts
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
          //prints the symbol after the number in Ui inside of text variable
        }
      });
    } else if (btnText == "=") {
      setState(() {
        isEqualto = false;
        //bool used for text transition using AnimatedDefaultTextStyle two texts
        if (text.isNotEmpty) {
          List<String> parts = text.split(" ");
          //splits the inputs into list for calc
          if (parts.length >= 3) {
            double result = double.parse(parts[0]);
            String op = "";
            for (int i = 1; i < parts.length; i++) {
              //looppp through the values of list to check the symbol and value
              String part = parts[i];
              if (part == "+" || part == "-" || part == "x" || part == "/") {
                op = part;
              } else {
                double num = double.parse(part);
                if (op == "+") {
                  //perfoms actual calculation for inputs
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
              //checks the result has digits after decimals?
            } else {
              res = result
                  .toStringAsFixed(2)
                  .replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
              //setting 2 values after decimal
            }
            CalculationHistory().addCalculation({"text": text, "result": res});
          } else {
            res = text;
            //if input less than 3, shows in UI
          }
        }
      });
    } else if (btnText == "^") {
      setState(() {
        if (text.isNotEmpty) {
          List<String> parts = text.split(" ");
          //splits the inputs into list for calc
          String lastPart = parts[parts.length - 1];
          double num = double.tryParse(lastPart) ?? 0;
          text = text.substring(0, text.lastIndexOf(lastPart)) +
              (num * num).toString();
        }
      });
      CalculationHistory().addCalculation({"text": text, "result": res});
      //add the calculation value inside of map inside of singleton class.
    } else if (btnText == "DEL") {
      setState(() {
        if (text.isNotEmpty) {
          text = text.substring(0, text.length - 1);
          //delete the last value in UI inside of text variable.
        }
      });
    } else if (btnText == "%") {
      setState(() {
        if (text.isNotEmpty) {
          List<String> parts = text.split(" ");
          //splits the inputs into list for calc
          if (parts.isNotEmpty) {
            double num = double.parse(parts.last);
            //make the last value square inside of text varibale values.
            num /= 100;
            text = text.substring(0, text.length - parts.last.length) +
                num.toString();
            // add the updated "%" value into the end of text variable without affecting the value before the "%" symbol.
          }
        }
      });
      CalculationHistory().addCalculation({"text": text, "result": res});
      //add the calculation value inside of map inside of singleton class.
    } else {
      setState(() {
        text += btnText;
        //if user didnt press any va,ue but pressed the symbol. it adds them into text variable to show in the UI.
      });
    }
  }
}
