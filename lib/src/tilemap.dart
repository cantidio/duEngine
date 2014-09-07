part of duengine;

class TileMap {
  List<Tile> tiles = new List();
  List<List<int>> _map = new List();
  Point2D tileSize;

  //  List<Map> _tileList;
//  void setTiles(List<Tile> tiles) {
//    _tiles = tiles;
//  }

  /// Return the width of the [TileMap].
  int get width => _map[0].length;

  /// Return the height of the [TileMap].
  int get height => _map.length;

  TileMap(int width, int height, Point2D tileSize) {
    resize(width, height);
    this.tileSize = tileSize;
  }

  /**
   * Method that resizes the [TileMap] by the [width] and [height] provided.
   *
   * ** If the requested width or height are lower than the actual, the spare tiles will be discarded.
   */
  void resize(int width, int height) {
    if (width <= 0) throw new ArgumentError("TileMap width must be greater than 0.");
    if (height <= 0) throw new ArgumentError("TileMap height must be greater than 0.");

    List old_map = _map;
    int old_height = (old_map != null) ? old_map.length : 0;
    int old_width = (old_height > 0) ? old_map[0].length : 0;

    _map = new List(height);
    for (int y = 0; y < height; ++y) {
      _map[y] = new List<int>(width);
      if (y < old_height) {
        for (int x = 0; x < width && x < old_width; ++x) {
          _map[y][x] = old_map[y][x];
        }
      }
    }
  }

  List<int> operator [](int i) {
    return _map[i];
  }

  //TODO remove this
//  void operator []=(int i, List<int> list) {
//    print("aqui");
//    _map[i] = list;
//  }

  /**
   * Method that draws the visible [Tiles] in the [TileMap] in the correct [position].
   */
  void draw(Point2D position, {double scale: 1.0}) {
    int startx = (position.x > -tileSize.x) ? 0 : (-(position.x * scale) / (tileSize.x * scale)).floor() - 1;
    int starty = (position.y > -tileSize.y) ? 0 : (-(position.y * scale) / (tileSize.y * scale)).floor() - 1;
    int endx = startx + (Display.target.width / (tileSize.x * scale)).ceil() + 1;
    int endy = starty + (Display.target.height / (tileSize.y * scale)).ceil() + 1;
    if (endx > width) endx = width;
    if (endy > height) endy = height;

    Point2D tilepos = new Point2D.zero();
    position += new Point2D(startx * tileSize.x, starty * tileSize.y);
    for (int y = starty; y < endy; ++y) {
      tilepos.x = 0.0;
      for (int x = startx; x < endx; ++x) {
        if (_map[y][x] != null) {
          Tile tile = tiles[_map[y][x]];
          if (tile != null) {
            tile.draw((position + tilepos) * new Point2D(scale, scale), scale: scale);
          }
        }
        tilepos.x += tileSize.x;
      }
      tilepos.y += tileSize.y;
    }
  }

  void update() {
    tiles.forEach((Tile tile) => tile.update());
  }
}
