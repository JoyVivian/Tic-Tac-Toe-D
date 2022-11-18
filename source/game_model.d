module game_model;

import std.stdio;

import player.player;
import player.player_factory;

import board;

class GameModel {
    Player player_x;
    Player player_o;
    Board board;

    this(bool is_computer) {
        PlayerFactory player_factory = new PlayerFactory();
        player_x = player_factory.get_player(is_computer, 'X');
        player_o = player_factory.get_player(false, 'O');
        
        board = new Board();
    }

    char is_win() {
        return board.is_win();
    }

    bool is_tie() {
        return board.is_tie();
    }

    bool is_valid(int location) {
       return board.is_valid(location); 
    }

    string show_instruction_board() {
        return board.show_instruction_board();
    }

    void play(bool is_computer, int location, char mark) {
        int move = -1;
        if(is_computer) {
            move = board.find_best_move();
        } else {
            move = location;
        }

        if (mark == 'X') {
            player_x.play(move, board);
        } 

        if (mark == 'O') {
            player_o.play(location, board);
        }
    }

    string display() {
        return board.display();
    }
}

