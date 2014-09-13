import 'package:mockito/mockito.dart';
import "package:duengine/duengine.dart";
import "package:gorgon/gorgon.dart";

// GORGON MOCKS
class MockAnimator extends Mock implements Animator {}
class MockSprite extends Mock implements Sprite {}
class MockSpritepack extends Mock implements Spritepack {}
class MockAnimationpack extends Mock implements Animationpack {}

// DUENGINE MOCKS
class MockTile extends Mock implements Tile {}
class MockTileMap extends Mock implements TileMap {}
class MockLayer extends Mock implements Layer {}
class MockGameObject extends Mock implements GameObject {}

GameObject get mockGameObject => new GameObject(new Spritepack(), new Animationpack(), new Point2D.zero());

/**
 * Fake Input Class.
 * You just enter the inputs this input should receive and
 * every time someone checks for a input the desired input will be checked.
 */
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