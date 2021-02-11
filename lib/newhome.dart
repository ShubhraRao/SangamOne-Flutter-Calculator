import 'package:flutter/material.dart';

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  double width;

  @override
  void initState() {
    // context.bloc<CalculationBloc>().add(FetchHistory());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  int firstOperand;
  String operator;
  int secondOperand;
  int result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          // ResultDisplay(
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.black,
            child: Text(
              _getDisplayText(),
              style: TextStyle(color: Colors.white, fontSize: 34),
            ),
          ),

          // result: ,
          // ),
          Row(
            children: [
              _getButton(text: '7', onTap: () => numberPressed(7)),
              _getButton(text: '8', onTap: () => numberPressed(8)),
              _getButton(text: '9', onTap: () => numberPressed(9)),
              _getButton(
                  text: 'x',
                  onTap: () => operatorPressed('*'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
            ],
          ),
          Row(
            children: [
              _getButton(text: '4', onTap: () => numberPressed(4)),
              _getButton(text: '5', onTap: () => numberPressed(5)),
              _getButton(text: '6', onTap: () => numberPressed(6)),
              _getButton(
                  text: '/',
                  onTap: () => operatorPressed('/'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
            ],
          ),
          Row(
            children: [
              _getButton(text: '1', onTap: () => numberPressed(1)),
              _getButton(text: '2', onTap: () => numberPressed(2)),
              _getButton(text: '3', onTap: () => numberPressed(3)),
              _getButton(
                  text: '+',
                  onTap: () => operatorPressed('+'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1))
            ],
          ),
          Row(
            children: [
              _getButton(
                  text: '=',
                  onTap: calculateResult,
                  backgroundColor: Colors.orange,
                  textColor: Colors.white),
              _getButton(text: '0', onTap: () => numberPressed(0)),
              _getButton(
                  text: 'C',
                  onTap: clear,
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
              _getButton(
                  text: '-',
                  onTap: () => operatorPressed('-'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
            ],
          ),
        ]));
  }

  Widget _getButton(
      {String text,
      Function onTap,
      Color backgroundColor = Colors.white,
      Color textColor = Colors.black}) {
    return CalculatorButton(
      label: text,
      onTap: onTap,
      size: 90,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }

  numberPressed(int number) {
    print(number);
    setState(() {
      if (result != null) {
        result = null;
        firstOperand = number;
        return;
      }
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }
      secondOperand = int.parse('$secondOperand$number');
    });
  }

  operatorPressed(String op) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = 0;
      }
      // this.
      operator = op;
    });
  }

  calculateResult() {
    if (operator == null || secondOperand == null) {
      return;
    }
    setState(() {
      switch (operator) {
        case '+':
          result = firstOperand + secondOperand;
          break;
        case '-':
          result = firstOperand - secondOperand;
          break;
        case '*':
          result = firstOperand * secondOperand;
          break;
        case '/':
          if (secondOperand == 0) {
            return;
          }
          result = firstOperand ~/ secondOperand;
          break;
      }
      firstOperand = result;
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  clear() {
    setState(() {
      result = null;
      operator = null;
      secondOperand = null;
      firstOperand = null;
    });
  }

  String _getDisplayText() {
    if (result != null) {
      return '$result';
    }
    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }
    if (operator != null) {
      return '$firstOperand$operator';
    }
    if (firstOperand != null) {
      return '$firstOperand';
    }
    return '0';
  }
}

// class ResultDisplay extends StatelessWidget {
//   ResultDisplay({@required this.result});
//   final String result;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         height: 200,
//         color: Colors.black,
//         child: Text(
//           result.toString(),
//           style: TextStyle(color: Colors.white, fontSize: 34),
//         ));
//   }
// }

class CalculatorButton extends StatelessWidget {
  CalculatorButton(
      {@required this.label,
      @required this.onTap,
      @required this.size,
      this.backgroundColor = Colors.white,
      this.labelColor = Colors.black});

  final String label;
  final VoidCallback onTap;
  final double size;
  final Color backgroundColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(6),
        child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(1, 1), blurRadius: 2),
                ],
                borderRadius: BorderRadius.all(Radius.circular(size / 2)),
                color: backgroundColor),
            child: FlatButton(
              shape: CircleBorder(),
              onPressed: onTap,
              child: Center(
                  child: Text(
                label,
                style: TextStyle(fontSize: 24, color: labelColor),
              )),
            )));
  }
}
