part of duengine;

/**
 * Class that represents an [InputBuffer].
 * The [InputBuffer] is a buffer that stores each combination of triggers provided by some
 * [InputBase] class and provide the mechanisms for checking for their activation.
 */
class InputBuffer {
  int _currentFrame = 0;
  List<String> _buffer;

  /// The Input that will be used to update the buffer.
  InputBase input;

  /// Return the length of the [InputBuffer].
  int get length => _buffer.length;

  /**
   * Create a new [InputBuffer] using a [InputBase].
   * The provided [input] will be used for checking if the [InputCommand] actions are triggered.
   * The [bufferLength] is the length of this [InputBuffer].
   */
  InputBuffer(InputBase input, int bufferLength) {
    this.input = input;
    _buffer = new List<String>(bufferLength);
    clear();
  }

  /**
   * Method to clear the [InputBuffer].
   */
  void clear() {
    _buffer.fillRange(0, _buffer.length, "");
  }

  /**
   * Update the [InputBuffer].
   * Should be called once each game cicle.
   */
  void update() {
    ++_currentFrame;
    _currentFrame %= _buffer.length;
    _buffer[_currentFrame] = "";
    input.triggers.forEach((String trigger) {
      if (input.check(trigger)) {
        _buffer[_currentFrame] += trigger + "+";
      }
    });
  }

  /**
   * Method that checks if the requested [action]s are triggered.
   * TODO optimize this, maybe migrate this method to the [InputCommand].
   */
  bool checkAction(String pressed, List<String> actions) {
    if (pressed != "") {
      for (int i = 0; i < actions.length; ++i) {
        List<String> actionEntries = actions[i].split("+");
        bool checked = true;
        for (int j = 0; j < actionEntries.length; ++j) {
          if (pressed.indexOf(actionEntries[j]) == -1) {
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
   * Method that checks if the requested [InputCommand] was executed in this [InputBuffer].
   * You should provide a [delay] for it. This is the maximum [delay] allowed between [InputCommand] action.
   */
  bool checkCommand(InputCommand command, int delay) {
    int pos = _currentFrame;
    int currentAction = command.actions.length - 1;
    int currentDelay = delay - 1;
    for (int i = 0; i < delay * command.actions.length && currentAction >= 0 && delay != currentDelay; ++i) {
      //  TODO check for empty input between the same sequential input. EX : ["Right", "Right"]
      ++currentDelay;

      if (checkAction(_buffer[(pos - i) % _buffer.length], command.actions[currentAction].split("/"))) {
        --currentAction;
        currentDelay = 0;
      }
    }
    return (currentAction == -1);
  }
}
