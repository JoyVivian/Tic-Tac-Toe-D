module random.false_random;

import random.random_value;

/** 
 * Always return 1 for testing purposes.
 */
class FalseRandom : RandomValue {
    public int get_random_value() {
        return 1;
    }
}