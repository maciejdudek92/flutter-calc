import 'package:flutter/material.dart';
import 'package:fluttercalc/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const MyApp());

class CalcApp extends StatefulWidget {
  CalcApp({Key? key}) : super(key: key);

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalcApp(),
    );
  }
}

class _CalcAppState extends State<CalcApp> {
  var userEquation = "";
  var equationResult = "";

  final List<String> buttons = [
    "AC",
    "+/-",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "<",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      userEquation,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      equationResult,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return MyButton(
                        buttonTapped: () {
                          if (!isOperator(buttons[index])) {
                            setState(() {
                              userEquation += buttons[index];
                            });
                          } else {
                            if (buttons[index] == "AC") {
                              setState(() {
                                userEquation = userEquation.substring(0,
                                    userEquation.length - userEquation.length);
                                equationResult = equationResult.substring(
                                    0,
                                    equationResult.length -
                                        equationResult.length);
                              });
                            } else if (buttons[index] == "<") {
                              if (userEquation.length > 0) {
                                setState(() {
                                  userEquation = userEquation.substring(
                                      0, userEquation.length - 1);
                                });
                              }
                            } else if (buttons[index] == "=") {
                              setState(() {
                                equalPressed();
                              });
                            } else {
                              setState(() {
                                userEquation += buttons[index];
                              });
                            }
                          }
                        },
                        color: isOperator(buttons[index])
                            ? Colors.grey[800]
                            : Colors.grey[300],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                        buttonText: buttons[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (double.tryParse(x) == null && x != ".") {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String equalResult = userEquation.replaceAll('x', '*');
    print(equalResult);

    Parser p = Parser();
    Expression exp = p.parse(userEquation);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    equationResult = eval.toString();
  }
}
