part of duengine;

class StaticCamera extends Camera{
  List<GameObject> _targets;

  StaticCamera(Point2D bounds, {num zoomFactor: 1.0}) : super(bounds, zoomFactor: zoomFactor){
    update();
  }

  void update() {
    _target = _bounds / new Point2D(2, 2);
  }
}
