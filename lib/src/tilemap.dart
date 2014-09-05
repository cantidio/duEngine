part of duengine;

class TileMap {
  List<Tile> _tiles;
  List<List<int>> _map = new List();
  Point2D tileSize;

  //  List<Map> _tileList;
  void setTiles(List<Tile> tiles) {
    _tiles = tiles;
  }

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

  void operator []=(int i, List<int> list) {
    _map[i] = list;
  }

  /**
   * Heavy black magic
   */
  void draw(Point2D position, {double scale: 1.0}) {
    int startx = (position.x > -tileSize.x) ? 0 : (-(position.x * scale) / (tileSize.x * scale)).floor() - 1;
    int starty = (position.y > -tileSize.y) ? 0 : (-(position.y * scale) / (tileSize.y * scale)).floor() - 1;
    int endx = startx + (Display.target.width / (tileSize.x * scale)).ceil()+1;
    int endy = starty + (Display.target.height / (tileSize.y * scale)).ceil()+1;
    if (endx > width) endx = width;
    if (endy > height) endy = height;

    double tiley = 0.0;
    position += new Point2D(startx * tileSize.x, starty * tileSize.y);
    for (int y = starty; y < endy; ++y) {
      double tilex = 0.0;
      bool already = false;
      for (int x = startx; x < endx; ++x) {
        if (_map[y][x] != null) {
          Tile tile = _tiles[_map[y][x]];
          if (tile != null) {
            tile.draw((position + new Point2D(tilex, tiley)) * new Point2D(scale, scale), scale: scale);
          }
        }
        tilex += tileSize.x;
      }
      tiley += tileSize.y;
    }
  }

  void update() {
    _tiles.forEach((Tile tile) => tile.update());
  }
}
