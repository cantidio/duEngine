part of duengine;

/**
 * Class that represents a [Tile].
 */
class Tile {
  List<Sprite> _sprites;
  int _delay;
  int _frameOn;
  int _timeOn;

  int get timeOn => _timeOn;
  int get frameOn => _frameOn;
  List<Sprite> get sprites => _sprites;

  /**
   * Constructs tile from [Sprite] list.
   */
  Tile(List<Sprite> spriteList, {int delay: 1}) {
    _sprites = spriteList;
    _delay = delay;
    _frameOn = 0;
    _timeOn = 0;
  }

  /**
   * Draws the [Tile] in the requested [position].
   */
  void draw(Point2D position, {double alpha: 1.0, Mirroring mirroring: Mirroring.None, num rotation: 0, double scale: 1.0}) {
    _sprites[_frameOn].draw(position, alpha: alpha, mirroring: mirroring, rotation: rotation, scale: scale);
  }

  /**
   * Updates [Tile] animation if there is one.
   */
  void update() {
    if (++_timeOn > _delay) //change frame
    {
      _timeOn = 0;
      if (++_frameOn >= _sprites.length) //reset
      {
        _frameOn = 0;
      }
    }
  }

}
