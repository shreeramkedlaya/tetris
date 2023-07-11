import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/values.dart';
import 'pixel.dart';

//create game board
List<List<Tetromino?>> gameBoard = List.generate(
  colL,
  (i) => List.generate(
    rowL,
    (j) => null,
  ),
);

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  //cur piece
  Piece currentPiece = Piece(type: Tetromino.L);

  // current score
  int currentScore = 0;

  // game over status
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    //start game when app starts
    startGame();
  }

  void startGame() {
    currentPiece.initPiece();

    //frame refresh rate
    Duration frameRate = const Duration(milliseconds: 200);
    gameLoop(frameRate);
  }

  //game Loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
        setState(
          () {
            //clear lines
            clearLines();

            //check landing
            checkLanding();

            // check if game is over
            if (gameOver == true) {
              timer.cancel();
              showGameOverDialog();
            }
            //move the current piece down
            currentPiece.movePiece(Direction.down);
          },
        );
      },
    );
  }

  // game over dialog
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text("Your score is: $currentScore"),
        actions: [
          TextButton(
            onPressed: () {
              // reset the game
              resetGame();

              Navigator.pop(context);
            },
            child: const Text('Play again'),
          )
        ],
      ),
    );
  }

  // reset game
  void resetGame() {
    // clear the game board
    gameBoard = List.generate(
      colL,
      (i) => List.generate(
        rowL,
        (j) => null,
      ),
    );

    // new game
    gameOver = false;
    currentScore = 0;

    // create new piece
    createNewPiece();

    // start the game again
    startGame();
  }

  //check collision in a future position
  // return true —> there is a collision
  // return false -> there is no collision

  bool checkCollision(Direction direction) {
    //loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      //calc row and col
      int row = (currentPiece.position[i] / rowL).floor();
      int col = currentPiece.position[i] % colL;

      //adjust the row and col based on dir
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check if the piece is out of bounds (either too low or too far to the left or right)
      if (row >= colL || col < 0 || col >= rowL) {
        return true;
      }
    }
    //if no collisions are detected, return false
    return false;
  }

  void checkLanding() {
    //if going down is occupied
    if (checkCollision(Direction.down)) {
      //mark position as occupied on game board
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowL).floor();
        int col = currentPiece.position[i] % colL;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      //once landed, create the next piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    // create a random object to generate random tetromino types
    Random rand = Random();
    // create a new piece with random type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initPiece();

    /*
    Since our game over condition is if there is a piece at the top level, you want
    to check if the game is over when you create a new piece instead of checking
    every frame, because new pieces are allowed to go through the top level but if
    there is already a piece in the top level when the new piece is created, then
    game is over
    */

    if (isGameOver()) {
      gameOver = true;
    }
  }

  void moveLeft() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // clear lines
  void clearLines() {
    // Loop through each row of the game board from bottom to top
    for (int row = colL - 1; row >= 0; row--) {
      // Initialize a variable to track if the row is full
      bool rowIsFull = true;

      // Check if the row if full (all columns in the row are filled with pieces)
      for (int col = 0; col < rowL; col++) {
        // if there's an empty column, set rowlsFull to false and break the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      // if the row is full, clear the row and shift rows down
      if (rowIsFull) {
        // move all rows above the cleared row down by one position
        for (int r = row; r > 0; r--) {
          // copy the above row to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        // set the top row to empty
        gameBoard[0] = List.generate(row, (index) => null);

        // incr score
        currentScore++;
      }
    }
  }

  // GAME OVER METHOD
  bool isGameOver() {
    // check if any column in the top row are filled
    for (int col = 0; col < rowL; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    // if the top row is empty, the game is not over
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //GAME GRID
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rowL * colL,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowL),
              itemBuilder: (context, index) {
                // get row and col of each index
                int row = (index / rowL).floor();
                int col = index % colL;

                //current piece
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: currentPiece.color,
                  );
                }
                //landed pieces
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(
                    color: tetrominoColors[tetrominoType],
                  );
                }
                //blank pixel
                else {
                  return Pixel(
                    color: Colors.grey[900],
                  );
                }
              },
            ),
          ),

          // Score
          Text(
            'Score:$currentScore',
            style: const TextStyle(color: Colors.white),
          ),

          //game controls
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                //left
                IconButton(
                  onPressed: moveLeft,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_back_ios),
                ),

                //rotate
                IconButton(
                  onPressed: rotatePiece,
                  color: Colors.white,
                  icon: const Icon(Icons.rotate_right),
                ),
                
                //right
                IconButton(
                  onPressed: moveRight,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
