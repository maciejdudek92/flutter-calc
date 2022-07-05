import 'package:flutter/material.dart';
import 'package:fluttercalc/buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:google_fonts/google_fonts.dart';

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
  //from button
  var userEquation = "";
  var equationResult = "";

  bool _selected = true;

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[900],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(4, 4),
                    ),
                    BoxShadow(
                      color: Colors.white60,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(-4, -4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // SizedBox(
                    //   height: 50,
                    // ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        userEquation,
                        style: GoogleFonts.vt323(
                          textStyle: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        equationResult,
                        style: GoogleFonts.vt323(
                          textStyle: TextStyle(
                            fontSize: 50,
                          ),
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
                      //changed from MyButton class
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selected = false;
                          });

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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            onEnd: () {
                              setState(() {
                                _selected = true;
                              });
                            },
                            duration: Duration(milliseconds: 150),
                            curve: Curves.linear,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: buttons[index] == "<"
                                  ? Colors.red
                                  : isOperator(buttons[index])
                                      ? Colors.grey[800]
                                      : Colors.grey[350],
                              boxShadow: _selected
                                  ? [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                        offset: Offset(4, 4),
                                      ),
                                      BoxShadow(
                                        color: Colors.white60,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                        offset: Offset(-4, -4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Container(
                              child: Center(
                                child: Text(
                                  buttons[index],
                                  style: TextStyle(
                                      color: isOperator(buttons[index])
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                      // return MyButton(
                      //   buttonTapped: () {
                      //     if (!isOperator(buttons[index])) {
                      //       setState(() {
                      //         userEquation += buttons[index];
                      //       });
                      //     } else {
                      //       if (buttons[index] == "AC") {
                      //         setState(() {
                      //           userEquation = userEquation.substring(
                      //               0, userEquation.length - userEquation.length);
                      //           equationResult = equationResult.substring(
                      //               0,
                      //               equationResult.length -
                      //                   equationResult.length);
                      //         });
                      //       } else if (buttons[index] == "<") {
                      //         if (userEquation.length > 0) {
                      //           setState(() {
                      //             userEquation = userEquation.substring(
                      //                 0, userEquation.length - 1);
                      //           });
                      //         }
                      //       } else if (buttons[index] == "=") {
                      //         setState(() {
                      //           equalPressed();
                      //         });
                      //       } else {
                      //         setState(() {
                      //           userEquation += buttons[index];
                      //         });
                      //       }
                      //     }
                      //   },
                      //   color: isOperator(buttons[index])
                      //       ? Colors.grey[800]
                      //       : Colors.grey[300],
                      // textColor: isOperator(buttons[index])
                      //     ? Colors.white
                      //     : Colors.black,
                      //   buttonText: buttons[index],
                      // );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
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
