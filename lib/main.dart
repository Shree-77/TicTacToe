import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: TicTacToe()));

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> _gameState = List.filled(9, "");
  String _currentPlayer = "X";

  void _playMove(int index) {
    setState(() {
      if (_gameState[index] == "") {
        _gameState[index] = _currentPlayer;
        _currentPlayer = _currentPlayer == "X" ? "O" : "X";
      }
    });
  }

  void _resetGame() {
    setState(() {
      _gameState = List.filled(9, "");
      _currentPlayer = "X";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            shrinkWrap: true,
            itemCount: _gameState.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => _playMove(index),
                  child: Text(
                    _gameState[index],
                    style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: Text("Reset Game"),
          ),
        ],
      ),
    );
  }
}
