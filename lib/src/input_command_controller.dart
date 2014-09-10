part of duengine;

class InputCommandController {
  List<InputCommand> _commandList;
  InputBuffer _buffer;
  int _delay = 5;

  InputCommandController(InputBase input, List<InputCommand> commandList, [int delay]) {
    _commandList = commandList;
    // TODO Sort the command lsit
//    _commandList.sort();
    _buffer = new InputBuffer(input, 30);
    if (delay != null) _delay = delay;
  }

  void update() {
    _buffer.update();
    for (int i = 0; i < _commandList.length; ++i) {
      InputCommand command = _commandList[i];
      if (_buffer.checkCommand(command, _delay) && consumeCommand(command)) {
        _buffer.clear();
        break;
      }
    }
  }

  bool consumeCommand(InputCommand command) {
    return (command.callback != null && command.callback() == true);
  }

}