module player.computer_player;

import player.player;
import board;

class ComputerPlayer : Player
{
    char mark;

    this(char mark)
    {
        this.mark = mark;
    }

    /**
    * Play Tic Tac Toe using MinMax algorithm.
    */
    public override void play(int location, Board board)
    {
        board.move(location, mark);
    }
}
