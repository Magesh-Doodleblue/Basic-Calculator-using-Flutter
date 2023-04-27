// ignore_for_file: library_private_types_in_public_api, camel_case_types
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          calcText(),
          const Spacer(
            flex: 2,
          ),
          rowOne(context),
          rowTwo(context),
          rowThree(context),
          rowFour(context),
          rowFive(context)
        ],
      ),
    );
  }

  Row rowFive(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          child: customOutlineButton("CLEAR"),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          child: customOutlineButton("="),
        ),
      ],
    );
  }

  Row rowFour(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          child: customOutlineButton("."),
        ),
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("0")),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          child: customOutlineButton("00"),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          child: customOutlineButton("+"),
        ),
      ],
    );
  }

  Row rowThree(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("1")),
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("2")),
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("3")),
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("-")),
      ],
    );
  }

  Row rowTwo(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("4")),
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("5")),
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("6")),
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("x")),
      ],
    );
  }

  Row rowOne(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("7")),
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("8")),
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("9")),
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: customOutlineButton("/")),
      ],
    );
  }

  Expanded calcText() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.bottomRight,
        child: Text(
          text.isEmpty ? "0" : text,
          style: const TextStyle(
            fontSize: 60.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget customOutlineButton(String val) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
          onPressed: () => btnClicked(val),
          child: Text(
            val,
            style: TextStyle(
              fontSize: val == "CLEAR" ? 19 : 26,
              fontWeight: val == "CLEAR" ? FontWeight.bold : FontWeight.w500,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
    );
  }

  late String currentOperation;
  late double first, second;
  late String res;
  String text = "";

  void btnClicked(String btnText) {
    if (btnText == "CLEAR") {
      setState(() {
        text = "";
      });
    } else if (btnText == "+" ||
        btnText == "-" ||
        btnText == "x" ||
        btnText == "/") {
      setState(() {
        first = double.parse(text);
        currentOperation = btnText;
        text = "";
      });
    } else if (btnText == "=") {
      setState(() {
        second = double.parse(text);
        if (currentOperation == "+") {
          text = (first + second).toString();
        } else if (currentOperation == "-") {
          text = (first - second).toString();
        } else if (currentOperation == "x") {
          text = (first * second).toString();
        } else if (currentOperation == "/") {
          text = (first / second).toString();
        }
      });
    } else {
      setState(() {
        text += btnText;
      });
    }
  }
}
