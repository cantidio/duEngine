library layer_test;

import "package:unittest/unittest.dart";
import 'package:mockito/mockito.dart';
import "package:duengine/duengine.dart";
import "package:gorgon/gorgon.dart";

class MockTileMap extends Mock implements TileMap {}
class MockGameObject extends Mock implements GameObject {}

void main() {

  Layer layer;
  MockTileMap tilemap;
  MockGameObject object1,object2;

  group("Layer", () {
    setUp(() {
      tilemap = new MockTileMap();
      object1 = new MockGameObject();
      object2 = new MockGameObject();
      layer = new Layer(tilemap, [object1,object2]);
    });

    group("constructor", () {
      test("members should match the provided values.", () {
        expect(1, equals(1));
      });
    });

    group("getRealPosition", () {
      test("should return the position relative to the layer scroll speed", () {
        layer.scrollspeed = new Point2D(0.5, 0.5);
        Point2D position = new Point2D(200, 200);

        expect(layer.getRealPosition(position), equals(new Point2D(100.0, 100.0)));
      });
    });

    group("logic", () {
      test("should execute tilemap logic", () {
        layer.logic();
        verify(tilemap.logic());
      });

      test("should execute logic of all objects", () {
        layer.logic();
        verify(object1.logic());
        verify(object2.logic());
      });
    });

    group("draw", (){
      test("should draw tilemap", () {
        Point2D position = new Point2D.zero();
        layer.draw(position);
        verify(tilemap.draw(position));
      });

      test("should draw all objects", () {
        Point2D position = new Point2D.zero();
        layer.draw(position);
        verify(object1.draw(position));
        verify(object2.draw(position));
      });

      test("should draw tilemap in the correct position", () {
        layer.scrollspeed = new Point2D(5,5);
        Point2D position = new Point2D(2,2);
        layer.draw(position);
        verify(tilemap.draw(layer.getRealPosition(position)));
      });

      test("should draw all objects in the correct position", () {
        layer.scrollspeed = new Point2D(5,5);
        Point2D position = new Point2D(2,2);
        layer.draw(position);
        verify(object1.draw(layer.getRealPosition(position)));
        verify(object2.draw(layer.getRealPosition(position)));
      });

    });
  });
}
