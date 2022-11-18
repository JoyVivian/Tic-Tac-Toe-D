module random.random_factory;

import random.random_value;
import random.real_random;
import random.false_random;

/** 
 * Used to generate number according to `is_real` parameter for testing purpose.
 *  If `is_real` is true, return a `RealRandom` instance.
 *  If `is_real` is false, return a `FalseRandom` instance.
 */
class RandomFactory {
    public RandomValue create_random_instance(bool is_real) {
        if (is_real) {
            return new RealRandom();
        } else {
            return new FalseRandom();
        }
    }
}