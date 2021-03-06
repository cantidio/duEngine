part of duengine;

class FollowerCamera extends Camera{
  List<GameObject> _targets;
  int margin = 20;
  bool autoZoom;

  FollowerCamera(Point2D bounds, {this.autoZoom: true, num zoomFactor: 1.0}) : super(bounds, zoomFactor: zoomFactor);
  
  void follow(List<GameObject> targets) {
    _targets = targets;
    _target = midPoint;
  }
  
  Point2D get midPoint {
//    if(_targets.length == 1) return _targets.single.position;
    Point2D sumPoint = new Point2D.zero();
    _targets.forEach((GameObject object){
      sumPoint += object.position;
    });
    return sumPoint/ new Point2D(_targets.length, _targets.length);
  }
  
  

  void update() {
    _target = midPoint;
    
    //use hull convex to calculate the farthest distance to drop O(n2)
    double greatestDistance = 0.0;    
    _targets.forEach((GameObject objectA) {
      _targets.forEach((GameObject objectB){
        if(objectA != objectB) {
          double xDist = (objectA.position.x.toDouble() - objectB.position.x.toDouble()).abs(); 
          double yDist = (objectA.position.y.toDouble() - objectB.position.y.toDouble()).abs();
          double distanceBetween = sqrt(pow(xDist,2) + pow(yDist, 2));
          if(greatestDistance < distanceBetween) greatestDistance = distanceBetween;
        }
      });
    });
    if(autoZoom) {
      this.zoomFactor = greatestDistance+2.0*margin < _bounds.x? 1.0:  _bounds.x/(greatestDistance+2.0*margin);
    }
  }
}
