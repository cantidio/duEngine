part of duengine;
/**
 * Class that represents a basic [GameObject].
 */
class GameObject {
  /// The [Animator] of the [GameObject].
  Animator animator;
  /// The current position of this [GameObject].
  Point2D position;
  /// The current [Mirroring] of this [GameObject].
  Mirroring mirroring;
  /// The current rotation of the [GameObject]. 0.0 is the default.
  num rotation;
  /// The current alpha level of the [GameObject]. 1.0 is the default.
  double alpha;
  /// The current scale of the [GameObject]. 1.0 is the default.
  double scale;
  /// If this is false then the [GameObject] is ignored.
  bool active;

  /// Reference to the [Layer] of this [GameObject] if any.
  Layer _layer;

  /// Getter for the layer of the [GameObject].
  Layer get layer => _layer;

  /**
   * Creates a [GameObject].
   *
   * It will create a [Animator] for it using the [spritepack] and [animationpack] provided and set it's initial [position].
   * You can set following options as well:
   *  [active], if the [GameObject] is active then it will behave normally if not, it will be ignored complety.
   *  [alpha], [mirroring], [rotation], [scale] these will be applied and cascaded while drawing.
   */
  GameObject(Spritepack spritepack, Animationpack animationpack, Point2D position, {bool active: true, double alpha: 1.0, Mirroring mirroring: Mirroring.None, num rotation: 0, double scale: 1.0}) {
    this.animator = new Animator(spritepack, animationpack);
    this.position = position;
    this.alpha = alpha;
    this.rotation = rotation;
    this.scale = scale;
    this.mirroring = mirroring;
    this.active = active;
  }
  /**
   * Draws the [GameObject] in the given [position] using the target [Display].
   *
   * Note that the [position] is relative to the internal [GameObject] position.
   * You can set the following options as well: [alpha], [mirroring], [rotation] and [scale].
   * These will be aplied along the internal ones.
   */
  void draw(Point2D position, {double alpha: 1.0, Mirroring mirroring: Mirroring.None, num rotation: 0, double scale: 1.0}) {
    if (active) {
      animator.draw((this.position + position)* new Point2D(scale,scale), alpha: this.alpha * alpha, mirroring: this.mirroring ^ mirroring, rotation: this.rotation + rotation, scale: this.scale * scale);
    }
  }
  /**
   * Method that runs the [GameObject] logic. It should be called each game cycle.
   */
  void update() {
    if (active) {
      animator.runStep();
    }
  }

}
