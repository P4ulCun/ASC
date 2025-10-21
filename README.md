# ⭕ Tic-Tac-Toe x86

A classic Tic-Tac-Toe game implemented entirely in x86 assembly language for the terminal.

![Language](https://img.shields.io/badge/Language-x86%20Assembly-red)
![Platform](https://img.shields.io/badge/Platform-Linux-yellow)

## 📋 Overview

This project is a fully functional two-player Tic-Tac-Toe game written in pure x86 assembly. Players take turns marking spaces on a 3x3 grid, with the goal of getting three marks in a row horizontally, vertically, or diagonally.

## ✨ Features

- 🎮 Two-player gameplay
- 💻 Terminal-based interface
- ✅ Win condition detection
- 🔄 Draw/tie game handling
- 🎯 Input validation
- 📊 Live board display

## 🛠️ Technical Details

- **Architecture**: x86 (32-bit)
- **Assembler**: NASM (Netwide Assembler)
- **System Calls**: Linux syscalls for I/O operations
- **Pure Assembly**: No high-level language dependencies

## 🚀 Building & Running

### Prerequisites

- NASM assembler
- ld linker (part of binutils)
- Linux operating system (or WSL on Windows)

### Build Instructions

```bash
# Assemble the source code
nasm -f elf32 tictactoe.asm -o tictactoe.o

# Link the object file
ld -m elf_i386 tictactoe.o -o tictactoe

# Run the game
./tictactoe
```

## 🎮 How to Play

1. The game displays a 3x3 grid numbered 1-9
2. Player 1 (X) and Player 2 (O) alternate turns
3. Enter the position number (1-9) where you want to place your mark
4. First player to get three in a row wins
5. If all spaces are filled with no winner, the game is a draw

```
 1 | 2 | 3
-----------
 4 | 5 | 6
-----------
 7 | 8 | 9
```

## 💡 Learning Highlights

This project demonstrates low-level programming concepts:

- Direct system call usage (read, write, exit)
- Memory management and data structures in assembly
- Control flow with jumps and comparisons
- String manipulation at the byte level
- Register management and stack operations
- Efficient algorithm implementation in assembly

## 📝 License

This project is open source and available for educational purposes.

---

**Built with zeros, ones, and registers!** 🔧⚙️
