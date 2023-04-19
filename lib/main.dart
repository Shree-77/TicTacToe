import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: TicTacToe()));

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> game = List.filled(9, "1");
  String player1 = "X";
  String player2 = "O";
  String currentPlayer = "";

  void handleMove(int index) {

    setState(() {
      game[index] = currentPlayer;
      if(currentPlayer==player1){
        currentPlayer=player2;
      }else{
        currentPlayer=player1;
      }
    });
  }

  bool checkWin(String symbol) {

    for (int i = 0; i < 9; i += 3) {
      if (game[i] == symbol && game[i + 1] == symbol && game[i + 2] == symbol) {
        return true;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (game[i] == symbol && game[i + 3] == symbol && game[i + 6] == symbol) {
        return true;
      }
    }

    if (game[0] == symbol && game[4] == symbol && game[8] == symbol) {
      return true;
    }
    if (game[2] == symbol && game[4] == symbol && game[6] == symbol) {
      return true;
    }

    return false;
  }

  void ResetGame() {
    game = List.filled(9, " ");
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
            itemCount: game.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => {
                    setState(
                      () {
                        if (game[index] == " ") {
                          handleMove(index);
                          if (checkWin(player1)) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Game Over'),
                                  content: Text('Player 1 Wins!'),
                                  actions: [
                                    ElevatedButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          ResetGame();
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                          } else if (checkWin(player2)) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Game Over'),
                                  content: Text('Player 2 Wins!'),
                                  actions: [
                                    ElevatedButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          ResetGame();
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (!game.contains(" ")) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Game Over'),
                                  content: Text('Match Tie '),
                                  actions: [
                                    ElevatedButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          ResetGame();
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                    )
                  },
                  child: Text(
                    game[index],
                    style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => {
              setState(() {
                ResetGame();
              })
            },
            child: Text("Reset Game"),
          ),
        ],
      ),
    );
  }
}
