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

  /// Returns the description of the [InputCommand].
  String toString() => "InputCommand(actions: $actions, callback: $callback)";

  /// Return the length of the action list.
  int get length => actions.length;

  /// Return the requested action.
  String operator [](int i) {
    return actions[i];
  }

  /**
   * Method that checks if the requested [action] is triggered.
   */
  bool checkAction(String input, int action) {
    List<String> actions = this[action].split("/");

    if (input != "") {
      for (int i = 0; i < actions.length; ++i) {
        List<String> actionEntries = actions[i].split("+");
        bool checked = true;
        for (int j = 0; j < actionEntries.length; ++j) {
          if (input.indexOf(actionEntries[j]) == -1) {
            checked = false;
            break;
          }
        }
        if (checked) return true;
      }
    }
    return false;
  }

  /**
   * Method that compares 2 [InputCommand]s.
   * It is used for sorting a list of [InputCommand]s desc.
   */
  static Compare(InputCommand a, InputCommand b) {
    return b.length - a.length;
  }
}
