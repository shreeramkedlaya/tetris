import 'dart:ui';
import 'package:tetris/board.dart';

import 'values.dart';

class Piece {
  Tetromino type;

  Piece({required this.type});

  List<int> position = [];
  Color get color {
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  //generate the integers
  void initPiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetromino.J:
        position = [-25, -15, -5, -6];
        break;
      case Tetromino.I:
        position = [-4, -5, -6, -7];
        break;
      case Tetromino.O:
        position = [-15, -16, -5, -6];
        break;
      case Tetromino.S:
        position = [-15, -14, -6, -5];
        break;
      case Tetromino.Z:
        position = [-17, -16, -6, -5];
        break;
      case Tetromino.T:
        position = [-26, -16, -6, -15];
        break;
      default:
    }
  }

  //move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowL;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  //rotate piece
  int rotationState = 1;

  void rotatePiece() {
    //new position
    List<int> newPosition = [];

    //rotate peiece based on its type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowL,
              position[1],
              position[1] + rowL,
              position[1] + rowL + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowL - 1
            ];

            /// check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowL,
              position[1],
              position[1] - rowL,
              position[1] - rowL - 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowL + 1,
              position[1],
              position[1] + 1,
              position[1] - 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.J:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowL,
              position[1],
              position[1] + rowL,
              position[1] + rowL - 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowL - 1,
              position[1],
              position[1] - 1,
              position[1] + 1
            ];

            /// check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowL + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - rowL + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowL,
              position[1],
              position[1] + rowL,
              position[1] + 2 * rowL
            ];

            /// check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + rowL,
              position[1],
              position[1] - rowL,
              position[1] - 2 * rowL
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.O:
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowL - 1,
              position[1] + rowL
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowL,
              position[0],
              position[0] + 1,
              position[0] + rowL + 1
            ];

            /// check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowL - 1,
              position[1] + rowL
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowL,
              position[0],
              position[0] + 1,
              position[0] + rowL - 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[0] + rowL - 2,
              position[1],
              position[2] + rowL - 1,
              position[3] + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowL + 2,
              position[1],
              position[2] - rowL + 1,
              position[3] - 1
            ];

            /// check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[0] + rowL - 2,
              position[1],
              position[2] + rowL - 1,
              position[3] + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowL + 2,
              position[1],
              position[2] - rowL + 1,
              position[3] - 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[2] - rowL,
              position[2],
              position[2] + 1,
              position[2] + rowL
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowL
            ];

            /// check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] - rowL,
              position[1] - 1,
              position[1],
              position[1] + rowL
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[2] - rowL,
              position[2] - 1,
              position[2],
              position[2] + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update pos
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      default:
    }
  }

  //check if valid position
  bool positionIsValid(int position) {
    int row = (position / rowL).floor();
    int col = position % rowL;

    //if the pos is taken, return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  //check if the piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;
    for (int pos in piecePosition) {
      // return false if any position is already taken
      if (!positionIsValid(pos)) {
        return false;
      }

      //get col of pos
      int col = pos % rowL;

      //check if the first or last column is occupied
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowL - 1) {
        lastColOccupied = true;
      }
    }

    // if there is a piece in the first col and last col, it is going through the wall
    return !(firstColOccupied && lastColOccupied);
  }
}
