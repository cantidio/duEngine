part of duengine;

class GameObject {
  Animator _animator;
  Point2D position;
  Mirroring mirroring;
  bool active;
  int alpha;
  num rotation;
  num scale;

  Animator get animator => _animator;

  GameObject(Spritepack spritepack, Animationpack animationpack, Point2D position, { bool active: true, int alpha: 255 ,Mirroring mirroring: Mirroring.None, num rotation: 0, num scale: 1 })
  {
    _animator  = new Animator(spritepack, animationpack);
    this.position  = position;
    this.alpha     = alpha;
    this.rotation  = rotation;
    this.scale     = scale;
    this.mirroring = mirroring;
    this.active    = active;
  }

  void draw(Point2D position, { int alpha: 255 ,Mirroring mirroring: Mirroring.None, num rotation: 0, num scale: 1 })
  {
    if(active)
    {
      animator.draw(
        this.position + position,
        alpha:     this.alpha - (255 - alpha),
        mirroring: this.mirroring ^ mirroring,
        rotation:  this.rotation + rotation,
        scale:     this.scale * scale
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