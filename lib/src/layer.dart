part of duengine;

class Layer {
  TileMap _tilemap;
  List<GameObject> _objects;
  Point2D scrollspeed;
  bool active;

  Layer(TileMap tilemap, List<GameObject> objects, {bool active: true, Point2D scrollspeed}) {
    _tilemap = tilemap;
    _objects = objects;
    this.scrollspeed = scrollspeed == null ? new Point2D(1, 1) : scrollspeed;
    this.active = active;
  }

  Point2D getRealPosition(Point2D position) {
    return position * scrollspeed;
  }

  void draw(Point2D position) {
    if (active) {
      Point2D pos = getRealPosition(position);

      _tilemap.draw(pos);
      _objects.forEach((GameObject object) {
        object.draw(pos);
      });
    }
  }

  void logic() {
    if (active) {
      _tilemap.logic();
      _objects.forEach((GameObject object) {
        object.logic();
      });
    }
  }

}
