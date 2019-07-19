import 'dart:collection';

import 'Add.dart';
import 'Div.dart';
import 'MathAlgorithm.dart';
import 'MathContext.dart';
import 'Mul.dart';
import 'Sub.dart';
import 'Mod.dart';

class Calculation {
  Queue<double> _output = new Queue();
  Queue<String> _symbolStack = new Queue();

  static final int _BRACKET = 0;
  static final int _PLUS = 1;
  static final int _SUB = 1;
  static final int _MUL = 2;
  static final int _DIV = 2;
  static final int _MOD = 2;

  HashMap<String, int> _computerOper;

  Calculation() {
    _computerOper = _getComputeOper();
  }

  double handleCal(String expression) {
    RegExp exp = new RegExp(r"(\W)|(\d*\.\d*)|(\d*)");
    RegExp expNum = new RegExp(r"(\d)");
    Iterable<Match> matches = exp.allMatches(expression);
    for (Match m in matches) {
      String match = m.group(0);
      if (expNum.hasMatch(match)) {
        _output.addLast(double.parse(match));
        // print(_output);
      } else {
        int currentOper = _computerOper[match];
        if (currentOper != null && currentOper != 0) {
          while (!_symbolStack.isEmpty &&
              _computerOper[_symbolStack.last] >= currentOper) {
            _compute(_output, _symbolStack);
          }
          _symbolStack.addLast(match);
          // print(_symbolStack);
        }
      }
    }
    while (!_symbolStack.isEmpty) {
      _compute(_output, _symbolStack);
    }
    return _output.removeLast();
  }

  HashMap _getComputeOper() {
    HashMap<String, int> computeOper = new HashMap();
    computeOper.addAll({
      '+': _PLUS,
      '-': _SUB,
      '*': _MUL,
      '/': _DIV,
      '%': _MOD,
      '(': _BRACKET
    });
    return computeOper;
  }

  MathAlgorithm _getOperatorInstace(String s) {
    switch (s) {
      case "+":
        return new Add();
      case "-":
        return new Sub();
      case "*":
        return new Mul();
      case "/":
        return new Div();
      case "%":
        return new Mod();
      default:
        return null;
    }
  }

  _compute(Queue<double> output, Queue<String> symbolStack) {
    MathContext con =
        new MathContext(_getOperatorInstace(symbolStack.removeLast()));
    double num1 = output.removeLast();
    double num2 = output.removeLast();
    output.addLast(con.execute(num2, num1));
  }
}

// void main(List<String> args) {
//   Calculation a = new Calculation();
//   // print("3+2-5*4-2");
//   print(a.handleCal("10/2"));
// }
