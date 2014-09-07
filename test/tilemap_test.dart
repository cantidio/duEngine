library tilemap_test;

import "package:unittest/unittest.dart";
import 'package:mockito/mockito.dart';
import "package:duengine/duengine.dart";
import "package:gorgon/gorgon.dart";
import "helper.dart";
import 'dart:html';

void main() {
  group("TileMap", () {

    TileMap map;
    setUp(() {
      Display display = new Display(querySelector("#display"), width: 320, height: 240);
      map = new TileMap(10, 10, new Point2D(160, 120));
      map.tiles.add(new MockTile());
      map.tiles.add(new MockTile());
      map.tiles.add(new MockTile());
      map.tiles.add(new MockTile());
    });

    group("resize", () {
      group("when the dimention provided is bigger", () {
        test("should expand the map width", () {
          map.resize(30, 40);
          expect(map.width, equals(30));
        });

        test("should expand the map height", () {
          map.resize(30, 40);
          expect(map.height, equals(40));
        });

        test("should preserve the old tiles", () {
          map[0][0] = 0;
          map[0][1] = 1;
          map[1][0] = 2;
          map[1][1] = 3;

          map.resize(2, 2);

          expect(map[0][0], equals(0));
          expect(map[0][1], equals(1));
          expect(map[1][0], equals(2));
          expect(map[1][1], equals(3));
        });
      });

      group("when the dimention provided is smaller", () {
        test("should remove the extra columns", () {
          map.resize(10, map.height);
          expect(map.width, equals(10));
        });
        test("should remove the extra tile lines", () {
          map.resize(map.width, 10);
          expect(map.height, equals(10));
        });
        test("should raise argument error if the width provided is less than 1", () {
          expect(() => map.resize(0, 30), throwsArgumentError);
        });

        test("should raise argument error if the height provided is less than 1", () {
          expect(() => map.resize(30, 0), throwsArgumentError);
        });
      });
    });

    group("update", () {
      test("should update all tiles", () {
        Tile tile1 = new MockTile();
        Tile tile2 = new MockTile();
        map.tiles.add(tile1);
        map.tiles.add(tile2);
        map.update();
        verify(tile1.update());
        verify(tile2.update());
      });
    });

    group("draw", () {
      setUp(() {
        map[0][0] = 0;
        map[0][1] = 0;
        map[0][2] = 0;
        map[0][3] = 2;
        map[1][0] = 1;
        map[1][1] = 1;
        map[1][2] = 1;
        map[1][3] = 3;
      });
      test("should draw the tiles visible on the Display", () {
        Point2D position = new Point2D.zero();
        map.draw(position);
        verify(map.tiles[0].draw(any, scale: any));
        verify(map.tiles[1].draw(any, scale: any));
      });

      test("should not draw the tiles that are not visible on the Display", () {
        Point2D position = new Point2D.zero();
        map.draw(position);
        verifyNever(map.tiles[2].draw(any, scale: any));
        verifyNever(map.tiles[3].draw(any, scale: any));
      });
    });
  });
}
