module random.real_random;

import std.random;
import random.random_value;

/** 
 * Generates a random number in [0, 1].
 */
class RealRandom : RandomValue {
    public int get_random_value() {
        auto val = dice(0.5, 0.5);

        return val == 0 ? 0 : 1;
    }
}