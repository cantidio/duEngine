part of duengine;

class TransitionCamera extends Camera{
  Point2D before = null;
  Point2D after = null;
  int numPoints = 0;
  int _currentPoint = 1;
  Function interpolator = null;

  num initialZoom = 1.0;
  num finalZoom = 1.0;
  Function zoomInterpolator;
  TransitionCamera(Point2D bounds, {num zoomFactor: 1.0}) : super(bounds, zoomFactor: zoomFactor);
  
  void update() {
    if(_currentPoint != numPoints){
        _target =   Interpolator.LINEAR["point"](before, after, numPoints, _currentPoint);
        zoomFactor = Interpolator.LINEAR["number"](initialZoom, finalZoom, numPoints, _currentPoint++);
    }
  }
  
  Point2D linearPointInterpolator(Point2D before, Point2D after, int numPoints, int currentPoint) {
    Point2D difference = before - after;
    return before-(difference/(new Point2D(numPoints, numPoints)))*(new Point2D(currentPoint, currentPoint));
  }
  
  double linearInterpolator(double before, double after, int numPoints, int currentPoint) {
    double difference = before - after;
    return before-(difference/numPoints.toDouble())*currentPoint.toDouble();
  }
}
