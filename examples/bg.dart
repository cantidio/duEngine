import 'package:duengine/duengine.dart';
import 'package:gorgon/gorgon.dart';

Background getBG(Spritepack sp) {

  List<Tile> tiles = [];
  sp.groups.forEach((String group) {
    sp[group].forEach((Sprite s) {
      tiles.add(new Tile([s]));
    });
  });

//  Layer l0 = new Layer(new TileMap.fromMatrix(new List.filled(15, new List.filled(15, tiles[2])), new Point2D(16, 16)), []);
//  Layer l1 = new Layer(new TileMap.fromMatrix([[], [], [], [], [], [], [], [], new List.filled(20, tiles[17]), new List.filled(20, tiles[19])], new Point2D(16, 16)), []);
//  Layer l2 = new Layer(new TileMap.fromMatrix([[], [], [], [], [], [], [], [], [], [], new List.filled(40, tiles[5]), new List.filled(40, tiles[27])], new Point2D(16, 16)), []);


  TileMap map = new TileMap(20,20, new Point2D(16,16));
  map.setTiles(tiles);

  map[0]=new List.filled(20,1);
  map[1]=new List.filled(20,1);
  map[2]=new List.filled(20,1);
  map[3]=new List.filled(20,1);
  map[4]=new List.filled(20,1);
  map[5]=new List.filled(20,1);
  map[6]=new List.filled(20,2);
  map[7]=new List.filled(20,2);
  map[8]=new List.filled(20,2);
  map[9]=new List.filled(20,2);
  map[10]=new List.filled(20,2);
  map[11]=new List.filled(20,2);
  map[12]=new List.filled(20,2);
  map[13]=new List.filled(20,2);
  map[14]=new List.filled(20,2);
  map[15]=new List.filled(20,2);
  map[16]=new List.filled(20,2);
  map[17]=new List.filled(20,2);
  map[18]=new List.filled(20,2);
  map[19]=new List.filled(20,2);
  Layer l0 = new Layer(map, []);

//  l1.scrollspeed.x = 0.2;
//  return new Background(layers: [l0, l1, l2]);
  return new Background(layers: [l0]);
}
