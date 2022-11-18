module random.real_random;

import std.random;
import random.random_value;

/** 
 * Generates a random number in [0, 1].
 */
class RealRandom : RandomValue {
    public int get_random_value() {
        auto rnd = MinstdRand0(42);
        auto val = [0, 1].choice(rnd);
        return val;
    }
}