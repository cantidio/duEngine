part of duengine;

class Interpolator {
  static final Map LINEAR = {
       "point":(Point2D before, Point2D after, int numPoints, int currentPoint) {
         Point2D difference = before - after;
         return before-(difference/(new Point2D(numPoints, numPoints)))*(new Point2D(currentPoint, currentPoint));
       },
       "number": (double before, double after, int numPoints, int currentPoint) {
         double difference = before - after;
         return before-(difference/numPoints.toDouble())*currentPoint.toDouble();
       }
  };
}