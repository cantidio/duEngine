part of duengine;

/**
 * This class represents a Input Command Controller.
 * It can uses a custom [InputBase] to check against a list of [InputCommand]s.
 * It will create a [InputBuffer] and checks the [InputCommand] List for a match, when it happens
 * it then triggers your [InputCommand] callback.
 */
class InputCommandController {
  List<InputCommand> _commandList;
  InputBuffer _buffer;
  int _delay;

  InputCommandController(InputBase input, List<InputCommand> commandList, [int delay=5]) {
    if (commandList == null || commandList.length < 1) {
      throw new ArgumentError("CommandList should have at least one InputCommand.");
    }
    _commandList = commandList;
    _commandList.sort(InputCommand.Compare);
    _delay = delay;
    _buffer = new InputBuffer(input, _commandList[0].length * _delay);
  }

  void update() {
    _buffer.update();
    for (int i = 0; i < _commandList.length; ++i) {
      InputCommand command = _commandList[i];
      if (_buffer.checkCommand(command, _delay) && consumeCommand(command)) {
        break;
      }
    }
  }

  bool consumeCommand(InputCommand command) {
    return (command.callback != null && command.callback() == true);
  }
}
