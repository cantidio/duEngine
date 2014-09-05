part of duengine;

class SimpleCamera extends Camera{
  GameObject _object_target;

  SimpleCamera(Point2D bounds, {num zoomFactor: 1.0}) : super(bounds, zoomFactor: zoomFactor);
  
  void follow(GameObject target) {
    _object_target = target;
    _target =_object_target.position;
  }

  void update() {
    _target = _object_target.position;
  }
}
