module game_model;

import std.stdio;
import std.random;

import player.player;
import player.player_factory;

import board;

/** 
* Model layer for this game.
*/
class GameModel
{
    Player player_x;
    Player player_o;
    Board board;

    /** 
    * Constructor for `GameModel`.
    * Params:
    * - is_computer: Represents the opponent of the game is compoter or not.
    */
    this(bool is_computer)
    {
        PlayerFactory player_factory = new PlayerFactory();
        player_x = player_factory.get_player(is_computer, 'X');
        player_o = player_factory.get_player(false, 'O');

        board = new Board();
    }

    /** 
    * Check whether there is a winner or not.
    */
    public char is_win()
    {
        return board.is_win();
    }

    /** 
    *  CHeck whether the current state is tie or not.
    */
    public bool is_tie()
    {
        return board.is_tie();
    }

    /** 
    * Check whether a location is valid or not.
    */
    public bool is_valid(int location)
    {
        return board.is_valid(location);
    }

    /** 
    * Show the game instruction.
    */
    public string show_instruction_board()
    {
        return board.show_instruction_board();
    }

    /**
    *  Player play and use this function to update status of board.
    */
    public void play(bool is_computer, int location, char mark)
    {
        int move = -1;
        if (is_computer)
        {
            int random_move = board.get_random_legal_move();

            if (roll() == 0)
            {
                move = board.find_best_move();
            }
            else
            {
                move = random_move;
            }
        }
        else
        {
            move = location;
        }

        if (mark == 'X')
        {
            player_x.play(move, board);
        }

        if (mark == 'O')
        {
            player_o.play(location, board);
        }
    }

    /**
    * Display the current board state.
    */
    public string display()
    {
        return board.display();
    }

    /** 
    * Helper function for play(). There has 60% chance that the computer player will choose the best move using `MinMax` Algorithm. 
    *           Otherwise, it will choose a random legal move.
    */
    private auto roll()
    {

        auto val = dice(0.6, 0.4);

        writeln(val);

        return val;
    }
}
