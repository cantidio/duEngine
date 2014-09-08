library tile_test;

import "package:unittest/unittest.dart";
import 'package:mockito/mockito.dart';
import "package:duengine/duengine.dart";
import "package:gorgon/gorgon.dart";
import "helper.dart";

void main() {

  group("Tile", () {
    Tile tile;

    setUp(() {
      tile = new Tile([new MockSprite(), new MockSprite()], delay: 1);
    });

    group("constructor", () {
      test("members should match the provided values", () {
        expect(1, equals(1));
      });

      test("timeOn should be 0", () {
        expect(tile.timeOn, equals(0));
      });

      test("frameOn should be 0", () {
        expect(tile.frameOn, equals(0));
      });
    });

    group("update", () {
      test("it should add +1 in the timeOn", () {
        tile.update();
        expect(tile.timeOn, equals(1));
      });

      test("it should add +1 in the frameOn when the timeOn reaches the delay value", () {
        tile.update();
        tile.update();
        expect(tile.frameOn, equals(1));
      });

      test("it should set the timeOn to 0 when the timeOn reaches the delay value", () {
        tile.update();
        tile.update();
        expect(tile.timeOn, equals(0));
      });

      test("it should set the frameOn to 0 when the frameOn reaches the spritelist length", () {
        tile.update();
        tile.update();
        //frame 1
        tile.update();
        tile.update();
        //frame 0
        expect(tile.frameOn, equals(0));
      });
    });

    group("draw", () {
      Point2D position = new Point2D.zero();
      test("it should draw the current sprite", () {
        tile.draw(position);
        verify(tile.sprites[tile.frameOn].draw(position, alpha: any, mirroring: any, rotation: any, scale: any));
      });
    });

  });
}
