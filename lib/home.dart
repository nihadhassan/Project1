import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  String _operator;
  String _textContent = '0';
  bool _started = false;
  bool _finished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
                'Calculator',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                )
            ),
            actions: [
              IconButton(
                  padding: EdgeInsets.only(right: 20),
                  icon: Icon(
                    Icons.clear_all,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: (){
                    setState(() {
                      _operator = null;
                      _textContent = '0';
                      _started = false;
                      _finished = false;
                    });
                  }
              )
            ]
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Text(
                      _textContent,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 60
                      ),
                      maxLines: 1
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton("7", Colors.greenAccent, Colors.white),
                  _buildButton("8", Colors.greenAccent, Colors.white),
                  _buildButton("9", Colors.greenAccent, Colors.white),
                  _buildButton("/", Colors.lime, Colors.black)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton("4", Colors.greenAccent, Colors.white),
                  _buildButton("5", Colors.greenAccent, Colors.white),
                  _buildButton("6", Colors.greenAccent, Colors.white),
                  _buildButton("x", Colors.lime, Colors.black)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton("1", Colors.greenAccent, Colors.white),
                  _buildButton("2", Colors.greenAccent, Colors.white),
                  _buildButton("3", Colors.greenAccent, Colors.white),
                  _buildButton("-", Colors.lime, Colors.black)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton("=", Colors.lime, Colors.black),
                  _buildButton("0", Colors.greenAccent, Colors.white),
                  _buildButton(".", Colors.greenAccent, Colors.white),
                  _buildButton("+", Colors.lime, Colors.black)
                ],
              )
            ]
        )
    );
  }

  Widget _buildButton(String label, Color background, Color textColor) {
    return RaisedButton(
        child: Text(label, style: TextStyle(fontSize: 30, color: textColor)),
        color: background,
        shape: CircleBorder(),
        padding: EdgeInsets.all(30),
        onPressed: (){
          switch(label){
            case '.' : _onClickNumber('.'); break;
            case '0' : _onClickNumber('0'); break;
            case '1' : _onClickNumber('1'); break;
            case '2' : _onClickNumber('2'); break;
            case '3' : _onClickNumber('3'); break;
            case '4' : _onClickNumber('4'); break;
            case '5' : _onClickNumber('5'); break;
            case '6' : _onClickNumber('6'); break;
            case '7' : _onClickNumber('7'); break;
            case '8' : _onClickNumber('8'); break;
            case '9' : _onClickNumber('9'); break;
            case '+' : _onClickOperator('+'); break;
            case '-' : _onClickOperator('-'); break;
            case 'x' : _onClickOperator('x'); break;
            case '/' : _onClickOperator('/'); break;
            case '=' : _onClickEquals(); break;
          }
        }
    );
  }

  void _onClickNumber(String number){
    if(!_finished){
      if(!_started) {
        setState(() {
          _textContent = '';
        });
      }

      if(number == '.'){
        if (_operator == null){
          if (!_textContent.contains(".")) {
            setState(() {
              if (_textContent.isEmpty) _textContent += '0.';
              else _textContent += '.';
            });
          }
        }
        else {
          int operatorIndex = _textContent.indexOf(_operator);
          String secondNumber = _textContent.substring(operatorIndex + 1);
          if (!secondNumber.contains(".")) {
            setState(() {
              if (secondNumber.isEmpty) _textContent += '0.';
              else _textContent += '.';
            });
          }
        }
      }
      else {
        setState(() {
          _textContent += number;
        });
      }

      if(!_started) _started = true;
    }
  }

  void _onClickOperator(String operator){
    if (_operator == null){
      _operator = operator;
      setState(() {
        _textContent += _operator;
      });
      if(!_started) _started = true;
    }
  }

  void _onClickEquals(){
    if (_operator != null && !_textContent.endsWith(_operator)){
      int operatorIndex = _textContent.indexOf(_operator);
      num firstNumber = num.parse(_textContent.substring(0, operatorIndex));
      num secondNumber = num.parse(_textContent.substring(operatorIndex + 1));
      num result = 0;
      switch (_operator) {
        case "+": result = firstNumber + secondNumber; break;
        case "-": result = firstNumber - secondNumber; break;
        case "x": result = firstNumber * secondNumber; break;
        case "/": result = firstNumber / secondNumber; break;
      }

      setState(() {
        _textContent += '=' + result.toString();
      });

      /*setState(() {
        if(result.toString().endsWith('.0'))
          _textContent += '=' + result.toString().substring(0, result.toString().length - 2);
        else
          _textContent += '=' + result.toString();
      });*/

      _finished = true;
    }
  }

}