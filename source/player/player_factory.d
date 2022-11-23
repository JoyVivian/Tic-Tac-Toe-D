module player.player_factory;

import player.player;
import player.man_player;
import player.computer_player;

/** 
* Class to generate human player or computer palyer according to `is_computer`.
*/
class PlayerFactory {
    public Player get_player(bool is_computer, char mark) {
        if (is_computer) {
            return new ComputerPlayer(mark);
        } else {
            return new ManPlayer(mark);
        }
    }
}