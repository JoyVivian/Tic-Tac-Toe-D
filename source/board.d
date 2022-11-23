module board;

import std.range;
import std.format;
import std.stdio;
import std.algorithm;
import std.random;

/** 
 * This is the class for the current board.
 *
 */
class Board {
    char[10] cells = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '];

    /** 
     * Get the string of current board status.
     *
     * Returns: The string of current board status
     */
    string display() {
        string first = format("%c | %c | %c\n", cells[1], cells[2], cells[3]);
        string separator = ("---------------\n");
        string second = format("%c | %c | %c\n", cells[4], cells[5], cells[6]);
        string third = format("%c | %c | %c\n", cells[7], cells[8], cells[9]);

        string total = first ~ separator ~ second ~ separator ~ third;
        
        return total;
    }


    /** 
     * Update a cell.
     * Params:
     *  - location: the index of the cell
     *  - mark: the mark to put into the cell.
     */
    void updateCell(char[] cur_board, int location, char mark) {
        if (location < 1 || location > 9) {
            throw new Exception("This location is illegal");
        }

        if (mark != 'X' && mark != 'O') {
            throw new Exception(format("mark parameter can only be X or O, but input is %c", mark));
        }

        if (is_valid(location)) {
            cur_board[location] = mark;
        } 
    }


    void move(int location, char mark) {
        updateCell(cells, location, mark);
    }

    /** 
     * Check if there is a winner.
     *
     * Returns: the mark for the winner or ''.
     */
    public char is_win() {
        return check_win(cells);
    }

    private char check_win(char[] cur_state) {
        if (check('X', cur_state)) {
            return 'X';
        } 

        if (check('O', cur_state)) {
            return 'O';
        }

        return ' ';
    }

    /** 
     * Check if the cirrent status is tie.
     *
     * Returns: A boolean representa whether it is tie or not.
     */
    public bool is_tie() {
        return check_tie(cells);
    }
    
    private bool check_tie(char[] cur_state) {
        if (!has_empty(cur_state) && check_win(cur_state) == ' ') {
        return true;
      } 

      return false;
    }

    private bool has_empty(char[] cur_state) {
        for (int i = 1; i < cells.length; i++) {
            if (cur_state[i] == ' ') {
                return true;
            }
        }

        return false;
    }

    /** 
     * This is a helper method for `isWin()`.
     *
     * Params:
     *    - mark: the mark for the winner or ''.
     * Returns: If there is a winner, return the winner's mark; If not, return an empty cahracter.
     */
    private bool check(char mark, char[] cells) {
        if (mark != 'X' && mark != 'O') {
            throw new Exception(format("mark can only be X or O, but the input is: %c", mark));
        }

        // Check lines.
        for (int i = 1; i <= 6; i+=3) {
            if (cells[i+0] == mark && cells[i + 1] == mark && cells[i + 2] == mark) {
                return true;
            }
        }

        // Check columns.
        for (int i = 1; i <=3; i++) {
            if (cells[i+0] == mark && cells[i + 3] == mark && cells[i + 6] == mark) {
                return true;
            }
        }
        // Check diagonals.
        if ((cells[1] == mark && cells[5] == mark && cells[9] == mark)
        || (cells[3] == mark && cells[5] == mark && cells[7] == mark)) {
            return true;
        }

        return false;
    }
    
    /**
    * Params:
    *   - location: int represents the location to check.
    * Returns: If the location is valid, return true; Otherwise, return false.
    */
    public bool is_valid(int location) {
        if (location < 1 || location > 9) {
            throw new Exception("This location is illegal");
        }

        return cells[location] == ' ' ? true : false;
    }

    /**
    * Show instruction board to player to help them understand location.
    */
    public string show_instruction_board() {
        string first = "1 | 2 | 3 \n";
        string separator = "---------------\n";
        string second = "4 | 5 | 6 \n";
        string third = "7 | 8 | 9 \n";

        string total = first ~ separator ~ second ~ separator ~ third;
        
        return total;
    }

    /** 
    * Evaluation function for `MinMax` algorithm.
    * 
    * PlayerX is always the computer player. 
    * Return 10 if `X` wins; Return -10 if `O` wins. Return 0 if tie. Otherwise, return 1.
    */
    private int evaluate(char[] cur_state) {
        if (check('X', cur_state)) {
            return 10;
        }

        if (check('O', cur_state)) {
            return -10;
        }

        if (check_tie(cur_state)) {
            return 0;
        }

        return 1;
    }

    public int[] get_legal_moves(char[] cur_state) {
        int[] legal_moves;

        for(int i = 1; i < cells.length; i++) {
            if (cur_state[i] == ' ') {
                legal_moves ~= i;
            }
        }

        return legal_moves;
    }

    private char[] get_next_state(char[] cur_state, int act_location, char mark) {
        char[] next_state = cur_state.dup();

        if (cur_state[act_location] == ' ') {
            next_state[act_location] = mark;
        } 

        return next_state;
    }

    private int get_max(char[] cur_state) {
        int score = evaluate(cur_state);

        // Terminate tests.
        if (score == 10 || score == -10 || score == 0) {
            return score;
        }

        int max_value = -10000;

        foreach(int move; get_legal_moves(cur_state)) {
            char[] next_state = get_next_state(cur_state, move, 'X');
            int tmp_max = get_min(next_state);
            
            max_value = max(max_value, tmp_max);
        }

        return max_value;
    }

    private int get_min(char[] cur_state) {

        int score = evaluate(cur_state);

        // Terminate tests.
        if (score == 10 || score == -10 || score == 0) {
            return score;
        }

        int min_value = 10000;
        
        foreach(int move; get_legal_moves(cur_state)) {
            char[] next_state = get_next_state(cur_state, move, 'O');
    
            int tmp_min = get_max(next_state);
            
            min_value = min(min_value, tmp_min);
        }

        return min_value;
    }

    public int find_best_move() {
        int max_value = -10000;
        int max_act = -1;

        char [] cur_state = this.cells.dup();

        foreach(int move; get_legal_moves(cur_state)) {
            char[] next_state = get_next_state(cur_state, move, 'X');

            int tmp_max = get_min(next_state);

            if(max_value < tmp_max) {
                max_value = tmp_max;
                max_act = move;
            }
        }

        return max_act;
    }

    public int get_random_legal_move() {
        int[] legal_moves = get_legal_moves(this.cells);
        
        auto rnd = MinstdRand0(42);
        auto val = legal_moves.choice(rnd);
        return val;
    }
}



