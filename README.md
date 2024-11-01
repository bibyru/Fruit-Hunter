## 📔 Game Description
![Gif of Trash Grabbers gameplay](https://github.com/bibyru/bibyru/blob/main/Gifs/FruitHunter.gif)

**Fruit Hunter** is a short 2D platformer game where you collect the most fruits in the fastest time and least deaths.

Download game [here](https://drive.google.com/file/d/19ChyNNeD2Bx9-849sNL_KdqG6j2dKO1x/view).

<br/>

## 🎮 Game Controls
| **Action** | **Key binding** |
| :- | :- |
| Move | W, A, S, D |
| Jump | Space |

<br/>

## 📝 Project Info
This project was developed using Godot v4.0.
| **Role** | **Credit** | **Development Time** |
| :- | :- | :- |
| Game programmer | bibyru (Ruby) | 1 days |
| Project lead | bibyru (Ruby) | 2 days |
| Visual designer | bibyru (Ruby) | 1 day |
| Game designer | bibyru (Ruby) | 1 day |
| Sound designer | bibyru (Ruby) | 1 day |

<br/>

## ⭐ Scripts and Features
| **Script** | **Description** |
| :- | :- |
| `Death.gd` | Script for Area to kill player if collided. |
| `DotFollower.gd` | Script for Moving Platform objects to move to a dot location. |
| `Flag.gd` | Script for Flag object to detect if player is in win Area. |
| `Fruit.gd` | Script for Fruit objects to delete self when collided. |
| `InGameUI.gd` | Script for in-game UI to self initialize. |
| `Level-1.gd` | Script for level 1 to reset fruit counter. |
| `PauseMenu.gd` | Singleton script for pause menu to manage its buttons, manage levels, and count fruits and time. |
| `Player.gd` | Script for player avatar to move and call `PauseMenu.gd` functions. |
| `RecordsMenu.gd` | Script for records menu to display all records of the game. |
| `StartMenu.gd` | Script for main menu to manage its buttons. |

<br/>

## 📁 File Description
```
├── FruitHunter
    ├── Output    # for testing on writing to file (save records)
    ├── Prefabs   # for game objects used in a level
        ├── DeathThings    # stores game objects that kill players (traps)
        ├── Fruits         # stores fruit objects
        ├── UI             # stores UI type objects
    ├── Scenes    # for managing levels
    ├── Scripts   # for scripts used in the game
    ├── Sources   # for assets used in the game
        ├── fonts          # stores fonts used in the game
        ├── mp3            # stores sounds used in the game
        ├── sprites        # stores sprites used in the game
    ├── Themes    # for managing UI assets
    ├── Tilemaps  # for managing tilemap objects
```

<br/>

## 💿 How to Open in Game Engine
1. Download all files.
2. Extract to **Folder A** (an empty folder).
3. Launch Godot v4.0.
4. Press **Import** and select `project.godot` in **Folder A**.

_Assets used:_
+ Music: https://youtu.be/5GxDeCGFtDo?si=-vm_IuoMtMF9fD0_
+ Pixel Adventure 1: https://assetstore.unity.com/packages/2d/characters/pixel-adventure-1-155360
