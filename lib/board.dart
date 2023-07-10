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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //start game when app starts
    startGame();
  }

  void startGame() {
    currentPiece.initPiece();

    //frame refresh rate
    Duration frameRate = Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  //game Loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        //check landing
        checkLanding();
        //move the current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
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
    for (int row = colL - 1; row >= 0; row--) {}
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
                physics: NeverScrollableScrollPhysics(),
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
                      child: index,
                    );
                  }
                  //landed pieces
                  else if (gameBoard[row][col] != null) {
                    final Tetromino? tetrominoType = gameBoard[row][col];
                    return Pixel(
                        color: tetrominoColors[tetrominoType], child: '');
                  }
                  //blank pixel
                  else {
                    return Pixel(
                      color: Colors.grey[900],
                      child: index,
                    );
                  }
                }),
          ),
          //game controls
          Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //left
                IconButton(
                  onPressed: moveLeft,
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back_ios),
                ),
                //rotate
                IconButton(
                  onPressed: rotatePiece,
                  color: Colors.white,
                  icon: Icon(Icons.rotate_right),
                ),
                //right
                IconButton(
                  onPressed: moveRight,
                  color: Colors.white,
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
