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