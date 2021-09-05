import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:calcify/widgets/calculator_button.dart';
import 'package:calcify/widgets/operation_button.dart';
import 'package:calcify/widgets/small_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Calcify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var answer = '';
  bool brcktOpened = false;
  double firstNum = 0;
  String firstNumDouble = '';
  String history = "";
  String operation = "";
  String res = "";
  double secondNum = 0;
  String secondNumDouble = '';
  List<String> superHistory = [];
  String textToDisplay = "";
  String userInput = '';

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  void equalPressed() {
    String finaluserinput = userInput;
    print(finaluserinput);
    finaluserinput = finaluserinput.replaceAll('×', '*');
    finaluserinput = finaluserinput.replaceAll('÷', '/');
    finaluserinput = finaluserinput.replaceAll('()*', '');
    finaluserinput = finaluserinput.replaceAll('()+', '');
    finaluserinput = finaluserinput.replaceAll('()-', '');
    finaluserinput = finaluserinput.replaceAll('()/', '');
    print("test     asdf:" + finaluserinput);
    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    print(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    print(answer);
    double asdf = double.parse(answer);
    var finalAnswer = removeDecimalZeroFormat(asdf);
    setState(() {
      textToDisplay = finalAnswer;
    });
    userInput = finalAnswer;
    history = userInput;
  }

  void histEqualPressed() {
    String finaluserinput = userInput;
    print(finaluserinput);
    finaluserinput = finaluserinput.replaceAll('×', '*');
    finaluserinput = finaluserinput.replaceAll('÷', '/');
    finaluserinput = finaluserinput.replaceAll('*()', '');
    finaluserinput = finaluserinput.replaceAll('/()', '');
    finaluserinput = finaluserinput.replaceAll('-()', '');
    finaluserinput = finaluserinput.replaceAll('+()', '');
    finaluserinput = finaluserinput.replaceAll('()*', '');
    finaluserinput = finaluserinput.replaceAll('()+', '');
    finaluserinput = finaluserinput.replaceAll('()-', '');
    finaluserinput = finaluserinput.replaceAll('()/', '');
    print("test     asdf:" + finaluserinput);
    Parser p = Parser();
    try {
      Expression exp = p.parse(finaluserinput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      answer = eval.toString();
      double asdf = double.parse(answer);
      var finalAnswer = removeDecimalZeroFormat(asdf);
      print("finaAns" + finalAnswer);
      setState(() {
        history = finalAnswer;
      });
    } catch (exception) {
      setState(() {
        history = '';
      });
    }
  }

  void btnOnClick(String btnVal) {
    print(btnVal);
    if (btnVal == 'AC') {
      setState(() {
        userInput = '';
        answer = '0';
        textToDisplay = '';
        firstNum = 0;
        secondNum = 0;
        res = '';
        history = '';
        secondNumDouble = '';
        brcktOpened = false;
        print(brcktOpened);
      });
    } else if (btnVal == 'del') {
      if (userInput.substring(userInput.length - 1) == ')') {
        setState(() {
          brcktOpened = true;
          userInput = userInput.substring(0, userInput.length - 1);
          textToDisplay = userInput;
        });
      } else if (userInput.substring(userInput.length - 1) == '(') {
        setState(() {
          brcktOpened = false;
          userInput = userInput.substring(0, userInput.length - 1);
          textToDisplay = userInput;
        });
      } else {
        setState(() {
          userInput = userInput.substring(0, userInput.length - 1);
          textToDisplay = userInput;
        });
      }
    } else if (userInput.length >= 50) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('50 character maximum'),
          duration: Duration(
            milliseconds: 200,
          ),
        ),
      );
    } else if (btnVal == '( )') {
      print(brcktOpened);
      if (brcktOpened == true) {
        if (userInput.substring(userInput.length - 1) == '+' ||
            userInput.substring(userInput.length - 1) == '-' ||
            userInput.substring(userInput.length - 1) == '÷' ||
            userInput.substring(userInput.length - 1) == '×' ||
            userInput.substring(userInput.length - 1) == '^') {
        } else {
          setState(() {
            userInput += ')';
            brcktOpened = false;
            textToDisplay = userInput;
          });
        }
      } else {
        if (userInput.isNotEmpty) {
          if (userInput.substring(userInput.length - 1) == '0' ||
              userInput.substring(userInput.length - 1) == '1' ||
              userInput.substring(userInput.length - 1) == '2' ||
              userInput.substring(userInput.length - 1) == '3' ||
              userInput.substring(userInput.length - 1) == '4' ||
              userInput.substring(userInput.length - 1) == '5' ||
              userInput.substring(userInput.length - 1) == '6' ||
              userInput.substring(userInput.length - 1) == '7' ||
              userInput.substring(userInput.length - 1) == '8' ||
              userInput.substring(userInput.length - 1) == '9' ||
              userInput.substring(userInput.length - 1) == ')') {
            userInput = userInput + '×' + '(';
            brcktOpened = true;
          } else {
            userInput += '(';
            brcktOpened = true;
          }
        } else {
          userInput += '(';
          brcktOpened = true;
        }
        setState(() {
          textToDisplay = userInput;
        });
      }
    } else if (btnVal == '+/-') {
      setState(() {
        upToOperator();
      });
    } else if (btnVal == '=') {
      equalPressed();
    } else if (btnVal == '^') {
      print(userInput.substring(userInput.length - 1));
      if (userInput.substring(userInput.length - 1) == '+' ||
          userInput.substring(userInput.length - 1) == '-' ||
          userInput.substring(userInput.length - 1) == '÷' ||
          userInput.substring(userInput.length - 1) == '×' ||
          userInput.substring(userInput.length - 1) == '^' ||
          userInput.substring(userInput.length - 1) == '(') {
      } else {
        userInput += btnVal;
      }
      setState(() {
        textToDisplay = userInput;
      });
    } else if (btnVal == '+' || btnVal == '÷' || btnVal == '×') {
      if (userInput.substring(userInput.length - 1) == '0' ||
          userInput.substring(userInput.length - 1) == '1' ||
          userInput.substring(userInput.length - 1) == '2' ||
          userInput.substring(userInput.length - 1) == '3' ||
          userInput.substring(userInput.length - 1) == '4' ||
          userInput.substring(userInput.length - 1) == '5' ||
          userInput.substring(userInput.length - 1) == '6' ||
          userInput.substring(userInput.length - 1) == '7' ||
          userInput.substring(userInput.length - 1) == '8' ||
          userInput.substring(userInput.length - 1) == '9' ||
          userInput.substring(userInput.length - 1) == ')') {
        userInput += btnVal;
      } else {}

      setState(() {
        textToDisplay = userInput;
      });
    } else if (btnVal == '-') {
      if (userInput.substring(userInput.length - 1) == '0' ||
          userInput.substring(userInput.length - 1) == '1' ||
          userInput.substring(userInput.length - 1) == '2' ||
          userInput.substring(userInput.length - 1) == '3' ||
          userInput.substring(userInput.length - 1) == '4' ||
          userInput.substring(userInput.length - 1) == '5' ||
          userInput.substring(userInput.length - 1) == '6' ||
          userInput.substring(userInput.length - 1) == '7' ||
          userInput.substring(userInput.length - 1) == '8' ||
          userInput.substring(userInput.length - 1) == '9' ||
          userInput.substring(userInput.length - 1) == ')' ||
          userInput.substring(userInput.length - 1) == '^') {
        userInput += btnVal;
      } else {}

      setState(() {
        textToDisplay = userInput;
      });
    } else {
      if ((userInput != '' &&
              userInput.substring(userInput.length - 1) == ')') &&
          btnVal != '^') {
        userInput = userInput + "×" + btnVal;
      } else {
        userInput += btnVal;
      }

      setState(() {
        textToDisplay = userInput;
      });
    }
    histEqualPressed();
  }

  void upToOperator() {
    int lastIndex = 0;
    String oper = "";
    if (userInput.lastIndexOf('+') > lastIndex) {
      lastIndex = userInput.lastIndexOf('+');
      oper = "add";
    }
    if (userInput.lastIndexOf('-') > lastIndex) {
      lastIndex = userInput.lastIndexOf('-');
      oper = "sub";
    }
    if (userInput.lastIndexOf('×') > lastIndex) {
      lastIndex = userInput.lastIndexOf('×');
      oper = "mult";
    }
    if (userInput.lastIndexOf('÷') > lastIndex) {
      lastIndex = userInput.lastIndexOf('÷');
      oper = "div";
    }
    if (userInput.lastIndexOf('(') > lastIndex) {
      lastIndex = userInput.lastIndexOf(')');
      oper = "per";
    }
    if (userInput.lastIndexOf('^') > lastIndex) {
      lastIndex = userInput.lastIndexOf('^');
      oper = "pow";
    }
    if (lastIndex == 0 && oper == "") {
      if (userInput[0] != '-') {
        userInput = '-' + userInput;
        textToDisplay = userInput;
      } else {
        userInput = userInput.substring(1);
        textToDisplay = userInput;
      }
    }
    print(userInput.lastIndexOf("-"));
    print(userInput.lastIndexOf("×"));
    if (oper == "per") {
      String top = userInput.substring(0, lastIndex + 1);
      String bot = userInput.substring(lastIndex + 1, userInput.length);
      userInput = top + "-" + bot;
    } else if (oper == "add") {
      String top = userInput.substring(0, lastIndex);
      String bot = userInput.substring(lastIndex + 1, userInput.length);
      userInput = top + "-" + bot;
    } else if (oper == "sub") {
      if (((userInput.lastIndexOf("-")) == (userInput.lastIndexOf("÷") + 1)) ||
          ((userInput.lastIndexOf("-")) == (userInput.lastIndexOf("×") + 1)) ||
          ((userInput.lastIndexOf("-")) == (userInput.lastIndexOf("(") + 1)) ||
          ((userInput.lastIndexOf("-")) == (userInput.lastIndexOf("^") + 1))) {
        String top = userInput.substring(0, lastIndex);
        String bot = userInput.substring(lastIndex + 1, userInput.length);
        userInput = top + "" + bot;
      } else {
        String top = userInput.substring(0, lastIndex);
        String bot = userInput.substring(lastIndex + 1, userInput.length);
        userInput = top + "+" + bot;
      }
    } else if (oper == "mult") {
      String top = userInput.substring(0, lastIndex + 1);
      String bot = userInput.substring(lastIndex + 1, userInput.length);
      userInput = top + "-" + bot;
      brcktOpened = true;
    } else if (oper == "div") {
      String top = userInput.substring(0, lastIndex + 1);
      String bot = userInput.substring(lastIndex + 1, userInput.length);
      userInput = top + "-" + bot;
    } else if (oper == "pow") {
      String top = userInput.substring(0, lastIndex + 1);
      String bot = userInput.substring(lastIndex + 1, userInput.length);
      userInput = top + "-" + bot;
    }
    textToDisplay = userInput;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: AutoSizeText(
                  textToDisplay,
                  style: TextStyle(color: Colors.black, fontSize: 40),
                  maxLines: 3,
                ),
              ),
              alignment: Alignment.bottomRight,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: AutoSizeText(
                  history,
                  style: TextStyle(color: Colors.grey, fontSize: 22),
                  maxLines: 2,
                ),
              ),
              alignment: Alignment.bottomRight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SmallButton(
                  text: 'del',
                  callback: btnOnClick,
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 5,
                ),
                OperationButton(
                  text: 'AC',
                  callback: btnOnClick,
                ),
                OperationButton(
                  text: '( )',
                  callback: btnOnClick,
                ),
                OperationButton(
                  text: '^',
                  callback: btnOnClick,
                ),
                OperationButton(
                  text: '÷',
                  callback: btnOnClick,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                CalculatorButton(
                  text: '7',
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: '8',
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: '9',
                  callback: btnOnClick,
                ),
                OperationButton(
                  text: '×',
                  callback: btnOnClick,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                CalculatorButton(
                  text: '4',
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: '5',
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: '6',
                  callback: btnOnClick,
                ),
                OperationButton(
                  text: '-',
                  callback: btnOnClick,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                CalculatorButton(
                  text: '1',
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: '2',
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: '3',
                  callback: btnOnClick,
                ),
                OperationButton(
                  text: '+',
                  callback: btnOnClick,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                CalculatorButton(
                  text: '+/-',
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: '0',
                  callback: btnOnClick,
                ),
                CalculatorButton(
                  text: '.',
                  callback: btnOnClick,
                ),
                OperationButton(
                  text: '=',
                  callback: btnOnClick,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
