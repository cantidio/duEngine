library tile_test;

import "package:unittest/unittest.dart";
import "package:duengine/duengine.dart";

void main()
{
  Tile tile;
  setUp((){
    tile = new Tile([]);
    print("setup.");
  });
  group("constructor",(){
    test( "members should match the provided values.", (){
      expect(1, equals(1));
    });
    test("timeOn should be 0.",(){
      expect(tile.timeOn, equals(0));
    });
    test("frameOn should be 0.",(){
      expect(tile.frameOn, equals(0));
    });
  });

  group("logic",(){
    test("it should add +1 in the timeOn.",(){});
    test("it should add +1 in the frameOn when the timeOn reaches the delay value.",(){});
    test("it should set the timeOn to 0 when the timeOn reaches the delay value.",(){});
    test("it should set the frameOn to 0 when the frameOn reaches the spritelist length.",(){});
  });
}
