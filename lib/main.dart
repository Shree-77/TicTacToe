import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TicTacToe()));

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> game = List.filled(9, " ");
  static String player1 = "X";
  String player2 = "O";
  String currentPlayer = player1;

  void handleMove(int index) {
    setState(() {
      //print(currentPlayer);
      game[index] = currentPlayer;
      if (currentPlayer == player1) {
        currentPlayer = player2;
      } else {
        currentPlayer = player1;
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
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            shrinkWrap: true,
            itemCount: game.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
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
                                  title: const Text('Game Over'),
                                  content: const Text('Player 1 Wins!'),
                                  actions: [
                                    ElevatedButton(
                                      child: const Text('OK'),
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
                                  title: const Text('Game Over'),
                                  content: const Text('Player 2 Wins!'),
                                  actions: [
                                    ElevatedButton(
                                      child: const Text('OK'),
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
                                  title: const Text('Game Over'),
                                  content: const Text('Match Tie '),
                                  actions: [
                                    ElevatedButton(
                                      child: const Text('OK'),
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
                    style: const TextStyle(
                        fontSize: 80, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => {
              setState(() {
                ResetGame();
              })
            },
            child: const Text("Reset Game"),
          ),
        ],
      ),
    );
  }
}
