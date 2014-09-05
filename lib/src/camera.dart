part of duengine;

abstract class Camera {
  GameObject _object_target;
  Point2D _bounds;
  Point2D _target;
  num zoomFactor;

  Camera(this._bounds, {num zoomFactor: 1.0}) {
    this.zoomFactor = zoomFactor;
  }

  void update();

  Point2D get position {
    return _target - _bounds / new Point2D(2.0, 2.0);
  }

  Point2D get drawPosition {
    Point2D zoom = new Point2D(zoomFactor, zoomFactor);
    return new Point2D(-1,-1)*(_target - _bounds / new Point2D(2.0, 2.0) / zoom);
  }
}
