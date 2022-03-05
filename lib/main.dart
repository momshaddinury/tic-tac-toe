import 'package:flutter/material.dart';

import 'model.dart';
import 'widgets/score_card.dart';

/// Variables
int emptyTiles = 9;
bool xTurn = true;
int xWin = 0;
int oWin = 0;

/// UI
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  _checkWinner() {
    /// Row
    if (ticTac[0].marker == ticTac[1].marker &&
        ticTac[1].marker == ticTac[2].marker &&
        ticTac[0].marker != "") {
      print("Winner ${ticTac[0].marker}");
      _stopGame(0);
    }
    if (ticTac[3].marker == ticTac[4].marker &&
        ticTac[4].marker == ticTac[5].marker &&
        ticTac[3].marker != "") {
      print("Winner ${ticTac[3].marker}");
      _stopGame(3);
    }
    if (ticTac[6].marker == ticTac[7].marker &&
        ticTac[7].marker == ticTac[8].marker &&
        ticTac[6].marker != "") {
      print("Winner ${ticTac[6].marker}");
      _stopGame(6);
    }

    /// Column
    if (ticTac[0].marker == ticTac[3].marker &&
        ticTac[3].marker == ticTac[6].marker &&
        ticTac[0].marker != "") {
      print("Winner ${ticTac[0].marker}");
      _stopGame(0);
    }
    if (ticTac[1].marker == ticTac[4].marker &&
        ticTac[4].marker == ticTac[7].marker &&
        ticTac[1].marker != "") {
      print("Winner ${ticTac[1].marker}");
      _stopGame(1);
    }
    if (ticTac[2].marker == ticTac[5].marker &&
        ticTac[5].marker == ticTac[8].marker &&
        ticTac[2].marker != "") {
      print("Winner ${ticTac[2].marker}");
      _stopGame(2);
    }

    /// Diagonal
    if (ticTac[0].marker == ticTac[4].marker &&
        ticTac[4].marker == ticTac[8].marker &&
        ticTac[0].marker != "") {
      print("Winner ${ticTac[0].marker}");
      _stopGame(0);
    }
    if (ticTac[2].marker == ticTac[4].marker &&
        ticTac[4].marker == ticTac[6].marker &&
        ticTac[2].marker != "") {
      print("Winner ${ticTac[2].marker}");
      _stopGame(2);
    }
  }

  _stopGame(int i) {
    print("Winner ${ticTac[i].marker}");
    if (ticTac[i].marker == "X") xWin++;
    if (ticTac[i].marker == "O") oWin++;
    _restartGame();
    emptyTiles = -1;
  }

  _restartGame() {
    for (final _i in ticTac) _i.marker = "";
    xTurn = true;
    emptyTiles = 9;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF12BDAC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///TODO: Implement difficulty level dropdown
              // Row(
              //   children: [
              //     Icon(Icons.arrow_drop_down_circle_outlined),
              //     const SizedBox(width: 10),
              //     Text("Impossible"),
              //   ],
              // ),

              ///TODO: Implement share option
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ScoreCardWidget(text: "X", point: xWin),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ScoreCardWidget(text: "O", point: oWin),
                  ),
                ],
              ),

              ///TODO: Implement select player option
              const SizedBox(height: 20),

              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  for (var i = 0; i < 9; i++)
                    _TileWidget(
                      i: i,
                      checkWinner: _checkWinner,
                    )
                ],
              ),

              const SizedBox(height: 40),
              Center(
                child: OutlinedButton(
                  onPressed: _restartGame,
                  style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      side: BorderSide(color: Color(0xFF0BA192), width: 3),
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF545454),
                      )),
                  child: Text("Restart"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TileWidget extends StatefulWidget {
  const _TileWidget({
    Key? key,
    required this.i,
    required this.checkWinner,
  }) : super(key: key);

  final int i;
  final Function checkWinner;

  @override
  __TileWidgetState createState() => __TileWidgetState();
}

class __TileWidgetState extends State<_TileWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (emptyTiles != -1) {
          if (ticTac[widget.i].marker == "") {
            if (xTurn) {
              ticTac[widget.i].marker = "X";
            } else {
              ticTac[widget.i].marker = "O";
            }

            xTurn = !xTurn;
            emptyTiles--;
            print(emptyTiles);
            widget.checkWinner();
            setState(() {});
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: (widget.i != 2 && widget.i != 5 && widget.i != 8)
                ? BorderSide(color: Color(0xFF0BA192), width: 5)
                : BorderSide(color: Colors.transparent),
            bottom: widget.i < 6
                ? BorderSide(color: Color(0xFF0BA192), width: 5)
                : BorderSide(color: Colors.transparent),
          ),
        ),
        child: Center(
          child: Text(
            ticTac[widget.i].marker,
            style: TextStyle(
              color: Color(0xFF545454),
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
