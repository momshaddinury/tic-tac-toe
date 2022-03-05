import 'package:flutter/material.dart';

/// Model
class TicTac {
  TicTac({required this.marker});

  String marker;
}

List<TicTac> _ticTac = [
  TicTac(marker: ""),
  TicTac(marker: ""),
  TicTac(marker: ""),
  TicTac(marker: ""),
  TicTac(marker: ""),
  TicTac(marker: ""),
  TicTac(marker: ""),
  TicTac(marker: ""),
  TicTac(marker: ""),
];

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
    if (_ticTac[0].marker == _ticTac[1].marker &&
        _ticTac[1].marker == _ticTac[2].marker &&
        _ticTac[0].marker != "") {
      print("Winner ${_ticTac[0].marker}");
      _stopGame(0);
    }
    if (_ticTac[3].marker == _ticTac[4].marker &&
        _ticTac[4].marker == _ticTac[5].marker &&
        _ticTac[3].marker != "") {
      print("Winner ${_ticTac[3].marker}");
      _stopGame(3);
    }
    if (_ticTac[6].marker == _ticTac[7].marker &&
        _ticTac[7].marker == _ticTac[8].marker &&
        _ticTac[6].marker != "") {
      print("Winner ${_ticTac[6].marker}");
      _stopGame(6);
    }

    /// Column
    if (_ticTac[0].marker == _ticTac[3].marker &&
        _ticTac[3].marker == _ticTac[6].marker &&
        _ticTac[0].marker != "") {
      print("Winner ${_ticTac[0].marker}");
      _stopGame(0);
    }
    if (_ticTac[1].marker == _ticTac[4].marker &&
        _ticTac[4].marker == _ticTac[7].marker &&
        _ticTac[1].marker != "") {
      print("Winner ${_ticTac[1].marker}");
      _stopGame(1);
    }
    if (_ticTac[2].marker == _ticTac[5].marker &&
        _ticTac[5].marker == _ticTac[8].marker &&
        _ticTac[2].marker != "") {
      print("Winner ${_ticTac[2].marker}");
      _stopGame(2);
    }

    /// Diagonal
    if (_ticTac[0].marker == _ticTac[4].marker &&
        _ticTac[4].marker == _ticTac[8].marker &&
        _ticTac[0].marker != "") {
      print("Winner ${_ticTac[0].marker}");
      _stopGame(0);
    }
    if (_ticTac[2].marker == _ticTac[4].marker &&
        _ticTac[4].marker == _ticTac[6].marker &&
        _ticTac[2].marker != "") {
      print("Winner ${_ticTac[2].marker}");
      _stopGame(2);
    }
  }

  _stopGame(int i) {
    print("Winner ${_ticTac[i].marker}");
    if (_ticTac[i].marker == "X") xWin++;
    if (_ticTac[i].marker == "O") oWin++;
    _restartGame();
    emptyTiles = -1;
  }

  _restartGame() {
    for (final _i in _ticTac) _i.marker = "";
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

              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFF0BA192),
                      width: 3,
                    ),
                  ),
                  child: InkWell(
                    onTap: _restartGame,
                    child: Text(
                      "Restart",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScoreCardWidget extends StatelessWidget {
  const ScoreCardWidget({
    Key? key,
    required this.text,
    required this.point,
  }) : super(key: key);

  final String text;
  final int point;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFF0BA192),
          width: 3,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              )),
          Text("$point",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              )),
        ],
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
          if (_ticTac[widget.i].marker == "") {
            if (xTurn) {
              _ticTac[widget.i].marker = "X";
            } else {
              _ticTac[widget.i].marker = "O";
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
            _ticTac[widget.i].marker,
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
