part of duengine;

class TransitionCameraBuilder {
  
//  static Function linearInterpolator = (Point2D before, Point2D after, int numPoints, int currentPoint) {
//    Point2D difference = before - after;
//    return (difference/(new Point2D(numPoints, numPoints)))*(new Point2D(currentPoint, currentPoint));
//  };
  
  Point2D _before = null;
  Point2D _after = null;
  int _numPoints = 0;
  Function _interpolator = Interpolator.LINEAR["point"];

  num _initialZoom = 1;
  num _finalZoom = 1;
  Function _zoomInterpolator = Interpolator.LINEAR["number"];

  TransitionCameraBuilder.from(Point2D before, {initialZoom: 1}) {
    this._before = before;
    this._initialZoom = initialZoom;
    this._zoomInterpolator = _interpolator;
  }
  
  TransitionCameraBuilder to(Point2D after, {finalZoom: 1}) {
    this._after = after;
    this._finalZoom = finalZoom;
    return this;
  }
  
  TransitionCameraBuilder during(int numPoints) {
    this._numPoints = numPoints;
    return this;
  }
  
  TransitionCameraBuilder withInterpolator(Function interpolator, {Function zoomInterpolator: null}) {
    this._interpolator = interpolator;
    this._zoomInterpolator = zoomInterpolator != null? zoomInterpolator: _interpolator;
    return this;
  }
  
  TransitionCamera build() {
    if(_numPoints <= 0) throw new ArgumentError("use during() to specify the duration of the transition");
    if(_after == null) throw new ArgumentError("use to() to specify the final point of the transition.");
    TransitionCamera camera = new TransitionCamera(new Point2D(Display.target.height, Display.target.width), zoomFactor: _initialZoom);
    camera._target = _before;
    camera.after = _after;
    camera.before = _before;
    camera.numPoints = _numPoints;
    camera.interpolator = _interpolator;
    camera.zoomInterpolator = _zoomInterpolator;
    camera.initialZoom = _initialZoom;
    camera.finalZoom = _finalZoom;
    return camera;
  }
}
