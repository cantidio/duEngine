part of duengine;
class Background {
  List<Layer> _layers = new List<Layer>();
  int _width;
  int _height;
  Point2D position;


  /**
   * Returns a read-only [List] of [Layer] contained in the background
   */
  List<Layer> get layers => _layers.toList(); // read only list

  Background({List<Layer> layers, Point2D position}) {
    this.position = position != null ? position : new Point2D.zero();
    layers.forEach((Layer layer) => addLayer(layer));
  }

  void removeLayer(Layer layer) {
    _layers.remove(layer);
    layer._background = null;
  }

  /**
   * Adds a [Layer] to a list of layers.
   */
  void addLayer(Layer layer) {
    if (layer.background != null) layer.background.removeLayer(layer);
    _layers.add(layer);
    layer._background = this;
  }

  //  Future loadFromMap(Map map){
  //
  //  }
  //
  //  Background.fromJSON(String uri){
  //
  //  }

  void drawFromCamera(Camera camera){
    draw(camera.drawPosition, scale: camera.zoomFactor);
  }
  void draw(Point2D position, {double scale: 1.0}) {
    _layers.forEach((Layer layer) {
      layer.draw(position, scale: scale);
    });
  }

  void logic() {
    _layers.forEach((Layer layer) {
      layer.logic();
    });
  }

}
