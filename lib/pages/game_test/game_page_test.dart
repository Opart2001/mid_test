// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../game.dart';

// ctrl + space
// alt + enter
// stf

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _controiller = TextEditingController(); // เก็บค่าที่ user input
  final _game = Game(maxRandom: 100);
  var _feedbackText = '';
  var _show = true;
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    var Mybox1 = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(width: 20, height: 20, color: Colors.greenAccent),
    );
    var Mybox2 = Container(width: 20, height: 20, color: Colors.amber);

    var boxlist = <Widget>[];
    for (int i = 0; i < _count; ++i) {
      boxlist.add(Mybox1);
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.ac_unit,
                  color: Colors.cyan,
                )),
            SizedBox(width: 10),
            Text('Guess The Number'),
          ],
        ),
      ),
      // Row ซ้าย => ขวา Column บน => ล่าง
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _show ? boxlist : [],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Text(
                      'Pls guess the between 1 and  100',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.cyan,
                      ), // ปรับเกี่ยวกับข้อความ
                      textAlign: TextAlign.center, //กี่งกลางข้อความ
                    ),
                  ),
                  TextField(
                    controller: _controiller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your Guess'), //กรอบ
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // todo:
                        var input = _controiller.text;

                        var guess = int.tryParse(input);

                        var result = _game.doGuess(guess!);
                        if (result == GuessResult.correct) {
                          setState(() {
                            _feedbackText = 'Nice';
                          });
                        } else if (result == GuessResult.tooLow) {
                          setState(() {
                            _feedbackText = 'Too Low';
                          });
                        } else {
                          setState(() {
                            _feedbackText = 'Too High';
                          });
                        }

                        print(input);
                      },
                      child: Text('GUESS'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _count++;
                      });
                    },
                    child: Text('Test'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _count--;
                        });
                      },
                      child: Text('Test2'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _show = !_show;
                        });
                      },
                      child: Text('test3'),
                    ),
                  ),
                ],
              ),
            ),
            Text(_feedbackText),
          ],
        ),
      ),
    );
  }
}
