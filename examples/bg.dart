import 'package:duengine/duengine.dart';
import 'package:gorgon/gorgon.dart';

Background getBG(Spritepack sp) {

  List<Tile> tiles = [];
  sp.groups.forEach((String group) {
    sp[group].forEach((Sprite s) {
      tiles.add(new Tile([s]));
    });
  });

  Layer l0 = new Layer(new TileMap.fromMatrix(new List.filled(15, new List.filled(15, tiles[2])), new Point2D(16, 16)), []);
  Layer l1 = new Layer(new TileMap.fromMatrix([[], [], [], [], [], [], [], [], new List.filled(20, tiles[17]), new List.filled(20, tiles[19])], new Point2D(16, 16)), []);
  Layer l2 = new Layer(new TileMap.fromMatrix([[], [], [], [], [], [], [], [], [], [], new List.filled(40, tiles[5]), new List.filled(40, tiles[27])], new Point2D(16, 16)), []);
  l0.scrollspeed.x = 0.2;
  l1.scrollspeed.x = 0.5;
  return new Background(layers: [l0, l1, l2]);
}
