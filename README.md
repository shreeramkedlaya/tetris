# Tetris Game using Flutter

This is a simple Tetris game implemented using the Flutter framework. Tetris is a popular tile-matching puzzle game where the player needs to manipulate falling tetromino shapes to create complete horizontal lines.

## Getting Started

To get started with the Tetris game, follow the instructions below:

### Prerequisites

- Flutter SDK: Make sure you have Flutter SDK installed on your system. You can download it from the official Flutter website: https://flutter.dev

### Installation

1. Clone the repository or download the source code:
   git clone https://github.com/shreeramkedlaya/tetris.git

2. Navigate to the project directory:
   cd tetris-flutter

3. Fetch the dependencies:
   flutter pub get

4. Run the app:
   flutter run

## Game Controls

- **Left**: Move the tetromino left.
- **Right**: Move the tetromino right.
- **Rotate**: Rotate the tetromino clockwise.
- **Down**: Instantly drop the tetromino to the bottom.

## Features

- Random generation of tetromino shapes.
- Control the movement and rotation of tetrominoes.
- Clearing completed lines.
- Keeping track of the score.
- Game over detection.
- Simple and intuitive user interface.

## Directory Structure

The project directory is structured as follows:

- `lib/`: Contains the main Dart code for the Tetris game.
  - `main.dart`: The entry point of the application.
  - `board.dart`: The game board display and the whole architecture
  - `piece.dart`: Definition of each piece and the place that is occupied when the rotated
  - `pixel.dart`: Design of each pixel of the Tetromino piece
  - `values.dart`: The different values/definitions required by the tetris application to work, e.g., Colors, Directions,etc.
## Contributing

Contributions to this Tetris game are welcome! If you have any suggestions, bug reports, or feature requests, please open an issue on the GitHub repository.

## Acknowledgments

- The Tetris game logic is based on the classic Tetris game by Alexey Pajitnov.
- This project was inspired by various Tetris implementations and tutorial available online.

**Have fun playing Tetris!**
