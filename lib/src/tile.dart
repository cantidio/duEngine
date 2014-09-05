part of duengine;

class Tile {
  List<Sprite> _spriteList;
  int _delay;
  int _frameOn;
  int _timeOn;

  int get timeOn => _timeOn;
  int get frameOn => _frameOn;

  /**
   * Constructs tile from [Sprite] list.
   */
  Tile(List<Sprite> spriteList, {int delay: 1}) {
    _spriteList = spriteList;
    _delay = delay;
    _frameOn = 0;
    _timeOn = 0;
  }

  void draw(Point2D position, {double alpha: 1.0, Mirroring mirroring: Mirroring.None, num rotation: 0, double scale: 1.0}) {
    _spriteList[_frameOn].draw(position, alpha: alpha, mirroring: mirroring, rotation: rotation, scale: scale);
  }

  void update() {
    _timeOn++;
    if (++_timeOn >= _delay) //change frame
    {
      _timeOn = 0;
      if (++_frameOn >= _spriteList.length) //reset
      {
        _frameOn = 0;
      }
    }
  }

}
