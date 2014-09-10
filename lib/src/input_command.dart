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
}