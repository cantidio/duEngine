library input_command_test;

import "package:unittest/unittest.dart";
import "package:duengine/duengine.dart";

void main() {
  group("InputCommand", () {
    InputCommand command;

    setUp(() {
      command = new InputCommand(["A", "A/B", "A+B"]);
    });

    group("length", () {
      test("should return the correct length", () {
        expect(command.length, equals(3));
      });
    });

    group("checkAction", () {
      test("should return true if the action is present in the input", () {
        expect(command.checkAction("A", 0), equals(true));
      });

      test("should return false if the action is not present in the input", () {
        expect(command.checkAction("B", 0), equals(false));
      });

      test("should return true for any of the actions described with / in the action", () {
        expect(command.checkAction("A", 1), equals(true));
        expect(command.checkAction("B", 1), equals(true));
      });

      test("should return false if the action is not complete", () {
        expect(command.checkAction("A", 2), equals(false));
        expect(command.checkAction("B", 2), equals(false));
        expect(command.checkAction("A+B", 2), equals(true));
      });
    });
  });
}
