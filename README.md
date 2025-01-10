# Sokoban-Assembly-Project

## Overview
This project is a University of Toronto **CSC258** assignment that implements the classic Japanese box-pushing game **Sokoban**. The game is written in **assembly language** and utilizes the **Ripes IDE** for compiling, simulating, and running the assembly code. Gameplay is rendered on a **LED display**, with **arrow buttons** for navigation and a **terminal interface** for user communication.

---

## Features
- **Assembly Language Implementation**: The game logic is entirely written in MIPS assembly.
- **Interactive Gameplay**: Users can navigate the Sokoban game using arrow keys.
- **LED Display Output**: Visual rendering of the game is shown on an LED display.
- **Terminal Interface**: Provides feedback and instructions for user interaction.
- **Compact Design**: Optimized to run within the constraints of a basic assembly environment.

---

## Getting Started

### Prerequisites
1. **Ripes IDE**: A graphical IDE for RISC-V assembly language programming and simulation. Download it [here](https://github.com/mortbopet/Ripes).
2. **LED Display Simulator**: Ensure your Ripes setup supports LED matrix output.
3. **Basic Understanding of MIPS Assembly**: Familiarity with MIPS instructions is recommended.

### Files
- **`assemblystarter.s`**: Starter code for the Sokoban game logic.
- **`starter.s`**: Additional assembly modules for functionality.

---

## How to Run
1. Open the Ripes IDE.
2. Load the `assemblystarter.s` file.
3. Configure the input/output to simulate the LED display and terminal interface.
4. Run the program to start the game.
5. Use arrow keys to control the character in the game.

---

## Gameplay
### Objective
Push all the boxes onto the designated storage locations while navigating the character around obstacles.

### Controls
- **Arrow Keys**: Move the character up, down, left, or right.

### Rules
1. Boxes can only be pushed, not pulled.
2. Only one box can be pushed at a time.
3. The game ends when all boxes are placed in the designated positions.

---

## Project Structure
- **Game Logic**: Handles player movement, collision detection, and win condition checks.
- **Display Rendering**: Updates the LED display to reflect the current game state.
- **Input Handling**: Processes user inputs (arrow keys) for gameplay actions.

---

## Challenges and Learning Outcomes
- Implementing complex game logic within the constraints of MIPS assembly.
- Managing efficient memory usage for real-time rendering and game state management.
- Leveraging low-level hardware interaction through the Ripes IDE.

---

## Future Improvements
- **Enhanced Graphics**: Support for more sophisticated visual rendering.
- **Dynamic Levels**: Load different levels dynamically from external files.
- **Improved Input**: Add support for additional input devices.

---

## Acknowledgments
This project was developed as part of the **CSC258** course at the University of Toronto. Special thanks to course instructors and TAs for their guidance.

---

## License
This project is for educational purposes only and is not intended for commercial distribution.



