library input_buffer_test;

import "package:unittest/unittest.dart";
import "package:duengine/duengine.dart";
import "helper.dart";

void main() {
  group("InputBuffer", () {
    InputBuffer buffer;
    InputFake input;

    setUp(() {
      input = new InputFake(["A", "B", "C", "D", "", "D", "D"]);
      buffer = new InputBuffer(input, 10);
    });

    group("Constructor", () {
      test("it should create a buffer with the requested length.", () {
        expect(buffer.length, equals(10));
      });

      test("it should create a buffer with the requested input.", () {
        expect(buffer.input, equals(input));
      });
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

//      test("should return false while testing for the same input in a row if they were just pressed.", () {
//        buffer.update();
//        buffer.update();
//        buffer.update();
//        expect(buffer.checkCommand(new InputCommand(["D", "D"]), 2), equals(false));
//      });

      test("should return true while testing for the same input in a row if there is a delay between them.", () {
        buffer.update();
        buffer.update();
        expect(buffer.checkCommand(new InputCommand(["D", "D"]), 2), equals(true));
      });
    });

    group("clear", () {
      test("should remove the current inputs in the buffer.", () {
        buffer.update();
        expect(buffer.checkCommand(new InputCommand(["A"]), 1), equals(true));
        buffer.clear();
        expect(buffer.checkCommand(new InputCommand(["A"]), 1), equals(false));
      });
    });

  });
}
