library background_test;

import "package:unittest/unittest.dart";
import 'package:mockito/mockito.dart';
import "package:duengine/duengine.dart";
import "package:gorgon/gorgon.dart";

class MockLayer extends Mock implements Layer {}

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
      test("should execut all layers logic", (){
        background.logic();
        verify(layer1.logic());
        verify(layer2.logic());
      });
    });

  });

}
