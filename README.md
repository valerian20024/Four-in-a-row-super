# Four-in-a-row-super

## Relevance of the application

"Four-In-A-Row super" is an application that allows to play Four-In-A-Row (FIAR) on a mobile device. Contrarily to most of the already existing applications on the market, where the only way to play is the basic FIAR, this application allows to play different modes :

1. Classic : the base game (common with all FIAR applications).
2. Popout : the Popout version, popularized by Hasbro in the 70’s.
3. Custom : where a set of custom new rules can be mixed together as the user wishes.

The idea of a FIAR game that’s combined with Power Ups and fancy behaviors comes from playing the game [Chessplode](https://play.google.com/store/apps/details?id=com.juan.ma.chessplode&hl=en_US) which is a chess game where eating a pawn results in destroying all pawns in the same row and column. This application served as inspiration because it opened new possibilities for playing chess, namely having a more ’fun’ or ’arcade’ way to play, offering shorter and less serious games.

## How to use it

The `app-release.apk` file in the root directory is ready to use on an Android phone or emulator. Simply download it and install it.

## How it works

The player can play alone against an AI or with a friend on the same physical device. The user can decide to play a predefined game like Classic and Popout, or can customize its game by checking the rules to be present. All the rules present in the game are explained in a dedicated page. After choosing the number of players and the game mode, the user arrives onto the gameboard and can start playing the game.

Controls for a classic game are intuitive, especially since FIAR is a popular game, so they will not discussed. 
Yet controls for custom games can be explained very briefly. **Power Ups** allow the players to use special behaviors. There are two power ups : the **Bomb** and **Play Twice**. The bomb will be placed like any checkers and will destroy a 3 x 3 grid of checkers, whatever player they belong to. Play Twice allows the player to skip the next player’s turn and thus play twice in a row. Power Ups get consumed each time they are used. Players can gain Power Ups randomly, every 5 rounds.

**Grid Sizes** obviously change the number of rows and columns present in the grid. **Gravity Direction** allow players to place checkers e.g. from right to left, or from bottom to up. In case a checker gets to the boundary of the board (e.g. the left side) it will stay there. Players can’t place more checkers when a side is blocked. Those rules allow players to find richer patterns when trying to align checkers. After the player decided which rules to play with, it gets to the gameboard, which has been built according to its choice.

## Routing

Routing in the application is really intuitive as it is not complex. You can refer to the to have an idea of how it works, or you can simply navigate in the application.

# Code

## Structure

The code follows the Models-View-Controller architecture.

Specific assets (images, fonts, sounds) are contained in the `/assets` directory.

The `lib/` directory is composed of three directories : models/, views/ and controllers/ as
well as the main file. Let’s discuss them one by one :
1. `models/` contains the classes definition for the business logic. The classes are distributed across different files and put into dedicated folders. Those classes are for example `gameState`, `gameMode`, all the rules classes, and the scenario classes.

2. `views/` contains everything related to the UI, so all Flutter widgets are there. Inside `pages/` are all the screen the user sees, inside `styles/` are some custom classes made to gather the styling of the widgets (e.g. `BoxDecoration()`, `TextStyle()`, icons, etc.)
In the folder `widgets/` there are all the proper widgets that constitutes the parts of the UI. There are sometimes more than one class per file, as they are closely related to each others, for example there are a bunch of `AppBar` (or fake appbars callled "UpperBar") in the `appbars.dart` file, as well as different types of `BottomBar` in the `bottombars.dart` file.

3. The `controllers/` folder contains all the controllers, namely : the AI Controller, the Game Controller, the Rules Controller, the Scenario Controller, and the Player Controller.

## AI

The AI is based on a minimax algorithm using an alpha-beta pruning. Alpha-beta pruning is used only for not exploring subtrees that will not change the outcome of the minimax algorithm.
The AI’s search depth is controlled by the difficulty. There are 3 possible difficulty, easy, intermediate, hard, each difficulty change the depth of the minimax algorithm.

## Controllers

The **Player Controller** controls the settings link to the player. Indeed in our application, the user can decide to change players name and colors. This features was first developed to get a feeling with providers and has stayed since then, as it’s still pretty useful and fun for a game. This controller isn’t related whatsoever with the game itself. 

The **Game Controller** contains the biggest piece of logic for the code. It’s the controller that handles the actual game being played. Basically it instantiate a GameState class (which contains all the required information to play a game) and implements methods that are called by the UI to update the game state or retrieve information. It also implements a few helper methods that have a private visibility.

The **Scenario Controller** is the second biggest piece of logic, as it is the one that handles which rules the user wants to play with. In this application, a "Scenario" designates an object that contains a set of Rules as well as some metadata. The controller instantiate a Scenario class and implements a set of methods to be called by the UI to update or retrieve information about the current Scenario (mostly to put new rules, or remove them from the scenario). 

The **Rules Controller** is a bit different than the last two. It simply contains data for the different Rules. It implements a set of methods that instantiate the Rules. Contrarily to the Scenario Controller and Game Controller, it doesn’t extend ChangeNotifier and acts differently.

The **AI Controller** is responsible for managing the AI. It implements the required methods to run minimax on the current state and implements a method that’s called by the Game Controller to get the move from the AI.

## Provider

We are using the `Provider` library. This fits well with the MVC architecture and it allowed us to define controllers simply by extending the `ChangeNotifier` class. In those controllers, we simply have to put `notifyListeners()` each time we have changed a variable that is used by a widgets to trigger a rebuild of the relevant widgets. In the build method of the widgets, the controllers reference are retrieved using Provider.of<Class>(context) which will get the closest reference to the specified Class in the widget tree. To allow all the widgets to talk to the same controllers (i.e. the same objects), we have wrapped our MyApp() widget, which used to be the root of the widget tree, into a MultiProvider widgets, whose objective is to create the Controllers. This way, all the widgets further down the tree can have access to those controllers via the previous statement. You can look at the main.dart file for the actual code. 

# Challenges

## GameBoard

One of the big technical features of the application is to build the Gameboard (the UI) depending on the rules selected. Hence when a rule is selected, Scenario controller is updated, and then for example the Game Controller has to build a grid of the size selected by the Grid Size rule. The problem is thus that GameController needs to talk to ScenarioController. Thus in the `main.dart` file the Scenario controller is passed as a reference to the Game Controller. This breaks the MVC architecture but it was the only way figured out back then.

## Asynchronous programming

Asynchronous programming hasn't been used in the game (or really little). Even though the game doesn’t (yet) need it, as the experience is fluid on a phone, it would have been better to use it.

## AI

One of the challenges for the AI was to make a heuristic that would make the AI effective. The heristic is focusing on scoring board configurations based on potential formations of “four in a row” for the AI player, rewarding some patterns like three-in-a-rows with an empty slot and pieces in valuable columns, while penalizing similar threats from the opponent. 

# Problems

The application has been tested and normally doesn’t produce bugs when playing. However it sometimes required to add some ’fix’ code in the end of the development, just to be sure it doesn’t produce strange behaviors. This is clearly a bad practice and reflects the fact that there is a lack of structure in the application, which is mainly due to the fact that there is a blend of ’old’, sketchy code and more recent, cleaner code. 

Some parts of the software haven’t been thought enough in the early stage and thus it resulted in a loss of quality in the code. However, the code quality should be alright, at least for a small project. It’s obviously not perfect, and the app would clearly benefit from refreshing the old parts of the code.

A part of the developed widgets have some hardcoded size (for example the gameboard is 300px wide and high). This gives rise to a problem of overflow when shrinking too much the size of the application (well beyond an actual phone’s size). However, the game has been tested on a variety of phones (on real hardware) and there is no overflowing: the widgets have enough space not to overlap each others.
It has also been tested on a tablet and in this case, a part of the game’s UI feels a bit too small, because it is still coded to take the space of a phone. However most of the UI reacts correctly and takes the right amount of space to seamlessly integrate with the device’s screen. 
This problem concerns the following widgets : buttons, the gameboard, the falling checkers animation of the homepage (the random position along the horizontal axis spans from 0 to 7), a part of the reset slider. 

The code itself is not enough object-oriented. It sometimes feels too much procedural. For example, an early stage design was to create an AppColors class that would contain a set of attributes representing the only colors to be used in the application. While it allows to reuse the same colors and prevent unwanted colors to get into the UI, OOP could have been used by creating new class extending colors instead. The same applies for all the files in the /lib/views/style folder. There are also no dedicated classes for the different scenarios.

There’s a piece of logic in the code to make checkers fall (the method `_gravityfy()` in gameController). It’s used in two situations : when a players pops out a checkers (hence we need the checkers on top to get back to bottom) and when a bomb explodes. Indeed we wanted that, in the case of a normal gravity (i.e. from top to bottom only) and if the bomb power up is selected, exploding a bomb (which destroys a 3x3 grid) would result in the checkers falling back to the ground. While the algorithm of "gravityfying" works well and has been tested, for some unknown reason, it is not triggered when exploding a bomb. This is certainly linked to the fact the control flow in the game controller is all mingled, methods call nested into other method
calls. 

Clearly, the flow should have been theorized adequately before development, using FSM for example, and then actually coded.

Another problem concerns the code structure. There is a class in the models folder that contains UI logic (the `AppExitManager` in `exit_application.dart`). This breaks the MVC architecture and is thus not appropriate.

There is an overflow in the UI in some pages. This is only visible when running the app in debug mode, as Flutter tells us there is a "Bottom Overflowed by 6.0 pixels". This is an early stage bug. It is certainly due to overconstrained containers, back in the time we hardcoded their width and height. However, this ’visual bug’ doesn’t harm the usage at all, everything works fine. Yet it is still there and should have been patched.

Rules Controller allows to instantiate new Rules. However, it is not the OOP way of doing things. Indeed, we should have put all the data (e.g. rules descriptions) into the dedicated Rules class instead of creating an empty constructor that needs to get the data from somewhere else.
The same problem applies with the Scenario class (not the controller).

# Missing content and the future

This project is a school project that will eventually be upgraded in the future as a hobby. That's why I'm posting it on Github. The code really needs a big rewrite because Flutter was learned along the way.

Ideally the application would have grown even more, encompassing all the original versions of the game (Five-In-A-Row, Pop10, other Power Ups, etc. [Wikipedia](https://en.wikipedia.org/wiki/Connect_Four)) as well as a Scrabble-like grid that allows player to get bonus score when placing checkers on specific cells. A version with timers was also discussed in the early stages of development. Clearly, the amount of possibilities are huge. Those ideas are still relevant for the future of this application, which will go on living as a hobby. The current state of the application is a proof of concept. 

Sounds will certainly be added in the future when e.g. placing a checker, pushing a button, ex- ploding a bomb, etc. using the audioplayer library. Unfortunately, it appeared that using this library in the code required modifying .gradle files, updating Kotlin version, and possible other options to be tuned. Hence we decided to first focus on the main features of the game
and we didn’t implement this.

Ideally a page for selecting custom made scenarios should have been there. However, it's been decided not to implement it simply because there’s no point currently in making a system of dedicated scenarios, as the number of options for the rules is still relatively small. It is easy for a new user to just select the rules he wants, without selecting a scenario. Note that the Classic and Popout scenarios are already accessible when choosing to play a Base game.

Animations will also be added in the future, e.g. for when checkers (as well as bombs) fall in the grid. With more time and a better structured gameboard, there will be animations for making checkers fall when they are placed in the grid, as well as making them fall again when resetting the game, just like real checkers would do. 

# Licensing

As I have not yet identified a license that fully aligns with my goals for this project, particularly the requirement to restrict commercial use while allowing noncommercial sharing and modification, the software will remain proprietary for the time being. This means that, by default, all rights are reserved, and no one may use, modify, or distribute the code without explicit permission. I am actively exploring licensing options to make the project more accessible for noncommercial use in the future, and I welcome suggestions or feedback on this matter.

# Credits

This application has been developed first for the 2024-2025 edition of the [INFO2051-1 Object-oriented programming on mobile devices](https://www.programmes.uliege.be/cocoon/20242025/en/cours/INFO2051-1.html) class at Uliege.
It has been developped by Audric Demeure and Valérian Wislez.
