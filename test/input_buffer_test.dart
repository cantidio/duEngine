library input_buffer_test;

import "package:unittest/unittest.dart";
import 'package:mockito/mockito.dart';
import "package:duengine/duengine.dart";
//import "package:gorgon/gorgon.dart";
import "helper.dart";

class InputFake implements InputBase {
  List<String> _inputList;
  int current = -1;

  List<String> get triggers {
    current++;
    if (current < _inputList.length) return [_inputList[current]];
    return [];
  }

  InputFake([List<String> inputList]) {
    _inputList = inputList != null ? inputList : new List<String>();
  }

  bool check(String trigger) {
    return current < _inputList.length && _inputList[current] == trigger;
  }
}

void main() {
  group("InputBuffer", () {
    InputBuffer buffer;
    InputFake input;
    setUp(() {
      input = new InputFake(["A", "B", "C", "D"]);
      buffer = new InputBuffer(input, 10);
    });

    group("checkCommand", () {
      setUp(() {
        for (int i = 0; i < 4; ++i) {
          buffer.update();
        }
      });

      test("should return true if the command was executed in the last update.", () {
        expect(buffer.checkCommand(new InputCommand(["D"]), 1), equals(true));
      });

      test("should return false if the command was not executed in the last update.", () {
        expect(buffer.checkCommand(new InputCommand(["C"]), 1), equals(false));
      });

      test("should return true if the composed command was executed starting on the last update.", () {
        expect(buffer.checkCommand(new InputCommand(["A", "B", "C", "D"]), 1), equals(true));
      });

      test("should return false if the composed command was executed, but the delay between each trigger was bigger than the delay requested.", () {
        expect(buffer.checkCommand(new InputCommand(["B", "D"]), 1), equals(false));
      });

    });

  });
}
