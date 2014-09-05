part of duengine;

class FollowerCamera extends Camera{
  List<GameObject> _targets;

  FollowerCamera(Point2D bounds, {num zoomFactor: 1.0}) : super(bounds, zoomFactor: zoomFactor);
  
  void follow(List<GameObject> targets) {
    _targets = targets;
    _target = midPoint;
  }
  
  Point2D get midPoint {
    if(_targets.length == 1) return _targets.single.position;
    Point2D sumPoint = new Point2D.zero();
    _targets.forEach((GameObject object){
      sumPoint += object.position;
    });
    return sumPoint/ new Point2D(_targets.length, _targets.length);
  }

  void update() {
    _target = midPoint;
  }
}
