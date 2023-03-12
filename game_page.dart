import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const String PLAYER_X = "X";

  static const String PLAYER_Y = "Y"; //X AND Y are two constants

  late String
      currentPlayer; //It is a variable to keep track of which player's turn it is
  late bool gameEnd; // variable To keep track wheather game has ended or not
  late List<String>
      occupied; // Variable to keep track of which cell is occupied by the player

  @override
  void initState() {
    // this method is used to ensure thst the widget is properly initialized and ready for display
    initializeGame();
    super.initState(); //It completes the initialization of the widgets state
  }

  void initializeGame() {
    // It is used to set up the initial state of the game including current player,the game board and wheather the game has ended or not.
    currentPlayer = PLAYER_X;
    gameEnd = false;
    occupied = [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    ];
  }

  @override
  Widget build(BuildContext context) {
    //build() method is a required method in every Flutter widget, and it is called to build the user interface for the widget.
    return Scaffold(
      //The Scaffold widget provides a basic framework for the app screen, including a toolbar and a body area where the main content is displayed.
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _headerText(), //child widgets
            _gameContainer(),
            _restartButton(),
          ],
        ),
      ),
    );
  } //Bracket For build Function

  Widget _headerText() {
    //method
    return Column(
      children: [
        const Text(
          "Tic Tac Toe",
          style: TextStyle(
            color: Colors.green,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "$currentPlayer turn", //The $currentPlayer syntax is used to interpolate the value of currentPlayer into the string, so that it is displayed dynamically based on the game state
          style: const TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  } //HeaderText End Tag

  Widget _gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
          //GridView.builder() method is used to create a 3x3 grid of boxes for the game board.
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //The gridDelegate property is set to a SliverGridDelegateWithFixedCrossAxisCount object, which creates a grid with a fixed number of columns (in this case, 3) and a variable number of rows based on the number of items in the grid.
              crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context, int index) {
            return _box(index);
          }),
    );
  } //Bracket For gameContainer

  Widget _box(int index) {
    //Overall, this code snippet handles the user interaction with the game board by updating the state of the game and checking for a win or a draw.
    return InkWell(
      onTap: () {
        if (gameEnd || occupied[index].isNotEmpty) {
          return;
        }
        setState(() {
          occupied[index] = currentPlayer;
          changeTurn();
          checkForWinner();
          checkForDraw();
        });
      },
      child: Container(
        color: occupied[index].isEmpty
            ? Colors.grey
            : occupied[index] == PLAYER_X
                ? Colors.blue
                : Colors.orange,
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            occupied[index],
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  } //Tag For _box

  _restartButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            initializeGame();
          });
        },
        child: const Text("Restart The Game"));
  } // Tag for _restartButton

  changeTurn() {
    if (currentPlayer == PLAYER_X) {
      currentPlayer = PLAYER_Y;
    } else {
      currentPlayer = PLAYER_X;
    }
  }

  checkForWinner() {
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winningPos in winningList) {
      String playerPosition0 = occupied[winningPos[0]];
      String playerPosition1 = occupied[winningPos[1]];
      String playerPosition2 = occupied[winningPos[2]];

      if (playerPosition0.isNotEmpty) {
        //First, the program checks if the first cell in the current winning position playerPosition0 is occupied. If it is, then the program checks if all three cells in the current winning position are occupied by the same player. If they are, then the game is over and a message is displayed indicating the winning player.
        if (playerPosition0 == playerPosition1 &&
            playerPosition0 == playerPosition2) {
          showGameOverMessage('Player $playerPosition0 Won');
          gameEnd = true;
          return;
        }
      }
    }
  }

  checkForDraw() {
    if (gameEnd) {
      return;
    }
    bool draw = true;
    for (var occupiedPlayer in occupied) {
      if (occupiedPlayer.isEmpty) {
        draw = false;
      }
    }

    if (draw) {
      showGameOverMessage("Draw");
      gameEnd = true;
    }
  }

  showGameOverMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          //SnackBar is a widget in Flutter that displays a brief message at the bottom of the screen
          backgroundColor: Colors.green,
          content: Text(
            "Game Over \n $message",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          )),
    );
  }
}
