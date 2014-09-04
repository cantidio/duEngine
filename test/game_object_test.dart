library game_object_test;

import "package:unittest/unittest.dart";
import "package:duengine/duengine.dart";
import "package:gorgon/gorgon.dart";

void main()
{
  GameObject object;
  Spritepack spritepack;
  Animationpack animationpack;
  Point2D position = new Point2D.zero();

  setUp((){
    object = new GameObject(spritepack,animationpack,position);
    print("setup.");
  });

  group("constructor",(){
    test( "it should create an Animator with the provided spritepack and animationpack.", (){
      expect(object.animator, isNotNull);
    });

  });

  group("logic",(){
    setUp((){

    });
    test("when the object is active it should update the animator.",(){});
    test("when the object is not active it should not update the animator.",(){});
  });
}
