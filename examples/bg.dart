import 'package:duengine/duengine.dart';
import 'package:gorgon/gorgon.dart';

void fillRow(List<int> row, value) {
  for (int i = 0; i < row.length; ++i) {
    row[i] = value;
  }
}

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


  TileMap map = new TileMap(20, 20, new Point2D(16, 16));
  map.tiles.addAll(tiles);
  fillRow(map[0], 1);
  fillRow(map[1], 1);
  fillRow(map[2], 1);
  fillRow(map[3], 1);
  fillRow(map[4], 1);
  fillRow(map[5], 1);
  for (int i = 6; i < 20; ++i) {
    fillRow(map[i], 2);
  }
  Layer l0 = new Layer(map, []);

//  l1.scrollspeed.x = 0.2;
  return new Background(layers: [l0]);
}
