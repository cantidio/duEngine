part of duengine;

class Object {
  Animator _animator;
  Point2D _position;
  Mirroring _mirroring;
  bool active;
  int _alpha;
  num _rotation;
  num _scale;

  Animator get animator => _animator;

  Object(Spritepack spritepack, Animationpack animationpack)
  {
    _animator  = new Animator(spritepack, animationpack);
    _position  = new Point2D.zero();
    _alpha     = 255;
    _rotation  = 0;
    _scale     = 1;
    _mirroring = Mirroring.None;
    active     = true;
  }

  void draw(Point2D position, { int alpha: 255 ,Mirroring mirroring: Mirroring.None, num rotation: 0, num scale: 1 })
  {
    if(active)
    {
      animator.draw(
        _position + position,
        alpha:     _alpha - (255 - alpha),
        mirroring: _mirroring ^ mirroring,
        rotation:  _rotation + rotation,
        scale:     _scale * scale
      );
    }
  }

  void logic()
  {
    if(active)
    {
      animator.runStep();
    }
  }

}