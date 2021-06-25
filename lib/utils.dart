import 'dart:math';

class Utils {
  static int getBoundedRandomNumber(int min, int max) {
    assert(
      min < max,
      'utils.getBoundedRandomNumber: min ($min) should be less than max ($max)',
    );
    return Random().nextInt(max - min) + min;
  }
}
