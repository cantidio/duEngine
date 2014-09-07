library tilemap_test;

import "package:unittest/unittest.dart";
import 'package:mockito/mockito.dart';
import "package:duengine/duengine.dart";
import "package:gorgon/gorgon.dart";
import "helper.dart";

void main() {
  group("TileMap", () {

    TileMap map;
    setUp(() {
      print("new tile map");
//      map = new TileMap(10, 10, new Point2D(8, 8));
    });

    group("resize", () {
      group("when the dimention provided is bigger", () {
//        test("should expand the map width", () {
//          map.resize(30, 40);
//          expect(map.width, equals(30));
//        });
//
//        test("should expand the map height", () {
//          map.resize(30, 40);
//          expect(map.height, equals(40));
//        });

        test("should preserve the old tiles", () {
          map = new TileMap(10, 10, new Point2D(8, 8));
          map[0][0] = 0;
          map[0][1] = 1;
          map[0][2] = 2;
          map[1][0] = 3;
          map[1][1] = 4;
          map[1][2] = 5;
          map[2][0] = 6;
          map[0][0] = 0;

         // map.resize(2, 3);

          print(map[0].hashCode);
          print(map[1].hashCode);
          print(map[2].hashCode);
//          print(map[2][0]);

          expect(map[0][0], equals(0));
          expect(map[0][1], equals(1));
//          expect(map[0][2], equals(2));
          expect(map[1][0], equals(3));
//          expect(map[1][1], equals(4));
//          expect(map[1][2], equals(5));
        });
      });

//      group("when the dimention provided is smaller", () {
//        test("should remove the extra columns", () {
//          map.resize(10, map.height);
//          expect(map.width, equals(10));
//        });
//        test("should remove the extra tile lines", () {
//          map.resize(map.width, 10);
//          expect(map.height, equals(10));
//        });
//        test("should raise argument error if the width provided is less than 1", () {
//          expect(() => map.resize(0, 30), throwsArgumentError);
//        });
//
//        test("should raise argument error if the height provided is less than 1", () {
//          expect(() => map.resize(30, 0), throwsArgumentError);
//        });
//      });

    });
  });
}
