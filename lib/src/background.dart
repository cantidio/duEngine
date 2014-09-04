part of duengine;
class Background {
  List<Layer> _layers;
  Point2D position;
  int _width;
  int _height;

  /**
   * Returns a read-only [List] of [Layer] contained in the background
   */
  List<Layer> get layers => _layers.toList(); // read only list

  Background(List<Layer> layers, {Point2D position}) {
    this.position = position != null ? position : new Point2D.zero();
    _layers = layers;
  }

//  Future loadFromMap(Map map){
//
//  }
//
//  Background.fromJSON(String uri){
//
//  }

  void draw() {
    _layers.forEach((Layer layer) {
      layer.draw(position);
    });
  }

  void logic() {
    _layers.forEach((Layer layer) {
      layer.logic();
    });
  }


  /**
   * Adds a [Layer] to a list of layers. Throws [ArgumentError] if null is used as argument
   */
  void addLayer(Layer layer){
    if(layer == null) throw new ArgumentError("Background cannot add a null layer");
    _layers.add(layer);
  }

}
