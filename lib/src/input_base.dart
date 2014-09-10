part of duengine;

/**
 * Abstract Class that Represent a [InputBase].
 *
 * This Input is used as a base for all input operations.
 */
abstract class InputBase {
  List<String> get triggers;
  bool check(String key);
}
