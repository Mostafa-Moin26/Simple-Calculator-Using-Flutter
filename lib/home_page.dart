import 'package:flutter/material.dart';
import 'package:simple_calculator/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    userQuestion,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    userAnswer,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButtons(
                        buttonColor: Colors.green,
                        textColor: Colors.white,
                        buttonText: buttons[index],
                        buttonPressed: () {
                          setState(() {
                            userQuestion = '';
                          });
                        },
                      );
                    }
                    // Delete button
                    else if (index == 1) {
                      return MyButtons(
                        buttonColor: Colors.red,
                        textColor: Colors.white,
                        buttonText: buttons[index],
                        buttonPressed: () {
                          setState(() {
                            userQuestion = userQuestion.isEmpty
                                ? ''
                                : userQuestion.substring(
                                    0, userQuestion.length - 1);
                          });
                        },
                      );
                    }
                    // Equal button
                    else if (index == buttons.length - 1) {
                      return MyButtons(
                        buttonColor: Colors.red,
                        textColor: Colors.white,
                        buttonText: buttons[index],
                        buttonPressed: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                      );
                    }
                    // Rest of the buttons
                    else {
                      return MyButtons(
                        buttonColor: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple[50] ?? Colors.deepPurple,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                        buttonText: buttons[index],
                        buttonPressed: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                      );
                    }
                  }))
        ],
      ),
    );
  }

  bool isOperator(String s) {
    if (s == '%' || s == '/' || s == 'x' || s == '-' || s == '+') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuesion = userQuestion;

    finalQuesion = finalQuesion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuesion);

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
