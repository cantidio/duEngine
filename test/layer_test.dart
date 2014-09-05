library layer_test;

import "package:unittest/unittest.dart";
import 'package:mockito/mockito.dart';
import "package:duengine/duengine.dart";
import "package:gorgon/gorgon.dart";
import "helper.dart";

void main() {

  Layer layer;
  MockTileMap tilemap;
  MockGameObject object1, object2;

  group("Layer", () {
    setUp(() {
      tilemap = new MockTileMap();
      object1 = new MockGameObject();
      object2 = new MockGameObject();
      layer = new Layer(tilemap, [object1, object2]);
    });

    group("getRealPosition", () {
      test("should return the position relative to the layer scroll speed", () {
        layer.scrollspeed = new Point2D(0.5, 0.5);
        Point2D position = new Point2D(200, 200);

        expect(layer.getRealPosition(position), equals(new Point2D(100.0, 100.0)));
      });
    });

    group("update", () {
      test("should execute tilemap update", () {
        layer.update();
        verify(tilemap.update());
      });

      test("should execute update of all objects", () {
        layer.update();
        verify(object1.update());
        verify(object2.update());
      });
    });

    group("draw", () {
      test("should draw tilemap", () {
        Point2D position = new Point2D.zero();
        layer.draw(position);
        verify(tilemap.draw(position, scale: any));
      });

      test("should draw all objects", () {
        Point2D position = new Point2D.zero();
        layer.draw(position);
        verify(object1.draw(position, scale: any));
        verify(object2.draw(position, scale: any));
      });

      test("should draw tilemap in the correct position", () {
        layer.scrollspeed = new Point2D(5, 5);
        Point2D position = new Point2D(2, 2);
        layer.draw(position);
        verify(tilemap.draw(layer.getRealPosition(position), scale: any));
      });

      test("should draw all objects in the correct position", () {
        layer.scrollspeed = new Point2D(5, 5);
        Point2D position = new Point2D(2, 2);
        layer.draw(position);
        verify(object1.draw(layer.getRealPosition(position), scale: any));
        verify(object2.draw(layer.getRealPosition(position), scale: any));
      });
    });

    group("addObject", () {
      test("should increase objects size after adding a GameObject", () {
        int i = layer.objects.length;
        layer.addObject(new MockGameObject());
        expect(layer.objects.length, equals(i + 1));
      });

      test("should actually include the requested GameObject in the last position of the objects attribute", () {
        GameObject object = new MockGameObject();
        layer.addObject(object);
        expect(layer.objects.last, equals(object));
      });

      test("should register this layer in the inserted GameObject", () {
        GameObject object = mockGameObject;
        layer.addObject(object);
        expect(layer.objects.last.layer, equals(layer));
      });

      test("should unregister other layers from the GameObject", () {
        GameObject object = mockGameObject;
        layer.addObject(object);
        Layer layer2 = new Layer(new MockTileMap(), []);
        layer2.addObject(object);
        expect(object.layer, isNot(layer));
      });
    });

    group("removeObject", () {
      test("should decrease object size after removing a GameObject", () {
        int i = layer.objects.length;
        layer.removeObject(object2);
        expect(layer.objects.length, equals(i - 1));
      });

      test("should actually remove the requested GameObject from the objects attribute", () {
        GameObject object = mockGameObject;
        List<GameObject> objects = layer.objects;
        layer.addObject(object);
        layer.removeObject(object);
        expect(layer.objects.contains(object), equals(false));
      });

      test("should unregister this layer from the GameObject", () {
        GameObject object = mockGameObject;
        layer.addObject(object);
        layer.removeObject(object);
        expect(object.layer, isNull);
      });
    });

  });
}
