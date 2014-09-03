part of duengine;

class TileMap {
  List<Map> _tileList;
  Tile a = null;

  TileMap.fromMatrix(List<List> tileMatrix, Point2D tileSize) {
    _tileList = [];
    for (int y = 0; y < tileMatrix.length; y++) {
      for (int x = 0; x < tileMatrix[y].length; x++) {
        _tileList.add({
          "tile": tileMatrix[y][x],
          "position": new Point2D(x * tileSize.x, y * tileSize.y)
        });
      }
    }
  }

  TileMap(List<Map> tileList) {
    _tileList = tileList;
  }

  void draw(Point2D position) {
    _tileList.forEach((Map positionalTile) {
      positionalTile["tile"].draw(position + positionalTile["position"]);
    });
  }

  void logic() {
    _tileList.forEach((Map positionalTile) {
      positionalTile["tile"].logic();
    });
  }
}
