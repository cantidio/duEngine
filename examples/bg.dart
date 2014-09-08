import 'package:duengine/duengine.dart';
import 'package:gorgon/gorgon.dart';

void fillRow(List<int> row, value) {
  for (int i = 0; i < row.length; ++i) {
    row[i] = value;
  }
}

Layer getLayer0(List<Tile> tiles){
  TileMap map = new TileMap(40,30, new Point2D(8,8));
  map.tiles = tiles;
  for(int i =0; i< map.height; ++i){
    for(int j=0; j< map.width; ++j){
      map[i][j]=0;
    }
  }
  Layer layer = new Layer(map, []);
  layer.scrollspeed.x=0.0;
  layer.scrollspeed.y=0.0;
  return layer;
}
Layer getLayer1(List<Tile> tiles){
  TileMap map = new TileMap(80,30, new Point2D(8,8));
  map.tiles = tiles;
  map[29][0]=1;
  for(int i =0; i < 21; ++i) map[29][i]=2;
  map[28][21]=4;
  map[27][22]=4;
  map[26][23]=4;
  map[25][24]=4;
  map[24][25]=4;
  for(int i =26; i < 80; ++i) map[24][i]=2;

  return new Layer(map, []);
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



//  Layer l0 = getLayer0(tiles);

//  l1.scrollspeed.x = 0.2;
  return new Background(layers: [getLayer0(tiles),getLayer1(tiles)]);
}
