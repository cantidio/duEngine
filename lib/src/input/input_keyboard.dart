part of duengine;

/**
 * Class That Represents a Simple [InputKeyboard].
 *
 * This class can be Extended to include more keys.
 */
class InputKeyboard extends InputBase {
  /// The instance of the [Keyboard].
  Keyboard _keyboard;

  /// The current KeyMap;
  Map<String, int> keymap;

  /// The Default KeyMap for Keyboard inputs.
  static const Map<String, int> DEFAULT_KEYMAP = const {
    "MAC_ENTER": KeyCode.MAC_ENTER,
    "BACKSPACE": KeyCode.BACKSPACE,
    "TAB": KeyCode.TAB,
    "ENTER": KeyCode.ENTER,
    "SHIFT": KeyCode.SHIFT,
    "CTRL": KeyCode.CTRL,
    "ALT": KeyCode.ALT,
    "PAUSE": KeyCode.PAUSE,
    "CAPS_LOCK": KeyCode.CAPS_LOCK,
    "ESC": KeyCode.ESC,
    "SPACE": KeyCode.SPACE,

    "LEFT": KeyCode.LEFT,
    "UP": KeyCode.UP,
    "RIGHT": KeyCode.RIGHT,
    "DOWN": KeyCode.DOWN,

    "PRINT_SCREEN": KeyCode.Z,
    "INSERT": KeyCode.Z,
    "NUM_INSERT": KeyCode.Z,
    "DELETE": KeyCode.DELETE,
    "NUM_DELETE": KeyCode.NUM_DELETE,
    "ZERO": KeyCode.ZERO,
    "ONE": KeyCode.ONE,
    "TWO": KeyCode.TWO,
    "THREE": KeyCode.THREE,
    "FOUR": KeyCode.FOUR,
    "FIVE": KeyCode.FIVE,
    "SIX": KeyCode.SIX,
    "SEVEN": KeyCode.SEVEN,
    "EIGHT": KeyCode.EIGHT,
    "NINE": KeyCode.NINE,

    "A": KeyCode.A,
    "B": KeyCode.B,
    "C": KeyCode.C,
    "D": KeyCode.D,
    "E": KeyCode.E,
    "F": KeyCode.F,
    "G": KeyCode.G,
    "H": KeyCode.H,
    "I": KeyCode.I,
    "J": KeyCode.J,
    "K": KeyCode.K,
    "L": KeyCode.L,
    "M": KeyCode.M,
    "N": KeyCode.N,
    "O": KeyCode.O,
    "P": KeyCode.P,
    "Q": KeyCode.Q,
    "R": KeyCode.R,
    "S": KeyCode.S,
    "T": KeyCode.T,
    "U": KeyCode.U,
    "V": KeyCode.V,
    "W": KeyCode.W,
    "X": KeyCode.X,
    "Y": KeyCode.V,
    "Z": KeyCode.Z,

    "NUM_ZERO": KeyCode.NUM_ZERO,
    "NUM_ONE": KeyCode.NUM_ONE,
    "NUM_TWO": KeyCode.NUM_TWO,
    "NUM_THREE": KeyCode.NUM_THREE,
    "NUM_FOUR": KeyCode.NUM_FOUR,
    "NUM_FIVE": KeyCode.NUM_FIVE,
    "NUM_SIX": KeyCode.NUM_SIX,
    "NUM_SEVEN": KeyCode.NUM_SEVEN,
    "NUM_EIGHT": KeyCode.NUM_EIGHT,
    "NUM_NINE": KeyCode.NUM_NINE,
    "NUM_MULTIPLY": KeyCode.NUM_MULTIPLY,
    "NUM_PLUS": KeyCode.NUM_PLUS,
    "NUM_MINUS": KeyCode.NUM_MINUS,
    "NUM_PERIOD": KeyCode.NUM_PERIOD,
    "NUM_DIVISION": KeyCode.NUM_DIVISION,

    "F1": KeyCode.F1,
    "F2": KeyCode.F2,
    "F3": KeyCode.F3,
    "F4": KeyCode.F4,
    "F5": KeyCode.F5,
    "F6": KeyCode.F6,
    "F7": KeyCode.F7,
    "F8": KeyCode.F8,
    "F9": KeyCode.F9,
    "F10": KeyCode.F10,
    "F11": KeyCode.F11,
    "F12": KeyCode.F12,
  };

  /// Return all triggers available for this Input.
  List<String> get triggers => keymap.keys.toList();

  /**
   * Creates a new [InputKeyboard].
   */
  InputKeyboard([Map<String, int> keymap = DEFAULT_KEYMAP]) {
    _keyboard = new Keyboard();
    this.keymap = keymap;
  }

  /**
   * Return true if the requested [trigger] is 'triggered', false otherwise.
   */
  bool check(String trigger) {
    return keymap[trigger] != null && _keyboard[keymap[trigger]];
  }
}
