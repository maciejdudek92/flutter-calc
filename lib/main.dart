// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

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

  List<Map> buttons = [
    {
      "isOperator": true,
      "title": "AC",
      "selected": false,
      "color": Colors.orange[900],
      "textColor": Colors.white
    },
    {
      "isOperator": true,
      "title": "+/-",
      "selected": false,
      "color": Colors.grey[800],
      "textColor": Colors.white
    },
    {
      "isOperator": true,
      "title": "%",
      "selected": false,
      "color": Colors.grey[800],
      "textColor": Colors.white
    },
    {
      "isOperator": true,
      "title": "/",
      "selected": false,
      "color": Colors.grey[800],
      "textColor": Colors.white
    },
    {
      "isOperator": false,
      "title": "7",
      "selected": false,
      "color": Colors.grey[400],
      "textColor": Colors.black
    },
    {
      "isOperator": false,
      "title": "8",
      "selected": false,
      "color": Colors.grey[400],
      "textColor": Colors.black
    },
    {
      "isOperator": false,
      "title": "9",
      "selected": false,
      "color": Colors.grey[400],
      "textColor": Colors.black
    },
    {
      "isOperator": true,
      "title": "x",
      "selected": false,
      "color": Colors.grey[800],
      "textColor": Colors.white
    },
    {
      "isOperator": false,
      "title": "4",
      "selected": false,
      "color": Colors.grey[400],
      "textColor": Colors.black
    },
    {
      "isOperator": false,
      "title": "5",
      "selected": false,
      "color": Colors.grey[400],
      "textColor": Colors.black
    },
    {
      "isOperator": false,
      "title": "6",
      "selected": false,
      "color": Colors.grey[400],
      "textColor": Colors.black
    },
    {
      "isOperator": true,
      "title": "-",
      "selected": false,
      "color": Colors.grey[800],
      "textColor": Colors.white
    },
    {
      "isOperator": false,
      "title": "1",
      "selected": false,
      "color": Colors.grey[400],
      "textColor": Colors.black
    },
    {
      "isOperator": false,
      "title": "2",
      "selected": false,
      "color": Colors.grey[400],
      "textColor": Colors.black
    },
    {
      "isOperator": false,
      "title": "3",
      "selected": false,
      "color": Colors.grey[400],
      "textColor": Colors.black
    },
    {
      "isOperator": true,
      "title": "+",
      "selected": false,
      "color": Colors.grey[800],
      "textColor": Colors.white
    },
    {
      "isOperator": true,
      "title": "DEL",
      "selected": false,
      "color": Colors.red[900],
      "textColor": Colors.white
    },
    {
      "isOperator": false,
      "title": "0",
      "selected": false,
      "color": Colors.grey[400],
      "textColor": Colors.black
    },
    {
      "isOperator": false,
      "title": ".",
      "selected": false,
      "color": Colors.grey[400],
      "textColor": Colors.black
    },
    {
      "isOperator": true,
      "title": "=",
      "selected": false,
      "color": Colors.grey[800],
      "textColor": Colors.white
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: <Widget>[
            Container(
              height: 200,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.green[900],
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: AutoSizeText(
                      userEquation,
                      style: GoogleFonts.vt323(
                        textStyle: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.bottomRight,
                    child: AutoSizeText(
                      equationResult,
                      style: GoogleFonts.vt323(
                        textStyle: TextStyle(
                          fontSize: 80,
                        ),
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: Container(
                    child: GridView.builder(
                      primary: false,
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              buttons[index]['selected'] = true;
                              if (buttons[index]['title'] == "AC") {
                                userEquation = userEquation.substring(0,
                                    userEquation.length - userEquation.length);
                                equationResult = equationResult.substring(
                                    0,
                                    equationResult.length -
                                        equationResult.length);
                              } else if (buttons[index]['title'] == "+/-") {
                              } else if (buttons[index]['title'] == "DEL") {
                                userEquation = userEquation.substring(
                                    0, userEquation.length - 1);
                              } else if (buttons[index]['title'] == "=") {
                                equalPressed();
                              } else {
                                if (userEquation.length == 0) {
                                  if (!buttons[index]['isOperator']) {
                                    userEquation += buttons[index]['title'];
                                  }
                                } else {
                                  if (double.tryParse(userEquation[
                                          userEquation.length - 1]) !=
                                      null) {
                                    userEquation += buttons[index]['title'];
                                  } else if (double.tryParse(userEquation[
                                              userEquation.length - 1]) ==
                                          null &&
                                      !buttons[index]['isOperator']) {
                                    userEquation += buttons[index]['title'];
                                  }
                                }
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedContainer(
                              onEnd: () {
                                setState(() {
                                  buttons[index]['selected'] = false;
                                });
                              },
                              width: 80,
                              height: 80,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.fastOutSlowIn,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: buttons[index]['color'],
                                boxShadow: buttons[index]['selected']
                                    ? buttonShadow(false)
                                    : buttonShadow(true),
                              ),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    buttons[index]['title'],
                                    style: TextStyle(
                                        color: buttons[index]['textColor'],
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void equalPressed() {
    String equalResult = userEquation.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(userEquation);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    equationResult = eval.toString();
  }

  List<BoxShadow> buttonShadow(bool value) {
    if (value) {
      return [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 10,
          spreadRadius: 0,
          offset: Offset(5, 5),
        ),
      ];
    } else {
      return [];
    }
  }
}
