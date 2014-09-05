part of duengine;

class TileMap {
  List<Tile> _tiles;
  List<List<int>> _map = new List();
  Point2D tileSize;

//  List<Map> _tileList;
  void setTiles(List<Tile> tiles){
    _tiles = tiles;
  }

//  TileMap.fromMatrix(List<List> tileMatrix, Point2D tileSize) {
//    _tileList = [];
//    for (int y = 0; y < tileMatrix.length; y++) {
//      for (int x = 0; x < tileMatrix[y].length; x++) {
//        _tileList.add({
//          "tile": tileMatrix[y][x],
//          "position": new Point2D(x * tileSize.x, y * tileSize.y)
//        });
//      }
//    }
//  }

  int get width {
    return _map[0].length;
  }

  int get height {
    return _map.length;
  }

  set width(int width) {
    if (width <= 0) throw new ArgumentError("TileMap width must be greater than 0.");
    int diff = width - _map[0].length;

    _map.forEach((List<int> line) {
      if (diff < 0) {
        line.removeRange(width, line.length);
      } else if (diff > 0) {
        line.addAll(new List.filled(diff, null));
      }
    });
  }

  set height(int height) {
    if (height <= 0) throw new ArgumentError("TileMap height must be greater than 0.");
    int diff = height - _map.length;

    if (diff > 0) {
      _map.addAll(new List.filled(diff, new List.filled(width, null)));
    } else if (diff < 0) {
      _map.removeRange(height, _map.length);
    }
  }

  TileMap(int width, int height, Point2D tileSize) {
    if (height <= 0) throw new ArgumentError("TileMap height must be greater than 0.");
    if (width <= 0) throw new ArgumentError("TileMap width must be greater than 0.");

    this.tileSize = tileSize;
    _map = new List.filled(height, new List.filled(width, null));
  }

  
  List<int> operator [](int i) {
    return _map[i];
  }
  
  void operator []=(int i, List<int> list){
    _map[i]= list;
  }


  void draw(Point2D position, {double scale: 1.0}) {
    
    
    print(position);
    position /= tileSize;
    int startx = position.x.floor();
    int starty = position.y.floor();
    if (startx < 0) startx=0;
    if (starty < 0) starty=0;


    for (int y = starty; y < height; ++y) {
      for (int x = startx; x < width; ++x) {
        if(_map[y][x] != null){
          Tile tile = _tiles[_map[y][x]];
          tile.draw((new Point2D(x, y) * tileSize) * new Point2D(scale, scale), scale: scale);
        }
      }
    }
  }

  void update() {
    _tiles.forEach((Tile tile) => tile.update());
  }
}
