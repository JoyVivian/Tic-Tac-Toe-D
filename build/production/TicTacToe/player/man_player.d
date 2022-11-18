module player.man_player;

import std.stdio;

import player.player;
import board;

class ManPlayer : Player
{
    char mark;

    this(char mark)
    {
        this.mark = mark;
    }

    public override void play(int location, Board board)
    {
        board.move(location, mark);
    }
}
