part of duengine;

class Object {
  Animator _animator;
  Point2D _position;
  bool active;

  Animator get animator => _animator;

  Object(Spritepack spritepack, Animationpack animationpack){
    _animator = new Animator(spritepack, animationpack);
    active = true;
    _position = new Point2D.zero();
  }

  void draw(Point2D position, { alpha: 255 ,Mirroring mirroring: Mirroring.None, num rotation: 0, num scale: 1})
  {
    if(active)
    {
      animator.draw(
          _position + position,
          alpha:     alpha,
          mirroring: mirroring,
          rotation:  rotation,
          scale:     scale
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