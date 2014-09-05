part of duengine;

class Layer {
  TileMap _tilemap;
  Background _background;
  List<GameObject> _objects = new List<GameObject>();
  Point2D scrollspeed;
  bool active;

  Background get background => _background;
  List<GameObject> get objects => _objects.toList(growable: false);//;

  Layer(TileMap tilemap, List<GameObject> objects, {bool active: true, Point2D scrollspeed}) {
    _tilemap = tilemap;
    this.scrollspeed = scrollspeed == null ? new Point2D(1, 1) : scrollspeed;
    this.active = active;
    objects.forEach((GameObject object) => addObject(object));
  }

  void removeObject(GameObject object) {
    _objects.remove(object);
    object._layer = null;
  }

  void addObject(GameObject object) {
    if (object.layer != null) object.layer.removeObject(object);
    _objects.add(object);
    object._layer = this;
  }

  Point2D getRealPosition(Point2D position) {
    return position * scrollspeed;
  }

  void draw(Point2D position, {double scale: 1.0}) {
    if (active) {
      Point2D pos = getRealPosition(position);
      _tilemap.draw(pos, scale: scale);

      _objects.forEach((GameObject object) {
        object.draw(pos, scale: scale);
      });
    }
  }

  void update() {
    if (active) {
      _tilemap.update();
      _objects.forEach((GameObject object) {
        object.update();
      });
    }
  }

}
