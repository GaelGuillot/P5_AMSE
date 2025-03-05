# AMSE TP1: Music Database

This flutter project, made in the context of the AMSE course for IMT Nord Europe by Denis Dagbert and Gaël Guillot, serves as a slightly more advanced app-building exercise, in order to get used to flutter and the dart programming language. 

### Objectives: 

The goal of this project was to solve a series of small exercises, building up to the creation of a tile sliding puzzle.
Each exercise, including the puzzle, must be accessible via a home screen where they are listed.

## Running the project

Running the project should be as simple as cloning the github repository

```bash
git clone https://github.com/GaelGuillot/P5_AMSE.git
```

Then, navigating to the correct repository

```bash
cd P5_AMSE/TPFlutter/tp1_music_database
```

Grabbing the required flutter pub files

```bash
flutter pub get
```

And finally, running the project

```bash
flutter run
```

## Puzzle UI:

To try the tile sliding puzzle out, move to the Exercise 7 tab from the home screen.
You will be greeted with a random image sectionned into tiles, along with a simple user interface.

- The + and - buttons will respectively increase and decrease the amount of tiles forming the image. More tiles will make solving the puzzle more difficult.
- The "New image" button will load a new random image.
- The "Shuffles" slider will change the amount of moves done when when shuffling the tiles. The values it may take depend on the number of tiles.
- The "Start" button will remove a tile, shuffle the remaining tiles, and change the interface.

Once the game has started, new elements of the UI will appear

- The "New Image", -, and + buttons will be disabled.
- The "Start" button will be replaced by a reset button.
- The "Shuffles" slider will be replaced by a "Show numbers" checkbox. When ticked, the image tiles will be replaced with their placement number, starting at 1.
- An "Undo" button will appear, allowing the user to undo their moves, if any have been played.
- A timer and move counter will appear.

Finally, beating the game will display a win message informing the player of their time and movecount. Once the user clicks "OK", they can choose to either reset the grid, or view a sped up replay of their game.
