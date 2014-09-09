import 'package:duengine/duengine.dart';
import 'package:gorgon/gorgon.dart';

void fillRow(List<int> row, value) {
  for (int i = 0; i < row.length; ++i) {
    row[i] = value;
  }
}

Layer getLayer0(List<Tile> tiles) {
  TileMap map = new TileMap(1, 1, new Point2D(8, 8));
  map.tiles = tiles;
  map.repeatX = true;
  map.repeatY = true;
  map[0][0] = 0;

  return new Layer(map, []);
}

Layer getLayer1(List<Tile> tiles) {
  TileMap map = new TileMap(80, 30, new Point2D(8, 8));
  map.tiles = tiles;
  map[24][0] = 5;
  map[25][1] = 5;
  map[26][2] = 5;
  map[27][3] = 5;
  map[28][4] = 5;

  for (int i = 5; i < 21; ++i) map[29][i] = 2;
  map[28][21] = 4;
  map[27][22] = 4;
  map[26][23] = 4;
  map[25][24] = 4;
  map[24][25] = 4;
  for (int i = 26; i < 80; ++i) map[24][i] = 2;
  map.repeatX = true;
  return new Layer(map, []);
}

Background getBG(Spritepack sp) {

  List<Tile> tiles = [];
  sp.groups.forEach((String group) {
    sp[group].forEach((Sprite s) {
      tiles.add(new Tile([s]));
    });
  });


  return new Background(layers: [getLayer0(tiles), getLayer1(tiles)]);
}
