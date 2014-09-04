library background_test;

import "package:unittest/unittest.dart";
import 'package:mockito/mockito.dart';
import "package:duengine/duengine.dart";
import "package:gorgon/gorgon.dart";
import "helper.dart";

void main() {
  MockLayer layer1;
  MockLayer layer2;
  Background background;

  group("Background", () {
    setUp(() {
      layer1 = new MockLayer();
      layer2 = new MockLayer();
      background = new Background([layer1, layer2]);
    });

    group("draw", () {
      test("should draw all layers", () {
        background.draw();
        verify(layer1.draw(any));
        verify(layer2.draw(any));
      });
    });

    group("logic", () {
      test("should execut all layers logic", () {
        background.logic();
        verify(layer1.logic());
        verify(layer2.logic());
      });
    });

    group("addLayer", () {
      test("should increase layers size after adding a layer", () {
        int i = background.layers.length;
        background.addLayer(new MockLayer());
        expect(background.layers.length, equals(i + 1));
      });

      test("should actually include the requested layer in the last position of the layers attribute", () {
        Layer layer = new MockLayer();
        background.addLayer(layer);
        expect(background.layers.last, equals(layer));
      });

      test("should register this background in the inserted Layer", () {
        Layer layer = new Layer(new MockTileMap(), []);
        background.addLayer(layer);
        expect(background.layers.last.background, equals(background));
      });

      test("should unregister other backgrounds from the Layer", () {
        Layer layer = new Layer(new MockTileMap(), []);
        background.addLayer(layer);
        Background background2 = new Background([]);
        background2.addLayer(layer);
        expect(layer.background, isNot(background));
      });
    });

    group("removeLayer", () {
      test("should decrease layers size after removing a layer", () {
        int i = background.layers.length;
        background.removeLayer(layer2);
        expect(background.layers.length, equals(i - 1));
      });

      test("should actually remove the requested layer from the layers attribute", () {
        Layer layer = new MockLayer();
        List<Layer> layers = background.layers;
        background.addLayer(layer);
        background.removeLayer(layer);
        expect(background.layers.contains(layer), equals(false));
      });

      test("should unregister this background from the Layer", () {
        Layer layer = new Layer(new MockTileMap(), []);
        background.addLayer(layer);
        background.removeLayer(layer);
        expect(layer.background, isNull);
      });
    });

  });

}
