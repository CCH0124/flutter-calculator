import 'dart:collection';

import 'package:flutter/material.dart';

import 'Model/Calculation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double output = 0.0;
  String _expression = "";
  Queue<String> dentist = new Queue<String>();

  String _itrQueue(Queue<String> queue) {
    String str = "";
    for (String s in queue) {
      str += s;
    }
    return str;
  }

  buttonPressed(String buttonText) {
    if (buttonText == "B" && dentist.isNotEmpty) {
      dentist.removeLast();
      _expression = _itrQueue(dentist);
    }
    if (buttonText != "=" && buttonText != "B" && buttonText != "C") {
      dentist.addLast(buttonText);
      _expression = _itrQueue(dentist);
    }
    if (buttonText == "C") {
      dentist.clear();
      _expression = "";
      output = 0.0;
    }

    if (buttonText == "=") {
      Calculation cal = new Calculation();
      _expression = _itrQueue(dentist);
      output = cal.handleCal(_expression);
      dentist.clear();
      dentist.addLast(output.toString());
      _expression = _itrQueue(dentist);
    }
    
  }

  Widget buildButton(String text) {
    return new Expanded(
      child: new MaterialButton(
        padding: new EdgeInsets.all(12.0),
        child: new Text(
          text,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        // onPressed: () => buttonPressed(text),
        onPressed: (() {
          setState(() {
            buttonPressed(text);
          });
        }),
      ),
    );
  }

  Widget buildText(String text) {
    return new Container(
      alignment: Alignment.centerRight,
      padding: new EdgeInsets.symmetric(
        vertical: 24.0, // 配置上下
        horizontal: 12.0, // 配置左右
      ),
      child: new Text(
        text,
        style: new TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            buildText(_expression),
            buildText(output.toString()),
            new Expanded(
              child : new Divider(
                color: Colors.transparent,
              ),
            ),
            new Column(
              children: [
                new Row(
                  children: [
                    buildButton("C"),
                    buildButton("%"),
                    buildButton("/"),
                    buildButton("B"),
                  ],
                )
              ],
            ),
            new Column(
              children: [
                new Row(
                  children: [
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("*"),
                  ],
                )
              ],
            ),
            new Column(
              children: [
                new Row(
                  children: [
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("-"),
                  ],
                )
              ],
            ),
            new Column(
              children: [
                new Row(
                  children: [
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("+"),
                  ],
                )
              ],
            ),
            new Column(
              children: [
                new Row(
                  children: [
                    buildButton("."),
                    buildButton("0"),
                    buildButton("00"),
                    buildButton("="),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
