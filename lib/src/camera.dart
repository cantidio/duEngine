part of duengine;

class Camera {
  GameObject _object_target;
  Point2D _bounds;
  Point2D _target;

  Camera(this._bounds) {

  }

  void follow(GameObject target) {
    _object_target = target;
    _target =_object_target.position;
  }

  void update() {
    _target = _object_target.position;
  }

  Point2D get position {
    return _target - _bounds / new Point2D(2.0, 2.0);
  }

  num get zoomFactor {
    return 1.0;
  }

  Point2D get drawPosition {
    Point2D zoom = new Point2D(zoomFactor, zoomFactor);
    return new Point2D(-1,-1)*(_target - _bounds / new Point2D(2.0, 2.0) / zoom);
  }
}
