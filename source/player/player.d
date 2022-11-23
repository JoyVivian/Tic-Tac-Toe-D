module player.player;

import board;

/**
* Interface for player factory.
*/
interface Player {
    void play(int location, Board board);
}
