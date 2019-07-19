import 'MathAlgorithm.dart';

class MathContext {
  MathAlgorithm _mathAlgorithm;

  MathContext(MathAlgorithm strategy){
    this._mathAlgorithm = strategy;
  }

  double execute(double num1, double num2){
    return _mathAlgorithm.calculate(num1, num2);
  }
}