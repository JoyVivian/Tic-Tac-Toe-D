import std.stdio;

import game_model;
import controller;

void main()
{
    // Choose human opponent or computer.
    char option = '\0';
    bool is_computer = false;
    while (option == '\0')
    {
        writefln("Do you want compputer to be your opponent?(N/y)");
        readf(" %c", &option);

        if (option == 'Y' || option == 'y')
        {
            is_computer = true;
        }

        break;
    }

    GameModel game_model = new GameModel(is_computer);
    Controller controller = new Controller(is_computer);
    controller.start_game(game_model, true);
}
