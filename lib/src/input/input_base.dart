part of duengine;

/**
 * Abstract Class that Represent a [InputBase].
 *
 * This Input is used as a base for all input operations.
 */
abstract class InputBase {
  /// Should return the available triggers for the input type.
  List<String> get triggers;

  /// Must return true if the requested [trigger] is triggered.
  bool check(String trigger);
}
