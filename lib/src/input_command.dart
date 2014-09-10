part of duengine;

/**
 * Class that represents a [InputCommand].
 * A [InputCommand] is a sequence of actions, like: ["Up", "Down", "Up", "Down"].
 * The [InputCommand] enable you to create complex actions to be checked in a [InputBuffer].
 */
class InputCommand {
  /// The list of [actions] of this Command
  List<String> actions;

  /// The callback to be called.
  Function callback;

  /// Creates a new [InputCommand].
  InputCommand(this.actions, [this.callback]);

  /**
   * Method that describes the Sprite Object returning a [String].
   */
  String toString() => "InputCommand(actions: $actions, callback: $callback)";

  int get length => actions.length;

  /**
   * Method that compares 2 [InputCommand]s.
   * It is used for sorting a list of [InputCommand]s desc.
   */
  static Compare(InputCommand a, InputCommand b){
    return b.length - a.length;
  }
}