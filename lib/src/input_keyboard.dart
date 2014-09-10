part of duengine;
/**
 * Class That Represents a Simple [KeyboardInput].
 *
 * This class can be Extended to include more keys.
 */
class KeyboardInput extends InputBase {
  Keyboard _keyboard;
  Map<String, int> _keymap = {
    "Left": KeyCode.LEFT,
    "Up": KeyCode.UP,
    "Right": KeyCode.RIGHT,
    "Down": KeyCode.DOWN,
    "Button1": KeyCode.Z,
    "Button2": KeyCode.X,
    "Button3": KeyCode.C,
    "Button4": KeyCode.V,
  };

  /// Return all triggers available for this Input.
  List<String> get triggers => _keymap.keys.toList();

  /**
   * Creates a new KeyboardInput
   */
  KeyboardInput() {
    _keyboard = new Keyboard();
  }

  /**
   * Return true if the requested [trigger] is 'triggered', false otherwise.
   */
  bool check(String trigger) {
    return _keymap[trigger] != null && _keyboard[_keymap[trigger]];
  }
}
